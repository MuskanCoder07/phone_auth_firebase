import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/link/product_sarvice.dart';
import 'package:phone_auth_firebase/link/product_single_detail_screen.dart';
import 'product_list_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkDynamicLink();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Center(child: Text("SHOW DYNAMIC DATA")),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Homepage"),
            SizedBox(height: 20,),
            Center(
                child: CircularProgressIndicator(color: Colors.red,),
                ),
          ],
        ),
    );
  }
  checkDynamicLink() async {
    await Future.delayed(const Duration(seconds: 4));
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.containsKey('productId')) {
        final productId = queryParams['productId'];
        Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => ProductSingleDetailScreen(
          productId: productId.toString(),
          title: '',
          image: '',
          price: '',
          dresh: '',
        )),
        );
      }
    }
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductListViewScreen(),
        ),
      );
    }
  }
}

