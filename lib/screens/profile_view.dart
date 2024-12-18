import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/screens/splash_screen.dart';
import 'package:kuvaka/widgets/btn.dart';
import 'package:kuvaka/widgets/table.dart';
var controller = Get.put(AuthController());
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  // Future<Map<String, dynamic>?> _fetchUserData() async {
  //   try {
  //     String userId = controller.getCurrentUserId(); // Assuming this method exists
  //     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //         await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //     return userSnapshot.data();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch user data.');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: controller.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Failed to load data.'));
            }

            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/phool.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            weight: 40,
                            size: 24,
                            color: Color(0xFF25AD34),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.02),
                        const Text(
                          'Profile',
                          style: TextStyle(
                              color: Color(0xFF25AD34),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 20.0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/profilepic.png"),
                        const SizedBox(height: 16),
                         Text(
                          data['name'] ??"Jack Spens",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF413F3F)),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Labels column
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileLabel(label: "Contact number"),
                                ProfileLabel(label: "E-mail"),
                                ProfileLabel(label: "Pincode"),
                                ProfileLabel(label: "Number of delivered"),
                                ProfileLabel(label: "Vehicle"),
                              ],
                            ),
                            const Spacer(),
                            // Values column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileLabel(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    label: "+91 "+ data['phone']),
                                ProfileLabel(
                                    label: data['email'] ?? "Not available"),
                                ProfileLabel(
                                    label: data['pincode'] ?? "Not available"),
                                const ProfileLabel(label: "74"),
                                ProfileLabel(
                                    label: data['vehicle'] ?? "Not available"),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Drivers legal details",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF413F3F)),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1.3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileLabel(
                                        label: "National insurance certificate"),
                                    ProfileLabel(
                                        label: "Drivers insurance certificate"),
                                    ProfileLabel(label: "Drivers license"),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ProfileValue(
                                        value: data['insurancePath'] ??
                                            "Not available"),
                                    ProfileValue(
                                        value: data['insurancePath'] ??
                                            "Not available"),
                                    ProfileValue(
                                        value: data['driverLicensePath'] ??
                                            "Not available"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order History",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF413F3F)),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF25AD34),
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const DeliveryTable(),
                        const SizedBox(height: 24),
                        buildCustomButton(
                            buttonText: 'Delete account',
                            textColor: Colors.white,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DeleteAccountDialog();
                                },
                              );
                            },
                            buttonColor: const Color(0xFF8D8D8D),
                            borderRadius: 8,
                            verticalPadding: 10),
                        const SizedBox(height: 8),
                        buildCustomButton(
                            buttonText: 'Log out',
                            textColor: Colors.white,
                            onTap: () {
                              controller.signOut();
                            },
                            buttonColor: const Color(0xFF8D8D8D),
                            verticalPadding: 10,
                            borderRadius: 8)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileLabel extends StatelessWidget {
  final String label;

  const ProfileLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF413F3F),
        
        ),
      ),
    );
  }
}

class ProfileValue extends StatelessWidget {
  final String value;

  const ProfileValue({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        value,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Color(0xFF25AD34),
        ),
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
         
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF25AD34),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Center(
                child: Text(
                  'Delete account',
                  
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0.0),
              child: Text(
                'The user account will be deleted permanently and the data on the device will be erased.\n\nThe account after deleting would not be recovered.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF413F3F),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24.0),

            // Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                buildCustomButton(
                  buttonText: 'Go back',
                  buttonColor: const Color(0xFF8D8D8D),
                   textColor: Colors.white,
                  width: 140,
                  verticalPadding: 8,
                  textSize: 14,
                  borderRadius: 6,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 8),
                buildCustomButton(
                  buttonText: 'Delete',
                  buttonColor: const Color(0xFF8D8D8D),
                   textColor: Colors.white,
                  width: 140,
                  textSize: 14,
                  verticalPadding: 8,
                  borderRadius: 6,
                  onTap: () async{
final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Attempt to delete the account
        await user.delete();
        // Show success message or navigate away
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully.')),
        );
        // Optionally sign out the user
        await FirebaseAuth.instance.signOut();

        Get.offAll(const SplashScreen());
        // Navigate to a different screen, e.g., login screen
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is currently signed in.')),
        );
      }
    
                    
                  },
                ),

              ],
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
