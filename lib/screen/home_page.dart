import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/screen/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(child: Text("HomePage")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
                width: 500,
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy_nPpphEWcOX4wWMzbK2OW6fsaWlipK29ig&s",fit: BoxFit.cover,)),
          ),
          SizedBox(height: 40),
          MaterialButton(
            color: Colors.orangeAccent,
              onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen(),));
            FirebaseAuth.instance.signOut();
            var auth = FirebaseAuth.instance;
            if (auth.currentUser == null) {
              auth.signOut();
            }
          }, child: Text("Sing out")),
        ],
      ),
    );
  }
}

