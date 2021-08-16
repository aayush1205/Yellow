import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../common/constants/route_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://i.imgur.com/Z9t75y1.png"),
              fit: BoxFit.cover),
        ),
        child: _isLoggedIn
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Spacer(),
                    Image.network(_userObj?.photoUrl ?? ''),
                    SizedBox(height: 10),
                    ElevatedButton(
                      child: Text("Log Out"),
                      onPressed: () {
                        _googleSignIn.signOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        }).catchError((e) {});
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteList.favorite);
                      },
                      child: Text("Head to App"),
                    ),
                    Spacer()
                  ],
                ),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Spacer(),
                    Center(
                      child: ElevatedButton(
                        child: Text("Login With Google"),
                        onPressed: () {
                          _googleSignIn
                              .signIn()
                              .then((userData) => {
                                    setState(() {
                                      _isLoggedIn = true;
                                      _userObj = userData;
                                    })
                                  })
                              .catchError((e) {
                            print(e);
                          });
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
      ),
    );
  }
}
