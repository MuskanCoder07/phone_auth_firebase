import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  var userId = "";
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    _getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(child: Text("User Detail")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Enter your name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
           SizedBox( height: 10,),
          Text("Device Id :$userId"),
          SizedBox( height: 10,),
          ElevatedButton(
              onPressed: () {
                Navigator.push( context, MaterialPageRoute( builder: (_) => ChatScreen(
                    UserName: nameController.text, UserId: userId
                  )
                 )
                );
              },
              child: const Text("Add First Name")
          )
        ],
      ),
    );
  }

  Future<String?> _getId() async {
    var userdetais = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDevice = await userdetais.androidInfo;
      userId = androidDevice.id;
      setState(() {});
    }
    return null;
  }
}