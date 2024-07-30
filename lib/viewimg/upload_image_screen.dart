import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? selectedImage;
  List<File>? multipalFile = <File>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
            child: Text(
              "UploadImage",
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                height: 140,
                width: 300, color: Colors.cyan,
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.contain,)
                    : Icon(Icons.image),
              )),
          MaterialButton(
              color: Colors.cyan,
              onPressed: () {
                takeSingleFile();
              },
              child: Text("Single Image")),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20),
              itemCount: multipalFile!.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.file(multipalFile![index]);
              },
            ),
          ),
          MaterialButton(
              color: Colors.cyan,
              onPressed: () {
                takeMaltiFile();
              },
              child: Text("Maltipal Image")),
          MaterialButton(
              color: Colors.cyan,
              onPressed: () {
                // uploadAllImage();
              }, child: Text("ShowAll Image"))
        ],
      ),
    );
  }

  takeSingleFile() async {
    FilePickerResult? pickImage = await FilePicker.platform.pickFiles();
    if (pickImage != null) {
      setState(() {
        selectedImage = File(pickImage.files.single.path!);
      });
      uploadImage(selectedImage!);
    }
  }

  takeMaltiFile() async {
    FilePickerResult? fileResult =
    await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      var files = fileResult.files.map((file) => File(file.path!)).toList();
      setState(() {
        multipalFile?.addAll(files);
      });
      for (var file in files) {
        uploadImage(file);
      }
    }
  }

  uploadImage(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("Upload-Image")
        .child(file.path
        .split("/")
        .last)
        .putFile(file)
        .then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
      Fluttertoast.showToast(msg: "Image Upload");
    });
  }
}

//   uploadAllImage()async{
//     if(selectedImage != null){
//       await uploadImage(selectedImage!);
//     }
//     for(var files in multipalFile!){
//       uploadImage(files);
//     }
//     Fluttertoast.showToast(msg: "UPLOAD IMAGE");
//   }
// }
//   try {
//     var files = await FilePicker.
//     // var image = await imagePicker.pickImage(source: ImageSource.gallery);
//     // setState(() {
//     //   File = image!;
//     // });
//   } catch(e){
//     Fluttertoast.showToast(msg: "Error picking image$e");
//   }
// }
