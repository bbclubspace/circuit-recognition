import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/imgur-api.dart';

class AiServices with ChangeNotifier {
  final List<String> result = [];
  String imageUrl = "";
  bool isImageUrl = false;
  RxString picture = "".obs;
  RxList idList = [].obs;

  /// Cihaz adları ve olası alternatifleri
  final Map<String, List<String>> deviceKeywords = {
    "Arduino Uno": ["arduino", "arduino uno"],
    "LCD Ekran": ["lcd ekran", "lcd"],
    "Direnç": ["direnç", "resistor"],
    "LED": ["led", "ışık"],
    "Sıcaklık Sensörü": ["sıcaklık sensörü", "ısı sensörü"],
    "Potansiyometre": ["potansiyometre", "pot"],
    "Röle": ["röle", "relay"],
    "Ultrasonik Mesafe Sensörü": ["ultrasonik sensör", "mesafe sensörü"],
    "DHT11/DHT22 Sıcaklık ve Nem Sensörü": ["dht11", "dht22", "nem sensörü", "sıcaklık ve nem sensörü"],
    "HC-SR04 Ultrasonik Mesafe Sensörü": ["hc-sr04", "ultrasonik", "mesafe"],
    "Buzzer": ["buzzer", "ses çıkartıcı"],
    "PIR Hareket Sensörü": ["pir", "hareket sensörü"],
    "Joystick Modülü": ["joystick", "kontrol kolu"],
    "GPS Modülü": ["gps", "gps modülü"],
    "Servo Motor": ["servo", "servo motor"],
    "HC-05 Bluetooth Modülü": ["hc-05", "bluetooth"],
    "RFID Modülü": ["rfid", "rfid okuyucu"],
    "BME280 Sıcaklık, Nem ve Basınç Sensörü": ["bme280", "basınç sensörü", "sıcaklık basınç nem sensörü"],
    "MQ Serisi Gaz Sensörleri": ["gaz sensörü", "mq", "mq-2", "mq-3"],
    "LCD 16x2": ["lcd 16x2", "16x2 ekran"],
    "OLED Ekran": ["oled", "oled ekran"],
    "Motor Sürücü Modülü": ["motor sürücü", "motor driver"],
  };

  bool isResultNotGet = false;

  Future<List<String>> fetchAIWithImage(String imageUrl) async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "meta-llama/llama-4-maverick:free",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "Bu görselde aşağıdaki listedeki elemanlardan hangileri var? Lütfen sadece listede geçen ifadeleri cevap olarak ver:\n\n${deviceKeywords.keys.join(', ')}"
                },
                {
                  "type": "image_url",
                  "image_url": {"url": imageUrl}
                }
              ]
            }
          ],
        }),
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      print("AI Response: $decodedBody");

      final choices = data['choices'];
      if (choices == null || choices.isEmpty) {
        print("❗ Hata: 'choices' boş veya yok.");
        return [];
      }

      final message = choices[0]['message'];
      if (message == null || message['content'] == null) {
        print("❗ Hata: 'message' veya 'content' bulunamadı.");
        return [];
      }

      String aiResponse = message['content'].toLowerCase();

      List<String> foundDevices = [];
      deviceKeywords.forEach((officialName, keywords) {
        for (var keyword in keywords) {
          if (aiResponse.contains(keyword.toLowerCase())) {
            foundDevices.add(officialName);
            break;
          }
        }
      });

      return foundDevices;
    } catch (e, stacktrace) {
      print("❗ fetchAIWithImage Hatası: $e");
      print(stacktrace);
      return [];
    }
  }

  uploadImage(File image) async {
    setIsImageUrl(false);
    var request =
        http.MultipartRequest(Constants.post, Uri.parse(Constants.posturl));
    request.headers["Authorization"] = Constants.clientID;
    var file = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(file);
    var response = await request.send();

    var result = await http.Response.fromStream(response)
        .then((value) => jsonDecode(value.body));

    var data = result["data"];
    idList.add(data["id"]);
    imageUrl = data["link"];
    picture.value = imageUrl;
    setIsImageUrl(true);
    print("Yüklenen resmin URL'si: $imageUrl");
    notifyListeners();
  }

  Future<List<String>> uploadImageAi() async {
    final data = await fetchAIWithImage(imageUrl);
    result.clear();
    print(data);
    result.addAll(data);
    isImageUrl = false;
    notifyListeners();
    return result;
  }

  void setIsResultNotGet(bool value) {
    isResultNotGet = value;
    notifyListeners();
  }

  void setIsImageUrl(bool value) {
    isImageUrl = value;
    notifyListeners();
  }
}
