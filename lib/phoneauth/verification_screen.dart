import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthentication {
  late String verificationId;

  final FirebaseAuth _verificationAuth = FirebaseAuth.instance;

  Future<String> verificationPhone(String phoneNumber) async {
    try {
      await _verificationAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) {
          _verificationAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          print("Verification failed: ${error.message}");
          throw error; // Throw the error to propagate it
        },
        codeSent: (String verifId, int? resendToken) {
          verificationId = verifId;
        },
        codeAutoRetrievalTimeout: (String verifId) {
          verificationId = verifId;
        },
      );
      return verificationId;
    } catch (error) {
      print("Error in verificationPhone: $error");
      throw error;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _verificationAuth.signInWithCredential(credential);
    } catch (error) {
      print("Error in verifyOtp: $error");
      throw error;
    }
  }
}