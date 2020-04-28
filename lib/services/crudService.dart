import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudOperations {
  bool isLogIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  getLocations() async {
    return await Firestore.instance.collection('locations').getDocuments();
  }

  getSupermarkets() async {
    return await Firestore.instance.collection('supermarkets').getDocuments();
  }

  addFavourite(String city) {
    Firestore.instance.collection('users').getDocuments().then((userlist) {
      FirebaseAuth.instance.currentUser().then((value) {
        userlist.documents.forEach((element) {
          if (element.data['uid'] == value.uid) {
            Firestore.instance
                .collection('users')
                .document(element.documentID)
                .updateData({
              'fav': FieldValue.arrayUnion([city])
            });
          }
        });
      });
    });
  }

  removeFavourite(String city) {
    Firestore.instance.collection('users').getDocuments().then((userlist) {
      FirebaseAuth.instance.currentUser().then((value) {
        userlist.documents.forEach((element) {
          if (element.data['uid'] == value.uid) {
            Firestore.instance
                .collection('users')
                .document(element.documentID)
                .updateData({
              'fav': FieldValue.arrayRemove([city])
            });
          }
        });
      });
    });
  }

  getUid() {
    return FirebaseAuth.instance.currentUser();
  }

  getUsers(String uid) async {
    DocumentReference docRef = Firestore.instance
        .collection('users')
        .document('O1VFsutprnO4NNxapYcO9oCQzZJ3');
    DocumentSnapshot doc = await docRef.get();
    List arr = doc.data['fav'];
    return arr;
  }
  // print(array);

}
