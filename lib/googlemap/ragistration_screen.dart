// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:phone_auth_firebase/screen/home_page.dart';
// //
// // class RagistrationScreen extends StatefulWidget {
// //   const RagistrationScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<RagistrationScreen> createState() => _RagistrationScreenState();
// // }
// //
// // class _RagistrationScreenState extends State<RagistrationScreen> {
// //
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController passwordController = TextEditingController();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.indigoAccent,
// //         title: Center(child: Text("Registration Authentication",style: TextStyle(color: Colors.white,fontSize: 20),)),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgMxIBAmMPLrGvXGPDKhOaqE-m61IYEXwJgUTS1JeMznvnzqd9DW7wywzKnvMeg_sD0o8&usqp=CAU"),
// //             SizedBox(height: 40),
// //             TextField(
// //               controller: emailController,
// //               decoration: InputDecoration(
// //                 hintText: "Email",
// //                 icon: Icon(Icons.email,color: Colors.indigoAccent,),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 30),
// //             TextField(
// //               controller: passwordController,
// //               decoration: InputDecoration(
// //                 hintText: "Password",
// //                 icon: Icon(Icons.lock,color: Colors.indigoAccent,),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //               ),
// //               // obscureText: true,
// //             ),
// //             SizedBox(height: 20),
// //             MaterialButton(
// //               color: Colors.indigoAccent,
// //               onPressed: () {
// //                 String email = emailController.text.trim();
// //                 String password = passwordController.text.trim();
// //                 if (email.isNotEmpty && password.isNotEmpty) {
// //                   registration(email, password);
// //                 } else {
// //                   Fluttertoast.showToast(msg: "Please enter email and password");
// //                 }
// //               },
// //               child: Text("Registration",style: TextStyle(color: Colors.white,fontSize: 18)),
// //               // style: ElevatedButton.styleFrom(
// //               // ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void registration(String email, String password) async {
// //     try {
// //       UserCredential userCredential =
// //       await _auth.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //       if (userCredential.user != null) {
// //         Fluttertoast.showToast(msg: "Registration successful");
// //         Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage() ,));
// //       } else {
// //         Fluttertoast.showToast(msg: "Registration failed");
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: "Error: $e");
// //     }
// //   }
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'LocationScreen.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> _storeCurrentLocation(String userId) async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );
//     Placemark place = placemarks.first;
//
//     await _firestore.collection('users').doc(userId).collection('locations').add({
//       'latitude': position.latitude,
//       'longitude': position.longitude,
//       'address': place.street,
//       'locality': place.locality,
//       'subAdministrativeArea': place.subAdministrativeArea,
//       'administrativeArea': place.administrativeArea,
//       'postalCode': place.postalCode,
//       'country': place.country,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Color(0xff7896975474778),
//         title: const Text('RAGISTRASTION FORM',style: TextStyle(fontWeight: FontWeight.bold),),),
//       body: SingleChildScrollView(
//         child: Container(
//           height: 800,
//           width: 450,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage("https://images.unsplash.com/photo-1503455637927-730bce8583c0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bG9naW4lMjBiYWNrZ3JvdW5kJTIwaW1hZ2V8ZW58MHx8MHx8fDA%3D"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: 40,),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _emailController,
//                   decoration:  InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                       prefixIcon: const Icon(Icons.email),
//                       labelText: 'Email'
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _passwordController,
//                   decoration:  InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       prefixIcon: const Icon(Icons.lock),
//                       labelText: 'Password'),
//                   obscureText: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text("Ragister your Business"),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 300),
//                 child: TextButton(
//                   onPressed: _register,
//                   child: const Text('Sin Up',style: TextStyle(color: Colors.black,fontSize: 20),)
//                 ),
//               ),
//               // ElevatedButton(
//               //   onPressed: _register,
//               //   child: const Text('Login'),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _register() async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       await _storeCurrentLocation(userCredential.user!.uid);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LocationScreen(userId: userCredential.user!.uid),
//         ),
//             (route) => false, // This will remove all previous routes from the stack
//       );
//     }
//     catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
//
// }

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:phone_auth_firebase/screen/home_page.dart';
//
// class RagistrationScreen extends StatefulWidget {
//   const RagistrationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RagistrationScreen> createState() => _RagistrationScreenState();
// }
//
// class _RagistrationScreenState extends State<RagistrationScreen> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigoAccent,
//         title: Center(child: Text("Registration Authentication",style: TextStyle(color: Colors.white,fontSize: 20),)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgMxIBAmMPLrGvXGPDKhOaqE-m61IYEXwJgUTS1JeMznvnzqd9DW7wywzKnvMeg_sD0o8&usqp=CAU"),
//             SizedBox(height: 40),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: "Email",
//                 icon: Icon(Icons.email,color: Colors.indigoAccent,),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 hintText: "Password",
//                 icon: Icon(Icons.lock,color: Colors.indigoAccent,),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               // obscureText: true,
//             ),
//             SizedBox(height: 20),
//             MaterialButton(
//               color: Colors.indigoAccent,
//               onPressed: () {
//                 String email = emailController.text.trim();
//                 String password = passwordController.text.trim();
//                 if (email.isNotEmpty && password.isNotEmpty) {
//                   registration(email, password);
//                 } else {
//                   Fluttertoast.showToast(msg: "Please enter email and password");
//                 }
//               },
//               child: Text("Registration",style: TextStyle(color: Colors.white,fontSize: 18)),
//               // style: ElevatedButton.styleFrom(
//               // ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void registration(String email, String password) async {
//     try {
//       UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (userCredential.user != null) {
//         Fluttertoast.showToast(msg: "Registration successful");
//         Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage() ,));
//       } else {
//         Fluttertoast.showToast(msg: "Registration failed");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'LocationScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _storeCurrentLocation(String userId) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks.first;

    await _firestore.collection('users').doc(userId).collection('locations').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': place.street,
      'locality': place.locality,
      'subAdministrativeArea': place.subAdministrativeArea,
      'administrativeArea': place.administrativeArea,
      'postalCode': place.postalCode,
      'country': place.country,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        title: const Text('RAGISTRASTION FORM',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Image.network("https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg"),
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  prefixIcon: const Icon(Icons.email,color: Colors.black,),
                  labelText: 'Email'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _passwordController,
              decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                  labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: TextButton(
                  onPressed: _register,
                  child: const Text('Sinup',style: TextStyle(color: Colors.blue,fontSize: 20),)
              ),
            ),
            // ElevatedButton(
            //   onPressed: _register,
            //   child: const Text('Login'),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await _storeCurrentLocation(userCredential.user!.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(userId: userCredential.user!.uid),
        ),
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

