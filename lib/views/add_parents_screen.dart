import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firestores/users/mixin_class.dart';
import 'add_students_screen.dart';

class AddParentsScreen extends StatefulWidget {
  const AddParentsScreen({super.key});

  @override
  State<AddParentsScreen> createState() => _AddParentsScreenState();
}

class _AddParentsScreenState extends State<AddParentsScreen> with FireSarviceClass{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.orangeAccent, title: Text("Parent Add Screen"),),
      body: Column(
        children: [
          viewTextField(nameController, "name", Icon(Icons.perm_contact_cal), "name"),
          viewTextField(emailController, "email", Icon(Icons.email_outlined), "email"),
          viewTextField(phoneController, "phone", Icon(Icons.phone), "phone"),
          viewTextField(genderController, "gender", Icon(Icons.g_translate), "gender"),
          // MaterialButton(
          //   color: Colors.green,
          //   onPressed: ()async{
          //     var doc =  await _firestore.collection("parent").add({
          //       "name":"Ram",
          //       "email":"r@gmail.com"
          //     });
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsScreens(id: doc.id),));
          //   },child: Text("parents list"),
          // )
          MaterialButton(color: Colors.orangeAccent, onPressed: (){

            Navigator.pop(context);
          },child: Text("Add Parent"),)
        ],
      ),
    );
  }

}

