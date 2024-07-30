import 'package:flutter/material.dart';

import '../firestores/users/mixin_class.dart';
import 'add_students_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> with FireSarviceClass{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightGreen, title: Text("List Of Students"),),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsScreens(),));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lime,
      ),
    );
  }
}
