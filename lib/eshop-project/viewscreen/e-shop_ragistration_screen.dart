import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'e-shop_home_screen.dart';
import 'e-shop_login_screen.dart';

class EshopRegistrationScreen extends StatefulWidget {
  const EshopRegistrationScreen({super.key});

  @override
  State<EshopRegistrationScreen> createState() => _EshopRegistrationScreenState();
}

class _EshopRegistrationScreenState extends State<EshopRegistrationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("e-Shope",style: TextStyle(color: Colors.indigo,fontSize: 25,fontWeight: FontWeight.bold),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 160,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name", border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email", border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password", border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))
                  )
              ),
            ),
            SizedBox(height: 200),
            MaterialButton(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              height: 50,
              minWidth: 250,
              color: Colors.indigo,
              onPressed: _register,
              child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style: TextStyle(color: Colors.black),),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login ", style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter all fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
        });

        Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EshopHomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      } else {
        errorMessage = "An error occurred. Please try again.";
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
