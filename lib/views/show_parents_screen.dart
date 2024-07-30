import 'package:flutter/material.dart';
import 'add_parents_screen.dart';

class ShowParentsScreen extends StatelessWidget {
  const ShowParentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(child: Text("List Of Parents")),
      ),
      body: Column(
        children: [

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddParentsScreen()),
          );
        },
        child: Text("Add"),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class ShowParentsScreen extends StatefulWidget {
//   const ShowParentsScreen({super.key});
//
//   @override
//   State<ShowParentsScreen> createState() => _ShowParentsScreenState();
// }
//
// class _ShowParentsScreenState extends State<ShowParentsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Parent Screen",
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: Colors.orangeAccent,
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//             stream: _firestore.collection("Parent").snapshots(),
//             builder: (context, parentSnapshot) {
//               if (parentSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               if (parentSnapshot.hasError) {
//                 return Center(child: Text('Error: ${parentSnapshot.error}'));
//               }
//
//               if (!parentSnapshot.hasData || parentSnapshot.data!.docs.isEmpty) {
//                 return Center(child: Text("No Parents Found"));
//               }
//
//               final parentDocs = parentSnapshot.data!.docs;
//
//               return ListView.builder(
//                 itemCount: parentDocs.length,
//                 itemBuilder: (context, index) {
//                   var parentData = parentDocs[index].data() as Map<String, dynamic>;
//                   var parentId = parentDocs[index].id;
//
//                   return Card(
//                     margin: EdgeInsets.all(10),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Name: ${parentData['name']}',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           Text(
//                             'Email: ${parentData['email']}',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           SizedBox(height: 10),
//                           StreamBuilder<QuerySnapshot>(
//                             stream: _firestore
//                                 .collection("Child")
//                                 .where('parentId', isEqualTo: parentId)
//                                 .snapshots(),
//                             builder: (context, childSnapshot) {
//                               if (childSnapshot.connectionState == ConnectionState.waiting) {
//                                 return Center(child: CircularProgressIndicator());
//                               }
//
//                               if (childSnapshot.hasError) {
//                                 return Center(child: Text('Error: ${childSnapshot.error}'));
//                               }
//
//                               if (!childSnapshot.hasData || childSnapshot.data!.docs.isEmpty) {
//                                 return Center(child: Text("No Children Found"));
//                               }
//
//                               final childDocs = childSnapshot.data!.docs;
//
//                               return ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: childDocs.length,
//                                 itemBuilder: (context, childIndex) {
//                                   var childData = childDocs[childIndex].data() as Map<String, dynamic>;
//
//                                   return ListTile(
//                                     title: Text('Child Name: ${childData['name']}'),
//                                     subtitle: Text('Child Age: ${childData['age']}'),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//         ),
//     );
//   }
// }

