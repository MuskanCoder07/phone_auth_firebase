

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAddCartScreen extends StatefulWidget {
  const ProductAddCartScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddCartScreen> createState() => _ProductAddCartScreenState();
}

class _ProductAddCartScreenState extends State<ProductAddCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "My Add Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: productAddCart(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var data = snapshot.data?.docs;
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                var deletedata = data?[index].id;
                var dt = data?[index].data();
                return Card(
                  child:  Column(
                    children: [
                      Row(
                        children: [
                          Image.network("${data?[index]["imageUrl"]?? ""}",height: 200,fit: BoxFit.cover,),
                          Column(
                            children: [
                              Text(data?[index]['title'] ?? ""),
                              Text("Price: ${data?[index]['price'] ??""}"),
                              IconButton(onPressed: (){
                                setState(() {
                                  productAddCart();
                                  deleteProduct(deletedata!);
                                });
                              }, icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> productAddCart() async {
    var data= FirebaseFirestore.instance;
    var productData= await data.collection('cart').get();
    return productData;
  }

 Future<void> deleteProduct(String id)async{
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var delete = await firestore.collection('cart').doc(id).delete();
    return delete;
  }
}

