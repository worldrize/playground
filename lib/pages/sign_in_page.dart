import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:playground/app.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> _handleSignIn() async {
    var currentUser = _googleSignIn.currentUser;

    try {
      currentUser ??= await _googleSignIn.signInSilently();
      currentUser ??= await _googleSignIn.signIn();
      if (currentUser == null) return null;

      final googleAuth = await currentUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign in'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 24.0),
            FlatButton(
              onPressed: () => _handleSignIn().then((User user) {
                print(user);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => App(),
                  ),
                );
              }).catchError((e) => print(e)),
              child: Text('SignIn'),
            )
          ],
        ),
      ),
    );
  }
}
