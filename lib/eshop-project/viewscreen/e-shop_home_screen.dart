import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'e-shop_model_class.dart';
import 'e-shop_service.dart';

class EshopHomeScreen extends StatefulWidget {
  const EshopHomeScreen({Key? key}) : super(key: key);

  @override
  State<EshopHomeScreen> createState() => _EshopHomeScreenState();
}

class _EshopHomeScreenState extends State<EshopHomeScreen> {
  late EShopeModel shopData;
  bool isLoading = true;
  String errorMessage = '';
  String currentAddress = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    getUsersData(); // Load initial data
    _getCurrentLocation(); // Fetch current location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "e-Shope",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xE4104491),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red))) // Show error message if any
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              currentAddress,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: shopData.products?.length ?? 0,
              itemBuilder: (context, index) {
                return usersDataView(shopData.products![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUsersData() async {
    try {
      var data = await EshopService().getShopData();
      setState(() {
        shopData = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load data. Please try again later.';
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentAddress =
        "${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
      });
    } catch (e) {
      setState(() {
        currentAddress = 'Failed to get location';
      });
    }
  }

  Widget usersDataView(Product product) {
    return Container(
      height: 500,
      width: 500,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.blueGrey,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.thumbnail ?? "https://via.placeholder.com/150",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title ?? "No Title",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "${product.stock ?? 0} in stock",
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Rating: ${product.rating?.toStringAsFixed(1) ?? "N/A"}",
                style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                    style: const TextStyle(fontSize: 14, color: Colors.indigo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
