import 'package:flutter/foundation.dart';

class FirebaseRemoteConfigProvider extends ChangeNotifier {
  String _newsApiKey = '';
  String _countryCode = '';

  String get newsApiKey => _newsApiKey;
  String get countryCode => _countryCode;

  void setNewsApiKey(String apiKey) {
    _newsApiKey = apiKey;
    notifyListeners();
  }

  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }
}
