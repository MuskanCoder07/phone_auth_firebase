// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'databse_hp.dart';
//
// class AddScreen extends StatefulWidget {
//   const AddScreen({super.key});
//
//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }
//
// class _AddScreenState extends State<AddScreen> {
//   String? _image;
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF436878),
//         title: Text(
//           "Add Task",
//           style: TextStyle(
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Color(0xFF436878),
//                         radius: 80,
//                         backgroundImage: _image != null
//                             ? FileImage(File(_image!))
//                             : null,
//                       ),
//                       IconButton(
//                         onPressed: _pickImageFromCamera,
//                         icon: Icon(
//                           Icons.linked_camera,
//                           size: 35,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _titleController,
//                     decoration: InputDecoration(
//                       hintText: "Enter Title",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a title.';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     controller: _descriptionController,
//                     maxLines: 5,
//                     decoration: InputDecoration(
//                       hintText: "Enter Description",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a description.';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   MaterialButton(
//                     minWidth: 400,
//                     height: 40,
//                     shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                     color: Color(0xFF436878),
//                     onPressed: _saveTask,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.save, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           "Save Task",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _pickImageFromCamera() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (image == null) {
//         return;
//       }
//       setState(() {
//         _image = image.path;
//       });
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   Future<void> _saveTask() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (_image == null) {
//         Fluttertoast.showToast(
//           msg: "Image not selected.",
//           backgroundColor: Colors.red,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//         );
//         return;
//       }
//
//       try {
//         Position position = await _getCurrentLocation();
//
//         Map<String, dynamic> newTask = {
//           'title': _titleController.text,
//           'description': _descriptionController.text,
//           'image': _image!,
//           'latitude': position.latitude,
//           'longitude': position.longitude,
//         };
//
//         await DatabaseHelper().insertTask(newTask);
//
//         Fluttertoast.showToast(
//           msg: "Task saved successfully.",
//           backgroundColor: Colors.green,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//         );
//
//         Navigator.of(context).pop();
//       } catch (e) {
//         Fluttertoast.showToast(
//           msg: "Error saving task: $e",
//           backgroundColor: Colors.red,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//         );
//       }
//     }
//   }
// }
