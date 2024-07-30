// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
//
// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   String location = 'Fetching location...';
//   String address = 'Fetching address...';
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   void _getCurrentLocation() async {
//     try {
//       Position position = await _determinePosition();
//       setState(() {
//         location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//       });
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude, position.longitude);
//       Placemark place = placemarks[0];
//       setState(() {
//         address = '${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
//       });
//     } catch (e) {
//       setState(() {
//         location = 'Error fetching location';
//         address = 'Error fetching address';
//       });
//     }
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Location'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Location:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               location,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Address:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               address,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Sign in with email and password
//   Future<User?> signIn(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   // Register with email and password
//   Future<User?> register(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   // Get current user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class LocationScreen extends StatelessWidget {
  final String userId;
  const LocationScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Current Locations',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('locations')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var locations = snapshot.data!.docs;
              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  var location = locations[index];
                  return Container(
                    height: 210, // Set the desired height for the card
                    margin: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Latitude: ${location['latitude']}'),
                            Text('Longitude: ${location['longitude']}'),
                            Text('Address: ${location['address']}'),
                            Text('Locality: ${location['locality']}'),
                            Text('Sub Administrative Area: ${location['subAdministrativeArea']}'),
                            Text('Administrative Area: ${location['administrativeArea']}'),
                            Text('Postal Code: ${location['postalCode']}'),
                            Text('Country: ${location['country']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
        ),
    );
  }
}

