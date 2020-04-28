import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';

class ManageUser {
  storeNewUser(user, context) {
    Firestore.instance
        .collection('users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/home');
    }).catchError((e) {
      print(e);
    });
  }
}
