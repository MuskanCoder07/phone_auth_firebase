import 'package:flutter/material.dart';

class UserShowDetails extends StatefulWidget {
  const UserShowDetails({super.key});

  @override
  State<UserShowDetails> createState() => _UserShowDetailsState();
}

class _UserShowDetailsState extends State<UserShowDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descripsionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent, title: Center(child: Text("USER DETAIL FORM")),),
      body: Column(
        children: [
          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrW6DhsYXIgKh6zjTl7R1ZmQHlm_EPMy6MzA&s"),
          Center(child: Text("WELCOME TO MY RESTURENT")),
          TextField(decoration: InputDecoration(hintText: "Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
          TextField(decoration: InputDecoration(hintText: "Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
          TextField(decoration: InputDecoration(hintText: "Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
          MaterialButton(onPressed: (){

          },child: Text("Click the Location"),),
          MaterialButton(onPressed: (){},child: Text("SAVE"),)
        ],
      ),
    );
  }
}
