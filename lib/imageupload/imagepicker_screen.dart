// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class SecondPage extends StatefulWidget {
//   const SecondPage({super.key});
//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }
//
// class _SecondPageState extends State<SecondPage> {
//   String? _image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           children: [
//             _image != null?
//             CircleAvatar(
//                 radius: 100,
//                 backgroundImage: FileImage(File(_image.toString()))
//             ):
//             CircleAvatar(
//               radius: 100,
//               backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL0CfBMNii4BfDy_eerLEBv1tYl916bMGrnQ&usqp=CAU"),
//             ),
//             Positioned(
//                 bottom: -15,
//                 left: 140,
//                 child: IconButton(
//                   onPressed: (){
//                     showImagePickerOption(context);
//                   },icon: Icon(Icons.photo,size: 50,color: Colors.pinkAccent,),))
//           ],
//         ),
//       ),
//     );
//   }
//   void showImagePickerOption(BuildContext context){
//     showModalBottomSheet(
//       // backgroundColor: colors.blue[10],
//         context: context, builder: (builder){
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height/4.5,
//           child: Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                   onTap: (){
//                     _pickImageFromCamera();
//                   },
//                   child: SizedBox(
//                     child: Column(
//                       children: [
//                         Icon(Icons.camera_alt_outlined,size: 80,color: Colors.black87,),Text("Camera",style: TextStyle(fontSize: 15,color: Colors.black54),)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                   onTap: (){
//                     _pickImageFromGallery();
//                   },
//                   child: SizedBox(
//                     child: Column(
//                       children: [
//                         Icon(Icons.image_outlined,size: 70,color: Colors.black87,),Text("Gallery",style: TextStyle(fontSize: 15,color: Colors.black54),),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   //Gallery
//   Future _pickImageFromGallery() async {
//     var  selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = selectedImage?.path;
//     });
//     Navigator.of(context).pop();
//   }
//
// //Camera
//
//   Future _pickImageFromCamera() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.camera);
//     if(image == null) return;
//     setState(() {
//       _image = image.path;
//     });
//     Navigator.of(context).pop();
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagepickerScreen extends StatefulWidget {
//   const ImagepickerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ImagepickerScreen> createState() => _ImagepickerScreenState();
// }
//
// class _ImagepickerScreenState extends State<ImagepickerScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   XFile? imagefile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff90873092),
//         title: Center(
//           child: Text("Image Picker", style: TextStyle(color: Colors.white)),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20.0),
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               imagefile == null
//                   ? Image.network(
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8t_tSeYuPGzdY9bjjX4eV-Td0O6sHCAGRvA&s",
//                       fit: BoxFit.cover,
//                       height: 250,
//                       width: 250,
//                     )
//                   : Image.file(File(imagefile!.path)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: takeImage,
//                 child: Text("Take Camera"),
//               ),
//               MaterialButton(
//                   shape: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide.none),
//                   color: Color(0xff90873092),
//                   height: 50,
//                   onPressed: takeImage,
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Image from Gallery",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 19),
//                       )
//                     ],
//                   )
//                   // child: Text("Pick from Gallery"),
//                   ),
//               SizedBox(height: 20),
//               MaterialButton(
//                   shape: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide.none),
//                   color: Color(0xff90873092),
//                   height: 50,
//                   onPressed: pickImageFromGallery,
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.mail,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Image from Gallery",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 19),
//                       )
//                     ],
//                   )
//                   // child: Text("Pick from Gallery"),
//                   ),
//               SizedBox(height: 20),
//               MaterialButton(
//                   shape: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide.none),
//                   color: Color(0xff90873092),
//                   height: 50,
//                   onPressed: UploadImage(nameController.text, emailController.text),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.upload,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Upload Image",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 19),
//                       )
//                     ],
//                   )
//                   // child: Text("Pick from Gallery"),
//                   ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   hintText: "Name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   hintText: "Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void takeImage() async {
//     var imagepicker = ImagePicker();
//     var imageclick = await imagepicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imagefile = imageclick;
//     });
//   }
//
//   void pickImageFromGallery() async {
//     var imagepicker = ImagePicker();
//     var imageclick = await imagepicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       imagefile = imageclick;
//     });
//   }
//
//   void UploadImage(String name, String email) async {
//     if (imagefile == null) {
//       return;
//     }
//     final storageref = FirebaseStorage.instance.ref();
//     storageref
//         .child('image/${DateTime.now().millisecondsSinceEpoch}.jpg')
//         .putFile(File(imagefile!.path))
//         .then((task) async {
//       final downloadUrl = await task.ref.getDownloadURL();
//       await FirebaseFirestore.instance.collection('storeData').add({
//         "name": name,
//         "email": email,
//         "imageUrl": downloadUrl,
//       });
//     });
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  XFile? imageFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("PROFILE")),
        ),
        body: isLoading ? const Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: takeImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.pinkAccent,
                    backgroundImage: imageFile == null? null : FileImage(File(imageFile?.path??"")),
                    child: imageFile== null? Icon(Icons.photo_camera_back_outlined,size: 50,color: Colors.white,):null,
                  ),
                ),
                SizedBox(height: 20,),
                TextField(controller: nameController,
                  decoration: InputDecoration(labelText: "name"),
                ),
                SizedBox(height: 20,),
                TextField(controller: emailController,
                  decoration: InputDecoration(labelText: "email"),
                ),
                SizedBox(height: 20,),
                TextField(controller: phoneController,
                  decoration: InputDecoration(labelText: "phone"),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: uploadImage,
                    child: Text("Submit"))
              ],

            ),
          ),
        )
    );
  }
  takeImage()async{
    try {
      var imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = image!;
      });
    }catch(e){
      Fluttertoast.showToast(msg: "Error picking image$e");
    }
  }
  var imageUrl = "";

  uploadImage()async{
    if(imageFile == null || nameController.text.isEmpty||emailController.text.isEmpty||phoneController.text.isEmpty){
      Fluttertoast.showToast(msg: "please complete all fields and upload images");
      return;
    }

    setState(() {
      isLoading = true;
    });
    try{
      var storage =FirebaseStorage.instance;
      var storageRef = storage.ref("image").child(imageFile?.name??"");
      storageRef.putFile(File(imageFile!.path)).then((p0)async{
        imageUrl = await p0.ref.getDownloadURL();
        setState(() {

        });
      });

      var firestor = FirebaseFirestore.instance;
      await firestor.collection("users").add({
        "name": nameController.text,
        "email":emailController.text,
        "phone":phoneController.text,
        "imageUrl":imageUrl
      });
      Fluttertoast.showToast(msg: "data Upload successfully");
    } catch(e){
      Fluttertoast.showToast(msg: "Error Uploading data$e");
    }finally{
      setState(() {
        isLoading = false;
        });
    }
  }

}
