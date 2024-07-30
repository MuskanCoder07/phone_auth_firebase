import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfScreen extends StatefulWidget {
  const pdfScreen({super.key});

  @override
  State<pdfScreen> createState() => _pdfScreenState();
}

class _pdfScreenState extends State<pdfScreen> {
  List<File> pdf = <File>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,
        title: Center(child: Text("Pdg Screen")),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {}, child: Icon(Icons.add),),
      body: StreamBuilder(
          stream: getUploadPdfs(),
          builder: (context, snapshot) {
            var pdfs = snapshot.data?.docs;
            if (pdfs?.isNotEmpty == true) {
              return ListView.builder(
                  itemCount: pdfs?.length,
                  itemBuilder: (_, index) {
                    return showpdfView(pdfs![index].data()['url']);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  takeMultiImage() async {
    FilePickerResult? pikerImage = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['Pdf','png','video'],
    );
    if (pikerImage != null) {
      var file = pikerImage.files.map((path) => File(path.path!)).toList();
      for (var multiImage in file) {
        uploadPdf(multiImage);
        print(multiImage.path);
      }
      // setState(() {
      //   image.addAll(file);
      // });
      print(file.first.path);
    } else {}
  }

// selectPdfFile()async{
//   var result = await FilePicker.platform.pickFiles(
//     allowMultiple: true,type: FileType.custom, allowedExtensions: ["PDF","Video","png","mp4"]);
//     if(result != null){
//       var file = result.files.map((path) => File(path.path!)).toList();
//       for(var singliFile in pdf){
//         uploadPdf(singliFile);
//         print(singliFile.path);
//       }
//       print(file.first.path);
//     }
//   }

  uploadPdf(File file){
    var storage = FirebaseStorage.instance;
    storage.ref("profileImage").child(file.path.split("/").last).putFile(file).then((value)async{
      var pdfUrl = await value.ref.getDownloadURL();
      print(pdfUrl);
      FirebaseFirestore.instance.collection("pdfs").add({"Url":pdfUrl});
      Fluttertoast.showToast(msg: "pdf upload");
    });

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadPdfs(){
    var instance = FirebaseFirestore.instance.collection("pdfs");
    return instance.snapshots();
  }

  showpdfView(String pdfPath){
    return SizedBox( height: 400,child: SfPdfViewer.network(pdfPath),);
  }
}