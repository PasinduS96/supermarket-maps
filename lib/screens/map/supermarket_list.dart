import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/map/map_cmb.dart';
import 'package:login/services/crudService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:login/screens/loadingLocations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuperMarketLists extends StatefulWidget {
  @override
  SuperMarketListState createState() {
    return SuperMarketListState();
  }
}

class SuperMarketListState extends State<SuperMarketLists> {
  CrudOperations crud = new CrudOperations();
  QuerySnapshot locations;
  QuerySnapshot users;
  String uid;
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.list),
          iconSize: 40.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/favlist');
          },
          tooltip: 'Favourite List',
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        title: Text(
          'LOCATIONS',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 10.0,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacementNamed('/login');
                showToast('User Logged Out');
              }).catchError((e) {
                print(e);
              });
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: locations != null ? _buildListView(context) : LoadLocationsScreen(),
    );
  }

  @override
  void initState() {
    crud.getLocations().then((res) {
      if (res == null) {
        progressDialog.show();
      } else {
        setState(() {
          locations = res;
        });
      }
    });

    crud.getUid().then((res) {
      uid = res.uid;
    });
    super.initState();
  }

  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: locations.documents.length,
      itemBuilder: (context, index) {
        bool saved = false;
        return new Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0,
              ),
            ]),
            child: new Card(
              child: new InkWell(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new ClipRRect(
                      child: new Image.network(
                        locations.documents[index].data['image'],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: new Radius.circular(16.0),
                        topRight: new Radius.circular(16.0),
                      ),
                    ),
                    new ListTile(
                      title: Text(
                        locations.documents[index].data['city'],
                      ),
                      leading: IconButton(
                        icon: Icon(
                          saved ? Icons.favorite : Icons.favorite_border,
                          color: saved ? Colors.red : null,
                        ),
                        alignment: Alignment.centerRight,
                        onPressed: () async {
                          print(saved);
                          DocumentReference docRef = Firestore.instance
                              .collection('users')
                              .document('$uid');
                          DocumentSnapshot doc = await docRef.get();
                          List shops = doc.data['fav'];
                          if (shops.contains(
                                  locations.documents[index].data['city']) ==
                              false) {
                            crud.addFavourite(
                              locations.documents[index].data['city'],
                            );
                            saved = true;
                          } else {
                            crud.removeFavourite(
                                locations.documents[index].data['city']);
                            saved = false;
                          }
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyMap(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ));
      },
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
