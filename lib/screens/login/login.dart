import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/screens/login/resetPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailAddress;
  String passWord;

  bool emalValid = false;
  bool passwordValid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
            child: new Image.asset('images/veg.jpg',
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
                    padding: EdgeInsets.fromLTRB(28.0, 130.0, 0.0, 0.0),
                    child: Text('Find Your',
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(230.0, 75.0, 0.0, 0.0),
                    child: Image.network(
                      'https://drive.google.com/uc?id=1TI4mkUXNSEQyq0i4F5axyChaiZALw0pU',
                      width: 150,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 180.0, 0.0, 0.0),
                    child: Text('Outlet',
                        style: TextStyle(
                            fontSize: 110.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(330.0, 165.0, 0.0, 0.0),
                    child: Text('!',
                        style: TextStyle(
                            fontSize: 130.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700])),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'YOUR EMAIL',
                          errorText: validateEmail(emailAddress, emalValid),
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[700]))),
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          errorText: validatePassword(passWord, passwordValid),
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
                          passWord = value;
                        });
                      },
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Cant remember your password?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(
                                color: Colors.green[700],
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      height: 70.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.green,
                        color: Colors.green[700],
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              emailAddress == null
                                  ? emalValid = true
                                  : emalValid = false;

                              passWord == null
                                  ? passwordValid = true
                                  : passwordValid = false;
                            });

                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailAddress, password: passWord)
                                .then((user) {
                              if (user != null) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                                showToast('Sucessfully Logeed In');
                              }
                            }).catchError((e) {
                              print(e.toString());
                            });
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are You New To Here?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green[700],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(width: 50.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                '',
              ),
            ])
          ]),
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
}
