import 'package:flutter/foundation.dart';
import 'package:tapfirst/models/news_response.dart';
import 'package:tapfirst/services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NewsArticle> get articles => _articles;
  void setArticles(List<NewsArticle> articles) {
    _articles = articles;
    notifyListeners();
  }

  Future<void> storeNews(String countryCode, String apiKey) async {
    _isLoading = true;
    notifyListeners();
    try {
      _articles = await _newsService.fetchNews(countryCode, apiKey);
    } catch (e) {
      debugPrint('Error while storing news in provider : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
