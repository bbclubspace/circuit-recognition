import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AiChatServices with ChangeNotifier {
  final List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => List.unmodifiable(_messages);

  void addLoadingMessage() {
    _messages.add({"isUser": false, "isLoading": true});
    notifyListeners();
  }

  void addUserMessage(String message) {
    _messages.add({"message": message, "isUser": true});
    notifyListeners();
  }

  void updateLastMessage(String response) {
    if (_messages.isNotEmpty && _messages.last["isLoading"] == true) {
      _messages.removeLast();
    }
    _messages.add({"message": response, "isUser": false});
    notifyListeners();
  }

  Future<void> sendMessage(String userMessage) async {
    addUserMessage(userMessage);
    addLoadingMessage();

    try {
      String? aiResponse = await fetchAiResult(userMessage);
      updateLastMessage(aiResponse ?? "Üzgünüz, yanıt alınamadı.");
    } catch (e) {
      updateLastMessage("Bir hata oluştu. Lütfen tekrar deneyin.");
    }
  }

  Future<String?> fetchAiResult(String userMessage) async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API anahtarı eksik!");
    }

    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "google/gemma-3-12b-it:free",
          "messages": [
            {
              "role": "user",
              "content": """
Aşağıdaki kullanıcı mesajını değerlendir:
- Eğer mesaj donanım cihazlarıyla (örneğin: bilgisayar parçaları, elektronik bileşenler, sensörler, mikrodenetleyiciler, işlemciler, devre kartları vb.) ilgiliyse, teknik ama kısa ve açıklayıcı bir şekilde yanıtla.
- Eğer mesaj donanımla ilgili değilse, sadece şu yanıtı ver: 'Cevabınız donanım cihazlarıyla ilgili olmadığı için yanıt veremem.'

Mesaj: $userMessage
"""
            }
          ],
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Hatası: ${response.statusCode}");
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      print("AI Response: $decodedBody");

      return data['choices'][0]['message']['content'];
    } catch (e) {
      print('Hata oluştu: $e');
      return null;
    }
  }
}
