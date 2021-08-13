import 'package:cloud_firestore/cloud_firestore.dart';

class InAppUser {
  String _uid = '';
  String _firstName = '';
  String _lastName = '';
  String _nick = '';
  String _city = '';
  String _phone = '';
  String _email = '';
  String _assetsPhoto = '';
  String _urlPhoto = '';
  String _password = '';

  InAppUser({
    String uid = '',
    String firstName = '',
    String lastName = '',
    String nick = '',
    String city = '',
    String phone = '',
    String email = '',
    String assetsPhoto = '',
    String urlPhoto = '',
    String password = '',
  }) {
    _uid = uid;
    _firstName = firstName;
    _lastName = lastName;
    _nick = nick;
    _city = city;
    _phone = phone;
    _email = email;
    _assetsPhoto = assetsPhoto;
    _urlPhoto = urlPhoto;
    _password = password;
  }

  String get uid => _uid;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get nick => _nick;
  String get city => _city;
  String get phone => _phone;
  String get email => _email;
  String get assetsPhoto => _assetsPhoto;
  String get urlPhoto => _urlPhoto;
  String get password => _password;

  set uid(String uidvalue) {
    _uid = uidvalue;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set nick(String value) {
    _nick = value;
  }

  set city(String value) {
    _city = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set email(String value) {
    _email = value;
  }

  set assetsPhoto(String value) {
    _assetsPhoto = value;
  }

  set urlPhoto(String value) {
    _urlPhoto = value;
  }

  set password(String value) {
    _password = value;
  }

  factory InAppUser.fromSnapshot(DocumentSnapshot data) {
    return InAppUser(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data["lastName"],
      nick: data["nick"],
      city: data["city"],
      phone: data["phone"],
      email: data["email"],
      assetsPhoto: data["assetsPhoto"],
      urlPhoto: data["urlPhoto"],
      password: data["password"],
    );
  }
}
