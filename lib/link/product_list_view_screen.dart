import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/link/product_sarvice.dart';
import 'package:phone_auth_firebase/link/product_single_detail_screen.dart';
import 'package:share_plus/share_plus.dart';

class ProductListViewScreen extends StatefulWidget {

  const ProductListViewScreen({super.key,});

  @override
  State<ProductListViewScreen> createState() => _ProductListViewScreenState();
}

class _ProductListViewScreenState extends State<ProductListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Center(
          child: Text( "Link View", style: TextStyle( color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getLongProduct(),
          builder: (context,  snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.lightGreen,));
            }
            var productData = snapshot.data?.docs.toList();
            return ListView.builder(
              itemCount: productData?.length,
              itemBuilder: (context, index) {
                var data=productData?[index].data() as Map;
                var dataId = productData?[index].id;

                return Container(
                  height: 150,
                  child: Card(
                    child: ListTile(
                      trailing:
                      IconButton(
                        onPressed: (){
                          ProductService().shareDyenamiclink(dataId  !);
                        },icon: Icon(Icons.shortcut),
                      ),
                      leading:
                      Image.network("${data["imageUrl"]}",height: 400,fit: BoxFit.cover,), // Corrected here
                      title:
                      Text("${data["title"]??""}",style: TextStyle(
                        color: Colors.black, fontSize: 21,
                        fontWeight: FontWeight.bold,),
                      ),
                      subtitle:
                      Text("₹ ${data["price"]??""}",style: TextStyle(
                          color: Colors.green,fontSize: 20)
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductSingleDetailScreen(
                          productId: "${data["prodocId"]}",
                          image: "${data['imageUrl']}",
                          title: "${data['title']}",
                          dresh: "${data['dresh']}",
                          price: "${data['price']}",
                        ),));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getLongProduct() async {
    var querySnapshot = await FirebaseFirestore.instance.collection("products").get();
    return querySnapshot;
  }
}
