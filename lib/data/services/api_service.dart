import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({this.baseUrl = ApiConstants.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<List<dynamic>> getMovies() async {
    try {
      final url = Uri.parse(
          '$baseUrl/movie/popular?api_key=${ApiConstants.apiKey}&language=en-US&page=1');

      final response =
          await client.get(url).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null) {
          return data['results'];
        } else {
          throw Exception('Formato inesperado na resposta');
        }
      } else {
        final errorMsg =
            'Erro ao buscar filmes: ${response.statusCode} - ${response.body}';
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return Future.error('Erro na requisição: $e');
    }
  }
}
