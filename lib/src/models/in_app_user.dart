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
    this._uid = uid;
    this._firstName = firstName;
    this._lastName = lastName;
    this._nick = nick;
    this._city = city;
    this._phone = phone;
    this._email = email;
    this._assetsPhoto = assetsPhoto;
    this._urlPhoto = urlPhoto;
    this._password = password;
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
}
