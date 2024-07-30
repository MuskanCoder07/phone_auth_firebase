import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      return user;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Icon(Icons.group_off_outlined,color: Colors.white,),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Google Sign-In", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child:
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: MaterialButton(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            color: Colors.teal,
            onPressed: () async {
              User? user = await _signInWithGoogle();
              if (user != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Profile Information'),
                    content: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY2JPsrPVd_lsy-hptSrsIwWwYQMWql7Aw-w&s")
                        ),
                        SizedBox(height: 20),
                        if (user.photoURL != null)
                          Image.network(user.photoURL!),
                        SizedBox(height: 8),
                        Text('Name: ${user.displayName ?? "No name"}'),
                        SizedBox(height: 4),
                        Text('Email: ${user.email ?? "No email"}'),
                      ],
                    ),
                    actions:[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      TextButton(
                          onPressed: () async{
                            await _auth.signOut();
                            await googleSignIn.signOut();
                            Navigator.of(context).pop();
                          }, child: Text("Sing Out")
                      )
                    ],
                  ),
                );
              }
              else {
                print('Login failed.');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxz_rSaQtZPEfuwx_AW6sKZZBmBbkZ6zHKog&s",height: 60,width: 50,),
                Text('Sign in with Google'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

