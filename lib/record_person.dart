import 'package:cloud_firestore/cloud_firestore.dart';

class RecordPerson{

  int userID ;
  String name ;
  String surname ;
  bool staff;
  String job ;
  String phone ;
  String email ;
  String assetsPhoto ;
  String urlPhoto ;
  String password ;
  DocumentReference reference;



  //   int userID = -1;
  // String name = '';
  // String surname = '';
  // bool staff = false;
  // String job = '';
  // String phone = '';
  // String email = '';
  // String assetsPhoto = '';
  // String urlPhoto = '';
  // String password = '';
  // DocumentReference reference;

  // RecordPerson(this.userID = 0,
  //     this.name = '',
  //     this.surname = '',
  //     this.staff = false,
  //     this.job = '',
  //     this.phone = '',
  //     this.email = '',
  //     this.assetsPhoto = '',
  //     this.urlPhoto = '',
  //     this.password = '',
  //     reference
  //     );




  RecordPerson(this.userID ,
      this.name,
      this.surname ,
      this.staff ,
      this.job ,
      this.phone ,
      this.email ,
      this.assetsPhoto ,
      this.urlPhoto,
      this.password ,
     this. reference
      );

      factory RecordPerson.fromSnapshot(DocumentSnapshot data){
        return RecordPerson(data[''],
        data['name'],
        data['surname'],
        data['staff'],
        data['job'],
        data['phone'],
        data['email'],
        data['assetsPhoto'],
        data['urlPhoto'],
        data['password'],
        data.reference

        );

      }
  
}