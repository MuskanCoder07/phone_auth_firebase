import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_auth_firebase/link/product_add_cart_screen.dart';
import 'package:phone_auth_firebase/link/product_sarvice.dart';

class ProductSingleDetailScreen extends StatefulWidget {
  final String productId;
  final String title;
  final String image;
  final String price;
  final String dresh;

  const ProductSingleDetailScreen({
    Key? key,
    required this.productId,
    required this.title,
    required this.image,
    required this.dresh,
    required this.price,
  }) : super(key: key);

  @override
  _ProductSingleDetailScreenState createState() =>
      _ProductSingleDetailScreenState();
}

class _ProductSingleDetailScreenState extends State<ProductSingleDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Product Details SHARE",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Navigate to cart screen
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ProductAddCartScreen(),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.shopping_cart),
        //   )
        // ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getProductDetails(widget.productId),
        builder: (context, snapshot) {
          var data = snapshot.data?.data();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.pinkAccent,
              child: Container(
                color: Colors.white,
                height: 450,
                width: 390,
                child: Center(
                  child: Column(
                    children: [
                      Image.network(
                        data?["imageUrl"] ?? "", // Ensure imageUrl is correctly fetched
                        width: 350,
                        height: 200, // Adjust height as needed
                        fit: BoxFit.cover, // Ensure proper image fitting
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(), // Placeholder while loading
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.error), // Placeholder for error
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Text("1,200+ people Order this in the last 30 days"),
                      Text(
                        "${data?["title"]}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 140),
                          child: Text(
                            "₹ ${data?["price"]}",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: (){
                              ProductService().shareDynamicLink();
                            }, icon: Icon(Icons.share,color: Colors.black,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 110),
                        child: Row(
                          children: [
                            MaterialButton(
                              color: Colors.black12,
                              onPressed: () {
                                dataAdd(data as Map<String,
                                    dynamic>?); // Pass data to dataAdd method
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductAddCartScreen(),
                                    ));
                              },
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height: 50,
                            ),
                            MaterialButton(
                              color: Colors.orange,
                              onPressed: () {
                                // Implement buy now functionality
                              },
                              child: Text(
                                "Buy now",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(String id) async {
    try {
      final firebase = FirebaseFirestore.instance;
      var productData = await firebase.collection("products").doc(id).get();
      return productData;
    } catch (e) {
      throw Exception('Error fetching product details');
    }
  }

  void dataAdd(Map<String, dynamic>? productData) async {
    try {
      var cart = FirebaseFirestore.instance.collection("cart");
      await cart.add({
        "prodocId": widget.productId,
        "imageUrl": productData?['imageUrl'],
        "title": productData?['title'],
        "dresh": widget.dresh,
        "price": widget.price,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
