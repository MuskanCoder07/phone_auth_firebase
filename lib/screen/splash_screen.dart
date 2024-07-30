import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/screen/home_page.dart';
import 'package:phone_auth_firebase/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  Future.delayed(Duration (seconds: 15)).then((_) =>checkIsUserAlreadylogin ());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Splach Page")),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
              child: CircularProgressIndicator()
          ),
          SizedBox(height: 80),
          Container(
            height: 250,
              width: 400,
              child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7Rrs_LcQb6p5Ly7nM_3dPmO_c5M6GzpKKdA&s",fit: BoxFit.cover,))
        ],
      ),
    );
  }

  checkIsUserAlreadylogin (){
    var auth = FirebaseAuth.instance;
    if(auth.currentUser == null){
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
    else{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),
    (Route<dynamic> route) => false,
     );
    }
  }
}
