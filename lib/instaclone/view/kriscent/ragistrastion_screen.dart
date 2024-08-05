import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RagistrastionScreen extends StatefulWidget {
  const RagistrastionScreen({super.key});

  @override
  State<RagistrastionScreen> createState() => _RagistrastionScreenState();
}

class _RagistrastionScreenState extends State<RagistrastionScreen> {

  String? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hgh"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF436878),
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!))
                          : null,
                      child: _image == null
                          ? const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ) : null,
                    ),
                    IconButton(
                      onPressed: _pickImageFromCamera,
                      icon: const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(decoration: InputDecoration(hintText: "Enter Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(decoration: InputDecoration(hintText: "Enter Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(decoration: InputDecoration(hintText: "Enter Phone", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MaterialButton(onPressed: (){},child: Text("Sign Up"),),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text("Already have an account?"),
                    Text("Login Here"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      setState(() {
        _image = image.path;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
   }
  }

