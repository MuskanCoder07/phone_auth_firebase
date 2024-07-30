// import 'package:flutter/material.dart';
// import 'firebase_verification_screen.dart';
//
// class PhoneAuthScreen extends StatefulWidget {
//   const PhoneAuthScreen({super.key});
//
//   @override
//   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
// }
//
// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   var phoneController = TextEditingController();
//   var otpController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Text("Phone Authentication "),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: phoneController,
//               decoration: InputDecoration(
//                   hintText: "verify phone num",
//                   icon: Icon(Icons.call),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15))),
//             ),
//           ),
//           SizedBox( height: 10),
//           ElevatedButton(
//               onPressed: ()  {
//                  PhoneAuthentication()
//                     .verificatoinPhone(phoneController.text);
//               },
//               child: Text("Verify phone Num")
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: otpController,
//               // keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                   hintText: "verify otp",
//                   icon: Icon(Icons.offline_pin_outlined),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15))),
//             ),
//           ),
//           SizedBox( height: 10),
//           ElevatedButton(
//               onPressed: () async {
//                 await PhoneAuthentication()
//                     .verifyOtp(otpController.text,);
//               },
//               child: Text("OTP Verify"))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/phoneauth/verification_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  var phoneController = TextEditingController();
  var otpController = TextEditingController();
  late PhoneAuthentication phoneAuth; // Instance of PhoneAuthentication

  @override
  void initState() {
    super.initState();
    phoneAuth = PhoneAuthentication(); // Initialize PhoneAuthentication instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Phone Authentication"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Enter phone number",
                icon: Icon(Icons.call),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              phoneAuth.verificationPhone(phoneController.text)
                  .then((verificationId) {
              })
                  .catchError((error) {
                // Handle error
                print("Verification failed: $error");
              });
            },
            child: Text("Verify phone number"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                icon: Icon(Icons.offline_pin_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              try {
                await phoneAuth.verifyOtp(otpController.text);
              } catch (error) {
                print("OTP verification failed: $error");
              }
            },
            child: Text("Verify OTP"),
          ),
        ],
      ),
    );
  }
}
