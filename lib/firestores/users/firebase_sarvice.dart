// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:phone_auth_firebase/firestores/users/user_login_screen.dart';
// import 'Home_Screen.dart';
//
// class firestoreSarvice{
//
//    late BuildContext context;
//
//   checkIsUserAlreadylogin (){
//     var auth = FirebaseAuth.instance;
//     if(auth.currentUser == null){
//       Navigator.pushAndRemoveUntil(
//         context, MaterialPageRoute(builder: (context) => HomeScreen()),
//             (Route<dynamic> route) => false,
//       );
//     }
//     else{
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserLoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStores {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String email, String password) async {
    try {
      var doc = await _firestore.collection("usersauth").doc(email).get();
      if (doc.exists) {
        throw Exception("User already exists");
      }
      await _firestore.collection("usersauth").doc(email).set({
        "usersEmail": email,
        "usersPassword": password,
      });
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      var doc = await _firestore.collection("usersauth").doc(email).get();
      if (doc.exists) {
        var data = doc.data();
        return data?["usersPassword"] == password;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error logging in user: $e");
    }
  }
}


