import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ContentServices extends ChangeNotifier {
  List<String> resultList = [];
  List<String> removedItems = [];
  List<String> updatedResultList = [];
  List<Map<String, String>> projectProposals = [];

  void setResults(List<String> results) {
    resultList = results;
    removedItems = [];
    updateResultList();
    notifyListeners();
  }

  void toggleItem(String item) {
    if (removedItems.contains(item)) {
      removedItems.remove(item);
    } else {
      removedItems.add(item);
    }
    updateResultList();
    notifyListeners();
  }

  bool isRemoved(String item) {
    return removedItems.contains(item);
  }

  void updateResultList() {
    updatedResultList =
        List.from(resultList.where((item) => !removedItems.contains(item)));
    notifyListeners();
  }

  Future<String?> projectProposal() async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API anahtarı eksik!");
    }

    final validItems =
        updatedResultList.isNotEmpty ? updatedResultList : resultList;
    final itemsAsString = validItems.join(", ");

    final prompt = '''
Aşağıdaki malzemeleri kullanarak yapılabilecek 5 kısa proje önerisi ver. Her biri sadece başlık ve kısa açıklama içersin. Şu formatta yaz:

- Başlık: ...
  Açıklama: ...

Malzemeler: $itemsAsString
''';

    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "google/gemini-2.5-flash-preview",
          "max_tokens": 1000,
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ],
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Hatası: ${response.statusCode}");
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      print("API Response: $decodedBody");
      final data = jsonDecode(decodedBody);

      final choices = data['choices'];
      if (choices == null || choices.isEmpty) {
        throw Exception("API'den geçerli veri gelmedi!");
      }

      final content = choices[0]['message']?['content'];
      if (content == null) {
        throw Exception("API'den geçerli içerik gelmedi!");
      }

      // 🔍 Proje önerilerini ayrıştır (regex yok, satır satır)
      projectProposals.clear();
      final lines = content.split('\n');
      String? currentTitle;
      String? currentDescription;

      for (var line in lines) {
        line = line.trim();
        if (line.startsWith('- Başlık:')) {
          currentTitle = line.replaceFirst('- Başlık:', '').trim();
        } else if (line.startsWith('Açıklama:')) {
          currentDescription = line.replaceFirst('Açıklama:', '').trim();
        }

        if (currentTitle != null && currentDescription != null) {
          projectProposals.add({
            'title': currentTitle,
            'description': currentDescription,
          });
          currentTitle = null;
          currentDescription = null;
        }
      }

      print("Gelen Projeler: $projectProposals");
      notifyListeners();
      return content;
    } catch (e) {
      print('Hata oluştu: $e');
      return null;
    }
  }
}
