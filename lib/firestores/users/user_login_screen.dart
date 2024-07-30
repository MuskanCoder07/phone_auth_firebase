import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_auth_firebase/firestores/users/user_ragistred_screen.dart';
import 'mixin_class.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> with FireSarviceClass{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(child: Text("Login Page")),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUBmdrixw65q_hcMZeDPTAX4rq7Hxb53t3GgYtVHDjdIzqzAjeTjOJIp1kIR-rprt1HQA&usqp=CAU"),
          SizedBox(height: 20),
          FireSarviceClass().viewTextField(emailController, "Enter your Email", Icon(Icons.email_outlined),"Email"),
          FireSarviceClass().viewTextField(passwordController, "Enter your Password", Icon(Icons.lock_outline),"Password"),
          SizedBox(height: 50),
          MaterialButton(
            color: Colors.lightGreen,
            onPressed: (){
              loginUser();
            },child: Text("Login"),
          ),
          SizedBox(height: 30),
          MaterialButton( color: Colors.lightGreen,
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserRagistredScreen(),));
            },child: Text("Ragistration"),
          ),
        ],
      ),
    );
  }

  loginUser()async{
    var firestore = FirebaseFirestore.instance;
    var exisUser = await firestore.collection("users").where("email", isEqualTo: "mk@gmail.com").get();
    if(exisUser.docs.isNotEmpty) {
      var isvalidUser = exisUser.docs.firstWhere((user) => user.data()['password'] == '1234').exists;
      if (isvalidUser) {
        Fluttertoast.showToast(msg: "Login is successfuly");
      }
    }else{
      Fluttertoast.showToast(msg: "New Email");
    }
  }

}

