import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 12),
        ),
      );
      await _remoteConfig.setDefaults({
        'country_code_test': 'in',
      });
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Failed to initialize Remote Config: $e');
    }
  }

  String get countryCodeTest => _remoteConfig.getString('country_code_test');
  String get newsApiKey => _remoteConfig.getString('news_api_key');
}
