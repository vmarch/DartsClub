class StaffList {
  final List<Map> _staffList = [];

  StaffList() {
    inflateList();
  }

  void inflateList() {
    _staffList.add({
      'name': 'Maria',
      'surName': 'Tormann',
      'job': 'Feel-Good-Managerin',
      'phone': '0171/50584',
      'email': 'maria_tormann@stich.de',
      'assetsPhoto': 'personsphoto/david-bares-816.jpeg',
      'urlPhoto': 'https://images.pexels.com/users/avatars/42311/david-bares-816.jpeg?auto=compress&fit=crop&h=256&w=256'
    });

    _staffList.add({
      'name': 'Manfred',
      'surName': 'Mustermann',
      'job': 'Buchhaltung',
      'phone': '0176/55454',
      'email': 'manfred_musterman@email.de',
      'assetsPhoto': 'personsphoto/profil_maria.png',
      'urlPhoto': ''
    });

    _staffList.add({
      'name': 'Hannes',
      'surName': 'Mauer',
      'job': 'Vorstand',
      'phone': '0141/54585',
      'email': 'hannes_mauer@stich.de',
      'assetsPhoto': 'personsphoto/profil_hannes.png',
      'urlPhoto': ''
    });
  }

  List<Map> getStaffList() {
    return _staffList;
  }
}
