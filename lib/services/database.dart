import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project2/models/profile.dart';
import 'package:project2/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference profilecollection =
      FirebaseFirestore.instance.collection('profile');

  Future updateUserData(String name, String gender, int age) async {
    return await profilecollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'age': age,
    });
  }

  //profile list from snapshot
  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
          name: doc.get('name') ?? '',
          gender: doc.get('gender') ?? 'Male',
          age: doc.get('age') ?? 0);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        gender: snapshot.get('gender'),
        age: snapshot.get('age'));
  }

  //get profile stream
  Stream<List<Profile>> get profile {
    return profilecollection.snapshots().map(_profileListFromSnapshot);
  }

  Stream<UserData> get userData {
    return profilecollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
