import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_auth_firebase/firestores/users/user_login_screen.dart';
import 'mixin_class.dart';

class UserRagistredScreen extends StatefulWidget {
  const UserRagistredScreen({super.key});

  @override
  State<UserRagistredScreen> createState() => _UserRagistredScreenState();
}

class _UserRagistredScreenState extends State<UserRagistredScreen> with FireSarviceClass {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Ragistration Page", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.network(
              "https://t3.ftcdn.net/jpg/04/44/31/82/360_F_444318271_h1mVwfiif2HMt2HRSOjj2u0FF10tOHA4.jpg"),
          SizedBox(height: 20),
          FireSarviceClass().viewTextField(
              emailController, "Enter your Email", Icon(Icons.email_outlined),
              "Email"),
          FireSarviceClass().viewTextField(
              passwordController, "Enter your Password",
              Icon(Icons.lock_outline), "Email"),
          SizedBox(height: 50),
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: () {
              ragisterUser();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserLoginScreen(),
              ));
            },
            child: Text(
              "Ragistred", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }

  ragisterUser() async {
    var firestore = FirebaseFirestore.instance;
    var already = await firestore.collection("user").where(
        "email", isEqualTo: "mk@gmail.com").get();
    if (already.docs.isNotEmpty) {
      Fluttertoast.showToast(msg: "Email already done");
    }
    else {
      await firestore.collection("Users").add({
        "Email": "mk@gmail.com",
        "password": "12345",
      });
    }
  }
}

