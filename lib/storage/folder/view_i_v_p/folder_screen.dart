import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_auth_firebase/storage/folder/view_i_v_p/pdf_screen.dart';
import 'package:phone_auth_firebase/storage/folder/view_i_v_p/video_screen.dart';

import 'image_screen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  var folders = <Map>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(child: Text("Folder Page")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          CreateNewFolderDialog();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: getFolders(),
          builder: (context, snapshot) {
            var folders = snapshot.data?.docs;
            if (snapshot.hasData) {
              return folders!.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (_, index) {
                        return ListTile(
                          onTap: () {
                            gotoNexScreen(folders[index]["type"]);
                          },
                          leading: Icon(Icons.folder,color: Colors.orangeAccent,),
                          trailing: Icon(Icons.delete,color: Colors.orangeAccent,),
                           title: Text(folders[index]['name']),
                          subtitle: Text(folders[index]['type']),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: folders.length)
                  : Center(
                      child: Text("I Have No Folder"),
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  var foldertype = ["Pdf", "Image", "Video"];
  var selected = "";
  TextEditingController foldernameController = TextEditingController();

  CreateNewFolderDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Create Floder"),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  DropdownButtonFormField(
                      items: foldertype
                          .map((type) => DropdownMenuItem(
                                child: Text(type),
                                value: type,
                              ))
                          .toList(),
                      onChanged: (type) {
                        selected = type ?? "";
                      }),
                  SizedBox(height: 20),
                  TextField(
                    controller: foldernameController,
                    decoration: InputDecoration(
                        hintText: "folder name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    addFolder();
                    foldernameController.clear();
                    selected = '';
                    Navigator.pop(context);
                  },
                  child: Text("add")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cencel"))
            ],
          );
        });
  }

  gotoNexScreen(String type) {
    if (type == foldertype[0]) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => pdfScreen(),));
    } else if (type == foldertype[1]) {
     Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(),));
    } else {
       Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(),));
    }
  }

  addFolder() async {
    await FirebaseFirestore.instance.collection("folders").add(
        {"name": foldernameController.text, "type": selected}).then((value) {
      Fluttertoast.showToast(msg: "Folder Create");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolders() {
    return FirebaseFirestore.instance.collection("folders").snapshots();
  }
}
