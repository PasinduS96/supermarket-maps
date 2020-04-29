import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login/screens/map/map_cmb.dart';
import 'package:login/services/crudService.dart';
import 'package:login/screens/loadingLocations.dart';

class FavouriteList extends StatefulWidget {
  @override
  FavouriteListState createState() {
    return FavouriteListState();
  }
}

class FavouriteListState extends State<FavouriteList> {
  CrudOperations crud = new CrudOperations();
  QuerySnapshot locations;
  List shops;
  String uid;
  bool saved = false;

  Timer timer;

  @override
  void initState() {
    crud.getUid().then((res) {
      uid = res.uid;
    });

    crud.getLocations().then((res) {
      setState(() {
        locations = res;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setShopes();
    });

    super.initState();
  }

  void setShopes() async {
    DocumentReference docRef = Firestore.instance
        .collection('users')
        .document('O1VFsutprnO4NNxapYcO9oCQzZJ3');
    DocumentSnapshot doc = await docRef.get();
    setState(() {
      shops = doc.data['fav'];
      print(shops);
    });
  }

  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shops.length,
      itemBuilder: (context, index) {
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
                    new ListTile(
                      title: Text(
                        shops[index],
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          crud.removeFavourite(shops[index]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.arrow_back),
          iconSize: 40.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          tooltip: 'Favourite List',
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        title: Text(
          'FAVOURITES',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 10.0,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: locations != null ? _buildListView(context) : LoadLocationsScreen(),
    );
  }

  // void _logoutFromHome() {
  //   FirebaseAuth.instance.signOut().then((value) {
  //     Navigator.of(context).pushReplacementNamed('/login');
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   return null;
  // }

}
