import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  File? _image;
  String _name = '';
  String _firstName = '';
  String _email = '';
  String _birthday = '';
  String _pin = '';
  String _phoneNumber = '';
  String _phoneCode = '';
  String _countryCode = '';
  String _photoUrl = '';
  String _id = ''; // ID de l'utilisateur
  bool _isAuthenticated = false; // Propriété d'authentification

  UserModel();

  File? get image => _image;
  String get name => _name;
  String get firstName => _firstName;
  String get email => _email;
  String get birthday => _birthday;
  String get pin => _pin;
  String get phoneNumber => _phoneNumber;
  String get phoneCode => _phoneCode;
  String get countryCode => _countryCode;
  String get photoUrl => _photoUrl;
  String get id => _id; // Getter pour l'ID
  bool get isAuthenticated => _isAuthenticated; // Getter pour l'état d'authentification

  void setUser({
    String? id,
    String? name,
    String? firstName,
    String? email,
    String? birthday,
    String? pin,
    String? phoneNumber,
    String? phoneCode,
    String? countryCode,
    String? photoUrl,
  }) {
    if (id != null) _id = id;
    if (name != null) _name = name;
    if (firstName != null) _firstName = firstName;
    if (email != null) _email = email;
    if (birthday != null) _birthday = birthday;
    if (pin != null) _pin = pin;
    if (phoneNumber != null) _phoneNumber = phoneNumber;
    if (phoneCode != null) _phoneCode = phoneCode;
    if (countryCode != null) _countryCode = countryCode;
    if (photoUrl != null) _photoUrl = photoUrl;
    _isAuthenticated = true; // L'utilisateur est considéré comme authentifié après l'appel de cette méthode
    notifyListeners();
    saveUserData(); // Sauvegarder les données après les avoir mises à jour
  }

  void logout() {
    _pin = '';
    _photoUrl = '';
    _isAuthenticated = false; // Mettez l'état d'authentification à false
    notifyListeners();
  }

  void setPhoneInfo({String? phoneNumber, String? phoneCode, String? countryCode}) {
    if (phoneNumber != null) _phoneNumber = phoneNumber;
    if (phoneCode != null) _phoneCode = phoneCode;
    if (countryCode != null) _countryCode = countryCode;
    saveUserData();
    notifyListeners();
  }

  Future<void> loadUserData() async {
    try {
      if (_id.isNotEmpty) {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(_id).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          _name = data['name'] ?? '';
          _firstName = data['firstName'] ?? '';
          _email = data['email'] ?? '';
          _birthday = data['birthday'] ?? '';
          _pin = data['pin'] ?? '';
          _phoneNumber = data['phoneNumber'] ?? '';
          _phoneCode = data['phoneCode'] ?? '';
          _countryCode = data['countryCode'] ?? '';
          _photoUrl = data['photoUrl'] ?? '';
          _isAuthenticated = true;
          notifyListeners();
        }
      }
    } catch (e) {
      // message d'erreur
    }
  }

  Future<void> saveUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _name,
          'firstName': _firstName,
          'email': _email,
          'birthday': _birthday,
          'pin': _pin,
          'phoneNumber': _phoneNumber,
          'phoneCode': _phoneCode,
          'countryCode': _countryCode,
          'photoUrl': _photoUrl,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      // message d'erreur
    }
  }

  Future<void> updatePhoneInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': _name,
          'firstName': _firstName,
          'email': _email,
          'birthday': _birthday,
          'pin': _pin,
          'phoneNumber': _phoneNumber,
          'phoneCode': _phoneCode,
          'countryCode': _countryCode,
          'photoUrl': _photoUrl,
        });
      }
    } catch (e) {
      // message d'erreur
    }
  }
}