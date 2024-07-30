// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'mixin_class.dart';
//
// class UpdateScreen extends StatefulWidget {
//   final String? documentId;
//   final String? name;
//   final String? address;
//   final String? order;
//
//   const UpdateScreen({
//     Key? key,
//      this.documentId,
//      this.name,
//      this.address,
//      this.order,
//
//   }) : super(key: key);
//
//   @override
//   _UpdateScreenState createState() => _UpdateScreenState();
// }
//
// class _UpdateScreenState extends State<UpdateScreen> with FirestoreClass{
//   late TextEditingController nameController;
//   late TextEditingController addressController;
//   late TextEditingController orderController;
//
//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.name);
//     addressController = TextEditingController(text: widget.address);
//     orderController = TextEditingController(text: widget.order);
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }
//
//   void updateData() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('your_collection_name')
//           .doc(widget.documentId)
//           .update({
//         'name': nameController.text,
//         'address': addressController.text,
//         'order': orderController.text,
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Data updated successfully'),
//       ));
//
//       Navigator.of(context).pop();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to update data: $e'),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Center(child: Text("Update")),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             viewTextField(nameController, "Enter your Name", Icon(Icons.note_alt_outlined),"Name" ),
//             viewTextField(addressController, "Enter your Address", Icon(Icons.note_alt_outlined),"Address" ),
//             viewTextField(orderController, "Enter your Order", Icon(Icons.note_alt_outlined),"Order" ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: (){
//                 Navigator.pop(context);
//               },
//               child: Text('Update Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
