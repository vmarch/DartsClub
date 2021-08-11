class Person {
  int userID = -1;
  String name = '';
  String surname = '';
  bool staff = false;
  String job = '';
  String phone = '';
  String email = '';
  String assetsPhoto = '';
  String urlPhoto = '';
  String password = '';

  Person(
      [this.userID = 0,
      this.name = '',
      this.surname = '',
      this.staff = false,
      this.job = '',
      this.phone = '',
      this.email = '',
      this.assetsPhoto = '',
      this.urlPhoto = '',
      this.password = '']);
      

  Person.dummmyPerson() {
    userID = 2;
    name = 'Max';
    surname = 'Mustermann';
    staff = true;
    job = 'Buchhaltung';
    phone = '+49777777777';
    email = 'max_musterman@email.de';
    assetsPhoto = 'david-bares-816.jpeg';
    urlPhoto =
        'https://images.pexels.com/users/avatars/42311/david-bares-816.jpeg?auto=compress&fit=crop&h=256&w=256';

    password = 'Rtertdr43!!ooP';
  }
}
