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
  bool isImageUrl=false;
  RxString picture = "".obs;
  RxList idList = [].obs;
  List<String> predefinedDevices = [
    'Arduino Uno',
    'LCD Ekran',
    'Direnç',
    'LED',
    'Sıcaklık Sensörü',
    'Potansiyometre',
    'Röle',
  ];
  bool isResultNotGet = false;

  

  Future<List<String>> fetchAIWithImage(String imageUrl) async {
  final apiKey = dotenv.env['OPENROUTER_API_KEY_2'];
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
                    "Bu görseldeki devre elemanlarının ana adlarını sadece listele. Detaylara girme. Örnek: Arduino Uno, LCD Ekran, Direnç, LED, Sıcaklık Sensörü."
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

    // Güvenli veri okuma
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

    String aiResponse = message['content'];

    List<String> foundDevices = [];
    for (String device in predefinedDevices) {
      if (aiResponse.contains(device)) {
        foundDevices.add(device);
      }
    }

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
    var file = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );
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
