import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/link/product_list_view_screen.dart';
import 'package:phone_auth_firebase/link/product_single_detail_screen.dart';
import 'package:share_plus/share_plus.dart';

class ProductService {
  shareDyenamiclink(String id,) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://phoneauthfirebase.com/productId=$id"),
      uriPrefix: "https://phoneauthfirebase.page.link",
      androidParameters: const AndroidParameters(packageName: "com.example.phone_auth_firebase"),
      iosParameters: const IOSParameters(bundleId: "com.example.app.ios"
      ),
    );

    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildLink( dynamicLinkParams);
    await Share.share(dynamicLink.toString());
  }

  void shareDynamicLink() async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://phoneauthfirebase.page.link/product?productId"),
      uriPrefix: "https://phoneauthfirebase.page.link",
      androidParameters: AndroidParameters(
        minimumVersion: 1,
        packageName: "com.example.phone_auth_firebase",
      ),
      // iosParameters: IOSParameters(
      //   bundleId: "com.example.app.ios",
      // ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    await Share.share(dynamicLink.toString());
  }
}