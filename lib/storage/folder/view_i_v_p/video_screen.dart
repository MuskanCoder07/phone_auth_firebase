import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? selectedImage;
  List<File> image = <File>[];
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..initialize().then((value) {
        setState(() {});
      });
    //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Video Screen"),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.teal, onPressed: (){
        takeMultiImage();
      },child: Icon(Icons.add),),
      body: StreamBuilder(
        stream: getUploadedImage(),
        builder: (context, snapshot) {
          var imageD = snapshot.data?.docs;
          if (imageD?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: imageD?.length,
              itemBuilder: (context, index) {
                return
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: VideoPlayer(videoPlayerController),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  videoPlayerController.play();
                                },
                                child: const Text("Start")),
                            ElevatedButton(
                                onPressed: () {
                                  if (videoPlayerController.value.isPlaying) {
                                    videoPlayerController.pause();
                                  }
                                },
                                child: const Text("pause"))
                          ],
                        ),
                      ),
                    ],
                  );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  takeMultiImage() async {
    FilePickerResult? pikerImage = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (pikerImage != null) {
      var file = pikerImage.files.map((path) => File(path.path!)).toList();
      for (var multiImage in file) {
        uploadImage(multiImage);
        print(multiImage.path);
      }
      // setState(() {
      //   image.addAll(file);
      // });
      print(file.first.path);
    } else {}
  }

  uploadImage(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("FOLDER-IMAGE")
        .child(file.path.split("/").last)
        .putFile(File(file.path))
        .then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
      FirebaseFirestore.instance.collection("image").add({"url": imageUrl});
      Fluttertoast.showToast(msg: "image uploaded");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedImage() {
    var instance = FirebaseFirestore.instance.collection("image");
    return instance.snapshots();
  }
}

