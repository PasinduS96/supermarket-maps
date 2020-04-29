import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String emails;

  bool emalValid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
            child: new Image.asset('images/pass.jpg',
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
                    padding: EdgeInsets.fromLTRB(5.0, 80.0, 0.0, 0.0),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          fontSize: 95.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(250.0, 95.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(155.0, 180.0, 0.0, 0.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 220.0, 0.0, 0.0),
                    child: Text(
                      'Enter Your Email Address To Reset Password',
                      style: TextStyle(fontSize: 15.0),
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
                              });

                              if (!emalValid) {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: emails)
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                  showToast(
                                      'Your Password Reset Link Has Been Sent To $emails');
                                }).catchError((e) {
                                  print(e);
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                'Send Email Link',
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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0);
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
}
