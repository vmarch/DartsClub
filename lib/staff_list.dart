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
      'assetphoto': 'personsphoto/david-bares-816.jpeg',
      'urlphoto': 'https://images.pexels.com/users/avatars/42311/david-bares-816.jpeg?auto=compress&fit=crop&h=256&w=256'
    });

    _staffList.add({
      'name': 'Manfred',
      'surName': 'Mustermann',
      'job': 'Buchhaltung',
      'phone': '0176/55454',
      'email': 'manfred_musterman@email.de',
      'assetphoto': 'personsphoto/profil_maria.png',
      'urlphoto': ''
    });

    _staffList.add({
      'name': 'Hannes',
      'surName': 'Mauer',
      'job': 'Vorstand',
      'phone': '0141/54585',
      'email': 'hannes_mauer@stich.de',
      'assetphoto': 'personsphoto/profil_hannes.png',
      'urlphoto': ''
    });
  }

  List<Map> getStaffList() {
    return _staffList;
  }
}
