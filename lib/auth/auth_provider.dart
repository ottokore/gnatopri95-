import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dassi/auth/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final UserModel _userModel;

  User? get user => _user;

  AuthProvider(this._userModel) {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(String phoneNumber, String phoneCode, String countryCode, Function(String) codeSent, BuildContext context) async {
    _userModel.setPhoneInfo(phoneNumber: phoneNumber, phoneCode: phoneCode, countryCode: countryCode);
    await _userModel.saveUserData();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to verify phone number: ${e.message}')));
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithOTP(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
