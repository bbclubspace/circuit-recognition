import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String post = "POST";
  static const String posturl = "https://api.imgur.com/3/upload";
  static const String baseurl = "https://i.imgur.com/";
  static const String ext = ".jpeg";
  static final String id = dotenv.env['IMAGEUR_API_ID'] ?? "";
  static final String clientID = "Client-ID $id";
}
