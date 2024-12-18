
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kuvaka/screens/payment_screen.dart';
import 'package:kuvaka/screens/signup2.dart';
import 'package:kuvaka/screens/signup_screen.dart';
import 'package:kuvaka/screens/splash_screen.dart';
import 'package:kuvaka/screens/verify_login_phone.dart';
import 'package:kuvaka/screens/verify_phonenumber.dart';


class AuthController extends GetxController {
  final vehicleRegNoController = TextEditingController();
  final vehicleController = TextEditingController();
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailOTPcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  var pcredential = PhoneAuthProvider.credential(verificationId: '', smsCode: '');

   final FirebaseAuth _auth = FirebaseAuth.instance;

  // State variables
  var isLoading = false.obs;
  var verificationId = ''.obs;

  // Controllers
  var otpController = TextEditingController();
   var selectedVehicle = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
     RxBool isShadow = true.obs;
  RxBool isCalendarVisible = false.obs;

   RxString driverLicensePath = ''.obs;
  RxString insurancePath = ''.obs;
  var isPasswordVisible = false.obs;
  // var driverLicensePath = ''.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
   
  Future<void> linkWithEmailPass(
      BuildContext context, String email, String password) async {
    // Sign in with email/password
    final AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    // Link email/password credential to the current user account
    User? user = _auth.currentUser;
    if (user != null) {
      await user.linkWithCredential(credential);
    }
  }


  void signOut() async {
  await _auth.signOut().then((onValue){
    Get.offAll(()=>const SplashScreen());
  });
}
  
   Future<void> saveUserData(userData) async {
    try {
      // Replace with Firebase Authentication user UID (if available)
      final String userId = _auth.currentUser?.uid ?? phonecontroller.text; // Use phone as unique key, or Firebase UID


      // Save data to Firestore
      await firestore.collection('users').doc(userId).set(userData.toMap());

      // Show success message
      Get.snackbar('Success', 'User data saved successfully!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> saveFilesToPreferences() async {
    try {
      // final prefs = await SharedPreferences.getInstance();

      // Store file paths
      // await prefs.setString('driverLicensePath', driverLicensePath.value);
      // await prefs.setString('insurancePath', insurancePath.value);
     


      // Get.to(()=>PaymentScreen());
      Get.snackbar("Success", "Files uploaded successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save files: $e");
    }
  }

  // Method to load files from SharedPreferences (optional, for retrieval)
  
Future<void> sendOtplogin(String phoneNumber) async {
    try {
      String newnumber = "+91"+ phoneNumber;
      isLoading.value = true;

      await _auth.verifyPhoneNumber(
        phoneNumber: newnumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.snackbar("Success", "Phone number verified automatically!");
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Verification failed.");
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          Get.to(() => const VerifyPhonelogin()); // Navigate to OTP verification screen
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp(String phoneNumber, userData) async {
    try {
      String newnumber = "+91"+ phoneNumber;
      isLoading.value = true;

      await _auth.verifyPhoneNumber(
        phoneNumber: newnumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.snackbar("Success", "Phone number verified automatically!");
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Verification failed.");
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          Get.to(() => VerifyPhone(userdata : userData)); // Navigate to OTP verification screen
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP and log in the user
  Future<void> verifyOtp(String otp, userData) async {
    try {
      isLoading.value = true;

      // Create a PhoneAuthCredential with the OTP
       pcredential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      // Sign in the user
      await _auth.signInWithCredential(pcredential);

      Get.snackbar("Success", "Phone number verified!");
      Get.offAll(() => SignUpScreen(userData : userData)); // Navigate to the home screen after login
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }


   Future<void> verifyOtplogin(String otp) async {
    try {
      isLoading.value = true;

      // Create a PhoneAuthCredential with the OTP
       pcredential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      // Sign in the user
      await _auth.signInWithCredential(pcredential);

      Get.snackbar("Success", "Phone number verified!");
      Get.offAll(() => PaymentScreen()); // Navigate to the home screen after login
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

   void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> uploadFiles(context, userData) async {
    if (driverLicensePath.isNotEmpty && insurancePath.isNotEmpty) {
      // await saveFilesToPreferences();
      // linkWithPhoneNumber(context);
       await saveUserData(userData);
          Get.to(()=>PaymentScreen());
             
              Get.snackbar("Success", "Files uploaded successfully! & user logged in");


    } else {
      Get.snackbar("Error", "Please select both files before uploading.");
    }
  }

  void toggleCalendarVisibility() {
    isCalendarVisible.value = !isCalendarVisible.value;
  }


bool isValidEmailOrPhone(String input) {

  if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(input)) {
    return true;
  }
  // Check if it's a phone number
  if (RegExp(r"^\d{10}$").hasMatch(input)) {
    return true;
  }
  return false;
}



bool isValidPassword(String password) {
  return password.length >= 6; // Minimum 6 characters
}

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    isCalendarVisible.value = false; // Hide calendar after selection
  }


  String getFormattedDate() {
    if (selectedDate.value == null) {
      return 'Date of Birth';
    }
    return DateFormat('MMM d, yyyy').format(selectedDate.value!);
  }

  Future<void> linkEmailToPhoneUser(
    BuildContext context, String email, String password) async {
  try {
    // Sign in with phone number first
    User? user = _auth.currentUser;
    if (user == null) {
      Get.snackbar("Error", "Please sign in with your phone number first.");
      return;
    }

    // Create email/password credentials
    final AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    // Link the email/password credential to the existing phone-auth user
    await user.linkWithCredential(credential);

    Get.snackbar("Success", "Email linked to your account successfully!");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'provider-already-linked') {
      Get.snackbar("Error", "This email is already linked to an account.");
    } else if (e.code == 'credential-already-in-use') {
      Get.snackbar("Error", "This email is already in use by another account.");
    } else {
      Get.snackbar("Error", e.message ?? "An unexpected error occurred.");
    }
  }
}

String getCurrentUserId() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No user is currently signed in.");
    }
  }


  Future<void> loginWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
        Get.offAll(() => PaymentScreen());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    } else if (e.code == 'wrong-password') {
    } else {
    }
  }
}


Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      String userId =getCurrentUserId(); // Assuming this method exists
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return userSnapshot.data();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data.');
      return null;
    }
  }

Future<void> signUpWithEmail(BuildContext context, userData) async {
  try {
    isLoading.value = true;

    // Validate inputs
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar("Error", "All fields are required.");
      return;
    }

    if (password.length < 8) {
      Get.snackbar("Error", "Password must be at least 8 characters long.");
      return;
    }

    // Ensure user is signed in via phone before linking
    await linkEmailToPhoneUser(context, email, password);
    
    userData.email = email;
    userData.name = name;
    // Update display name if needed
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
    }

    Get.snackbar("Success", "Account created and linked successfully!");
    Get.offAll(() => SignUpScreen2(userData: userData));
  } finally {
    isLoading.value = false;
  }
}
}







