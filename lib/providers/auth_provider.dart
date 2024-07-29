import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  void setIsSignedIn() {
    _isSignedIn = true;
    notifyListeners();
  }

  void setIsSignedOut() {
    _isSignedIn = false;
    notifyListeners();
  }
}
