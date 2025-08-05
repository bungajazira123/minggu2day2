import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:statemanagement/models/quran_model.dart';

class QuranServices {
  static const String quranUrl = 'https://api.npoint.io/99c279bb173a6e28359c/data';

  static Future<List<QuranModel>> fetchQuran() async {
    final response = await http.get(Uri.parse(quranUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => QuranModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal Load Data Album');
    }
  }
}
