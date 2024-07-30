import 'package:cloud_firestore/cloud_firestore.dart';

class firestoresarvice {
  Future<String> parentData(String name, String email, int phone, String gender) async {
    var doc =
    await FirebaseFirestore.instance.collection("parentsAddData").add({
      "name": name,
      "email": email,
      "phone": phone,
      "gender": gender,
    });
    return doc.id;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    var inatance = FirebaseFirestore.instance;
    var data = inatance.collection("parentsAddData").snapshots();
    return data;
  }

  studentData(String name, int age, String address,String ) async {
    FirebaseFirestore.instance.collection("childrenData").add({
      "studentname": name,
      "studentage": age,
      "studentaddress":address,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChildData(String parentId) {
    var inatance = FirebaseFirestore.instance;
    var data = inatance
        .collection("childrenData")
        .where("chilsprentid", isEqualTo: parentId)
        .snapshots();
    return data;
    }
}

