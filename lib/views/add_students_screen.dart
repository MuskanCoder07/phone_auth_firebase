import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firestores/users/mixin_class.dart';
import 'class_parent_student.dart';

class AddStudentsScreens extends StatefulWidget {
  var parentId;
  AddStudentsScreens({super.key,required this.parentId});

  @override
  State<AddStudentsScreens> createState() => _AddStudentsScreensState();
}

class _AddStudentsScreensState extends State<AddStudentsScreens> with FireSarviceClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  var data = firestoresarvice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, title: Text("Student Add Screen"),),
      body: Column(
        children: [
          viewTextField(nameController, "name", Icon(Icons.person), "name"),
          viewTextField(ageController, "age", Icon(Icons.person), "age"),
          viewTextField(addressController, "address", Icon(Icons.person), "address"),

          MaterialButton(color: Colors.lightGreen, onPressed: () {
            // data.studentData(nameController.text, int.parse(ageController.text),addressController.text)
          }, child: Text("Add Student"),)
        ],
      ),
    );
  }
}

// MaterialButton(
          //   color: Colors.teal,
          //   onPressed: () async{
          //     await _firestore.collection("Student").add({
          //       "name":"Muskan",
          //       "email":"m@gmail.com",
          //       "parentId": widget.id
          //     });
          //     // addStudent(widget.id);
          //   },child: Text("students list"),
          // )

 // Future<void> addStudent(String id)async{
 //     await _firestore.collection("Student").add({
 //      "name":"Muskan",
 //      "email":"m@gmail.com"
 //    });
 //    // return studentId.id;
 //  }
// }


