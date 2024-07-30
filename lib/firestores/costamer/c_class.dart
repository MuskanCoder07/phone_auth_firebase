// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CostmerFireStore {
//   final CollectionReference _collection = FirebaseFirestore.instance.collection('users_data');
//
//   Future<void> addData( String name, String address, String order) async {
//     await _collection.add({
//       'name': name,
//       "address": address,
//       "order": order
//     });
//   }
//
//   Stream<List<Map<String, dynamic>>> getData() {
//     return _collection.orderBy('name').snapshots().map((querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         var data = doc.data() as Map<String, dynamic>;
//         data['id'] = doc.id;
//         return data;
//       }).toList();
//     });
//   }
//
//   Future<void> deleteData(String docId) async {
//     await _collection.doc(docId).delete();
//   }
// }

// display_users.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserScreen extends StatelessWidget {
  final String genderFilter;
  const GetUserScreen({super.key, required this.genderFilter });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.indigo[800],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("Users").where('gender',isEqualTo: genderFilter).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          var users = snapshot.data!.docs.toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index].data();
              return Card(
                child: ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['gender']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showMyBottomSheet(context, users[index].id, user);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteUser(users[index].id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showMyBottomSheet(BuildContext context, String docId, Map<String, dynamic> userData) {
    var editNameController = TextEditingController(text: userData['name']);
    var editEmailController = TextEditingController(text: userData['email']);
    var editAgeController = TextEditingController(text: userData['age'].toString());
    var editGenderController = TextEditingController(text: userData['gender']);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: editNameController,
                decoration: InputDecoration(
                  labelText: 'Edit Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: editEmailController,
                decoration: InputDecoration(
                  labelText: 'Edit Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: editAgeController,
                decoration: InputDecoration(
                  labelText: 'Edit Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: editGenderController,
                decoration: InputDecoration(
                  labelText: 'Edit Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                onPressed: () async {
                  await updateUsers(
                    docId,
                    editNameController.text,
                    editEmailController.text,
                    editAgeController.text,
                    editGenderController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          ),
        );
      },
    );
  }

  updateUsers(String docId, String name, String email, String age, String gender) async {
    var firestore = FirebaseFirestore.instance;
    var users = firestore.collection("Users");
    await users.doc(docId).update({
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
    });
  }

  deleteUser(String docId) async {
    var firestore = FirebaseFirestore.instance;
    var users = firestore.collection("Users");
    await users.doc(docId).delete();
  }
}
