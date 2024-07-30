import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<File> image = <File>[];
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightGreen, title: Center(child: Text("Upload Screen")),),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){

              }, child: Text(" take file")
          )
        ],
      ),
    );
  }
  takeFile()async{
    var fileresult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(fileresult != null){
      var files = fileresult.files.map((path)=> File(path.path!)).toList();
      for(var singliFile in files){
        var a = singliFile.path.split(".").last;
        if(a == "jpg" || a == "png"){
        }
        print("Extenstion: $a");
        image.add(singliFile);
      }
      setState(() {

      });
    }
  }

  uploadImage(File file){
    var storage = FirebaseStorage.instance;
    storage.ref("profileImaages").child(file.path.split("/").last).putFile(file).then((value)async{
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
    });

  }
}
