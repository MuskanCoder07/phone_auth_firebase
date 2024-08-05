// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'e-shop_home_screen.dart';
// import 'e-shop_ragistration_screen.dart';
//
// class EshopLoginScreen extends StatefulWidget {
//   const EshopLoginScreen({super.key});
//
//   @override
//   State<EshopLoginScreen> createState() => _EshopLoginScreenState();
// }
//
// class _EshopLoginScreenState extends State<EshopLoginScreen> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "e-Shope",
//           style: TextStyle(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 260),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   hintText: "Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   hintText: "Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 obscureText: true,
//               ),
//             ),
//             const SizedBox(height: 220),
//             MaterialButton(
//               shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               height: 50,
//               minWidth: 200,
//               color: Colors.indigo,
//               onPressed: _login,
//               child: const Text(
//                 "Login",
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("New here? ", style: TextStyle(color: Colors.black)),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const EshopRegistrationScreen()),
//                     );
//                   },
//                   child: const Text(
//                     "Signup",
//                     style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _login() async {
//     String email = emailController.text;
//     String password = passwordController.text;
//
//     if (email.isEmpty || password.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Please enter email and password",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       return;
//     }
//
//     _showLoadingDialog();
//
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       User? user = userCredential.user;
//
//       if (user != null) {
//         DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
//         String name = userDoc['name'];
//
//         Fluttertoast.showToast(
//           msg: "Login Successful",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//
//         Navigator.pop(context); // Dismiss the loading dialog
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => EshopHomeScreen()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context); // Dismiss the loading dialog
//       String errorMessage;
//       if (e.code == 'user-not-found') {
//         errorMessage = "No user found for that email.";
//       } else if (e.code == 'wrong-password') {
//         errorMessage = "Wrong password provided for that user.";
//       } else {
//         errorMessage = "An error occurred. Please try again.";
//       }
//       Fluttertoast.showToast(
//         msg: errorMessage,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } catch (e) {
//       Navigator.pop(context); // Dismiss the loading dialog
//       Fluttertoast.showToast(
//         msg: "An error occurred. Please try again.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }
//
//   void _showLoadingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/eshop-project/viewscreen/e-shop_provider.dart';

import 'e-shop_ragistration_screen.dart';

class EshopLoginScreen extends StatefulWidget {
  const EshopLoginScreen({super.key});

  @override
  State<EshopLoginScreen> createState() => _EshopLoginScreenState();
}

class _EshopLoginScreenState extends State<EshopLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "e-Shope",
          style: TextStyle(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 260),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
              ),
            ),
            const SizedBox(height: 220),
            MaterialButton(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              height: 50,
              minWidth: 200,
              color: Colors.indigo,
              onPressed: (){
                AuthProviderServicesEshop().signIn(emailController.text, passwordController.text);
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("New here? ", style: TextStyle(color: Colors.black)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const EshopRegistrationScreen()),
                    );
                  },
                  child: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

