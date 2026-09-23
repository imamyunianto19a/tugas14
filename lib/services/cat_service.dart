import 'package:dio/dio.dart';
import '../models/cat_model.dart';

// Networking Service: fungsi fetchData() yang mengembalikan Future<List<Model>>
class CatService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.thecatapi.com/v1/images/search';
  // API key dari akun TheCatAPI (thecatapi.com) supaya rate limit lebih longgar
  static const String _apiKey =
      'live_5uP1Nk5QQgwsLqe6hyoIVQNqJTC3fvguFALsKI3RltvVUThXL6n1DEbBfKq0qLNR';

  // limit: jumlah gambar yang diambil sekaligus (dibuat cukup banyak
  // supaya galeri terlihat penuh / seperti grid wallpaper)
  Future<List<CatModel>> fetchData({int limit = 20}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'limit': limit,
          'size': 'med',
          'mime_types': 'jpg,png',
        },
        options: Options(
          headers: {'x-api-key': _apiKey},
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      final List<dynamic> data = response.data;
      return data.map((json) => CatModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // Error handling: dibedakan supaya pesan ke user lebih jelas
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw Exception('Koneksi internet terputus atau server tidak merespons.');
      } else if (e.response != null) {
        throw Exception('API error (status ${e.response?.statusCode}).');
      } else {
        throw Exception('Terjadi kesalahan saat mengambil data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak terduga: $e');
    }
  }
}
