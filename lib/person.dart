class Person {
  int userID;
  String name;
  String surName;
  bool staff;
  String job;
  String phone;
  String email;
  String assetsPhoto;
  String urlPhoto;
  String password;

  Person(
      [this.userID = 0,
      this.name = '',
      this.surName = '',
      this.staff = false,
      this.job = '',
      this.phone = '',
      this.email = '',
      this.assetsPhoto = '',
      this.urlPhoto = '',
      this.password = '']);

  getBaseUser() {
    userID = 1;
    name = 'Manfred';
    surName = 'Mustermann';
    staff = true;
    job = 'Buchhaltung';
    phone = '+49777777777';
    email = 'manfred_musterman@email.de';
    urlPhoto =
        'https://images.pexels.com/users/avatars/42311/david-bares-816.jpeg?auto=compress&fit=crop&h=256&w=256';
    assetsPhoto = 'personsphoto/david-bares-816.jpeg';
    password = 'Rtertdr43!!ooP';
  }
}
