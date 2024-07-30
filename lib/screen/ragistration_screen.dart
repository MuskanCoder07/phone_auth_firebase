import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_auth_firebase/screen/home_page.dart';

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({Key? key}) : super(key: key);

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Center(child: Text("Registration Authentication",style: TextStyle(color: Colors.white,fontSize: 28),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgMxIBAmMPLrGvXGPDKhOaqE-m61IYEXwJgUTS1JeMznvnzqd9DW7wywzKnvMeg_sD0o8&usqp=CAU"),
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                icon: Icon(Icons.email,color: Colors.indigoAccent,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                icon: Icon(Icons.lock,color: Colors.indigoAccent,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              // obscureText: true,
            ),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.indigoAccent,
              onPressed: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  registration(email, password);
                } else {
                  Fluttertoast.showToast(msg: "Please enter email and password");
                }
              },
              child: Text("Registration",style: TextStyle(color: Colors.white,fontSize: 18)),
              // style: ElevatedButton.styleFrom(
              // ),
            ),
          ],
        ),
      ),
    );
  }

  void registration(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Fluttertoast.showToast(msg: "Registration successful");
        Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage() ,));
      } else {
        Fluttertoast.showToast(msg: "Registration failed");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }
}
