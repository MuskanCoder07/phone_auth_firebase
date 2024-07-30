// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'c_class.dart';
// import 'c_update_screen.dart';
//
// class ShowdataScreen extends StatefulWidget {
//   const ShowdataScreen({Key? key}) : super(key: key);
//
//   @override
//   _ShowdataScreenState createState() => _ShowdataScreenState();
// }
//
// class _ShowdataScreenState extends State<ShowdataScreen> {
//   List<Map<String, dynamic>> costamerData = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   void fetchData() async {
//     try {
//       CostmerFireStore firestore = CostmerFireStore();
//       List<Map<String, dynamic>> data = await firestore.getData();
//       setState(() {
//         costamerData = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to load data';
//         isLoading = false;
//       });
//     }
//   }
//
//   final CostmerFireStore _firestoreService = CostmerFireStore();
//
//   Future<void> _deleteItem(String docId) async {
//     try {
//       await _firestoreService.deleteData(docId);
//       setState(() {
//         costamerData.removeWhere((item) => item['id'] == docId);
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to delete item: $e'),
//         ),
//       );
//     }
//   }
//
//   void deleteCostmarData(String docId) async {
//     try {
//       var fires = FirebaseFirestore.instance;
//       var costmar = fires.collection("costamars");
//       await costmar.doc(docId).delete();
//       setState(() {
//         costamerData.removeWhere((item) => item['id'] == docId);
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to delete item: $e'),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "ShowData",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.indigo,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : costamerData.isEmpty
//           ? Center(child: Text("No data available"))
//           : ListView.builder(
//         itemCount: costamerData.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Card(
//               elevation: 4,
//               shadowColor: Colors.blueGrey,
//               color: Colors.white,
//               child: ListTile(
//                 title: Text(costamerData[index]["name"].toString()),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Address: ${costamerData[index]['address']}"),
//                     Text("Order: ${costamerData[index]['order']}"),
//                   ],
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => UpdateScreen(
//                               documentId: costamerData[index]['id'],
//                               name: costamerData[index]['name'],
//                               address: costamerData[index]['address'],
//                               order: costamerData[index]['order'],
//                             ),
//                           ),
//                         );
//                       },
//                       icon: Icon(Icons.edit),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         deleteCostmarData(costamerData?[index]['id']);
//                       },
//                       icon: Icon(Icons.delete),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }