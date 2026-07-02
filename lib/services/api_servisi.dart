import 'package:dio/dio.dart';
import '../models/haber_model.dart';

class ApiServisi {
  final Dio _dio = Dio();
  
  // KENDİ ŞİFRENİ BURAYA YAPIŞTIR:
  final String _apiKey = "e38c371881c444fe9a63a3d4895a1885"; 
  final String _baseUrl = "https://newsapi.org/v2";

  Future<List<Haber>> haberleriGetir({String kategori = "general"}) async {
    try {
      print("--- API ISTEGI BASLADI ---"); // Ajan 1
      
      final response = await _dio.get(
        "$_baseUrl/top-headlines",
        queryParameters: {
          "country": "us", // GARANTİ OLSUN DİYE AMERİKA HABERLERİNİ ÇEKİYORUZ
          "category": kategori,
          "apiKey": _apiKey,
        },
      );

      print("--- API CEVAP VERDİ: ${response.statusCode} ---"); // Ajan 2
      
      if (response.statusCode == 200) {
        List<dynamic> makaleler = response.data['articles'];
        print("--- BULUNAN HABER SAYISI: ${makaleler.length} ---"); // Ajan 3
        
        return makaleler.map((json) => Haber.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      // EĞER API BİZİ GİZLİCE REDDEDİYORSA SEBEBİNİ BURADA GÖRECEĞİZ
      if (e is DioException) {
        print("!!! DIO HATASI: ${e.response?.statusCode} !!!");
        print("!!! HATA DETAYI: ${e.response?.data} !!!");
      } else {
        print("!!! BİLİNMEYEN HATA: $e !!!");
      }
      return [];
    }
  }
}