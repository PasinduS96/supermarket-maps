import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String emails;
  String passwords;
  String userName;

  bool emalValid = false;
  bool userValid = false;
  bool passwordValid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
            child: new Image.asset('images/map.jpg',
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
                color: Color.fromRGBO(255, 255, 255, 0.2),
                colorBlendMode: BlendMode.modulate),
          ),
          new Column(children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(25.0, 80.0, 0.0, 0.0),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(270.0, 95.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(175.0, 180.0, 0.0, 0.0),
                    child: Text(
                      '& Enjoy Our Service',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          hintText: 'test@testmail.com',
                          errorText: validateEmail(emails, emalValid),
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[700]))),
                      onChanged: (value) {
                        setState(() {
                          emails = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD ',
                          hintText: '8 - 30 Characters',
                          errorText: validatePassword(passwords, passwordValid),
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[700]))),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          passwords = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'USER NAME ',
                          hintText: 'user1234',
                          errorText:
                              userValid ? 'User Name Can Not Be Empty' : null,
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[700]))),
                      onChanged: (value) {
                        setState(() {
                          userName = value;
                        });
                      },
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 60.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(30.0),
                          shadowColor: Colors.green,
                          color: Colors.green[700],
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                emails == null
                                    ? emalValid = true
                                    : emalValid = false;
                                userName == null
                                    ? userValid = true
                                    : userValid = false;
                                passwords == null
                                    ? passwordValid = true
                                    : passwordValid = false;
                              });

                              if (!emalValid && !passwordValid) {
                                try {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emails, password: passwords)
                                      .then((userData) {
                                    print(userData);
                                    Firestore.instance
                                        .collection('users')
                                        .document(userData.user.uid)
                                        .setData({
                                      'email': emails,
                                      'user': userName,
                                      'uid': userData.user.uid,
                                      'fav': []
                                    });
                                    Navigator.of(context).pop();
                                    showToast('User registered with $emails');
                                  }).catchError((e) {
                                    showToast(e.message);
                                  });
                                } catch (e) {
                                  showErrorToastMessage(e);
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 60.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '',
                          ),
                        ])
                  ],
                )),
          ])
        ])));
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String validatePassword(String password, bool valid) {
    String text;
    if (!valid) {
      if (password != null) {
        if (password.length > 0 && password.length < 8) {
          text = 'Length Should Be 8 - 30 Characters';
        } else if (password.length > 30) {
          text = 'Length Exceeded';
        }
      }
    } else if (valid) {
      text = 'Enter Password';
    }
    return text;
  }

  String validateEmail(String email, bool valid) {
    String output;
    if (!valid) {
      if (email != null && email.length > 0) {
        if (!EmailValidator.validate(email)) {
          output = 'Email do not valid format';
        }
      }
    } else if (valid) {
      output = 'Enter Email Address';
    }

    return output;
  }

  void showErrorToastMessage(String error) {
    if (error
        .contains('The email address is already in use by another account')) {
      error = 'o user found with this email.';
    }
    showToast(error);
  }
}
