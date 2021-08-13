import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';

class UsersProvider {
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future updateUserData(
    String uid,
    String firstName,
    String lastName,
    String nick,
    String city,
    String phone,
    String email,
    String assetsPhoto,
    String urlPhoto,
    String password,
  ) async {
    Map<String, dynamic> user = Map<String, dynamic>();
    user["uid"] = uid;
    user["firstName"] = firstName;
    user["lastName"] = lastName;
    user["nick"] = nick;
    user["city"] = city;
    user["phone"] = phone;
    user["email"] = email;
    user["assetsPhoto"] = assetsPhoto;
    user["urlPhoto"] = urlPhoto;
    user["password"] = password;

    return await db
        .doc(uid)
        .set(user)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateUserFromUserItem(InAppUser inAppUser) async {
    Map<String, dynamic> user = Map<String, dynamic>();
    user["uid"] = inAppUser.uid;
    user["firstName"] = inAppUser.firstName;
    user["lastName"] = inAppUser.lastName;
    user["nick"] = inAppUser.nick;
    user["city"] = inAppUser.city;
    user["phone"] = inAppUser.phone;
    user["email"] = inAppUser.email;
    user["assetsPhoto"] = inAppUser.assetsPhoto;
    user["urlPhoto"] = inAppUser.urlPhoto;
    user["password"] = inAppUser.password;

    return await db
        .doc(inAppUser.uid)
        .set(user)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<InAppUser?> getCurrentUserFromFireBase(String uid) async {
    DocumentSnapshot snapshot = await db.doc(uid).get();
    if (snapshot['uid'] != null) {
      return InAppUser.fromSnapshot(snapshot);
    } else {
      return null;
    }
  }
}
