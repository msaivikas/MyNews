import 'package:tapfirst/models/news_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews(String countryCode, String apiKey) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/top-headlines?country=$countryCode&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      NewsResponse newsResponse = NewsResponse.fromJson(data);
      return newsResponse.articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
