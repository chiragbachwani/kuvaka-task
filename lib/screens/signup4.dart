import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/models/user_model.dart';

class SignUpScreen4 extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
   final UserData userData;
  SignUpScreen4({Key? key,required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Image.asset("assets/topi.png", width: screenWidth),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: screenHeight * 0.033,
                        backgroundColor: const Color(0xFF25AD34),
                        child: Icon(Icons.arrow_back_ios_new, size: screenHeight * 0.025, color: Colors.white),
                      ),
                    ),
                  ),

                  // Title
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth *0.01, screenHeight * 0, screenWidth *0.01, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.values[1],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/right.png'),
                        Column(
                          children: [
                            SizedBox(height: screenHeight * 0.0002,),
                            Text(
                              "Upload\nDocument",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenHeight * 0.035,
                                fontWeight: FontWeight.w600,),
                              textAlign: TextAlign.center,
                            ),
                            
                          ],
                        ),
                        Image.asset('assets/left.png'),
                      ],
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.015),
                  SizedBox(height: screenHeight * 0.015,),
                  Padding(
                    padding:  EdgeInsets.symmetric( horizontal: screenWidth * 0.06),
                    child: Text(
                      "Just before confirming your delivery, you'll have the option to upload any necessary documents for added security.This step is entirely optional but recommended for your peace of mind.\n\nRest assured, your privacy is a priority, and your uploaded documents are handled securely. Upon successful verification, you'll receive confirmation, allowing you to enjoy your order with confidence. Thank you for choosing us for your delivery needs",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'inter', color: Color(0xFF8D8D8D)),
                    ),
                  ),
                 
                  SizedBox(height: screenHeight * 0.04),

                  // Upload Driver's License Section
                  _buildFilePicker(
                    title: "Upload Driver's License",
                    filePath: controller.driverLicensePath,
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.any);
                      if (result != null) {
                        controller.driverLicensePath.value = result.files.single.name;
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Upload National Insurance Section
                  _buildFilePicker(
                    title: "Upload National Insurance",
                    filePath: controller.insurancePath,
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.any);
                      if (result != null) {
                        controller.insurancePath.value = result.files.single.name;
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Upload Button
                  Obx(() {
                    final isReadyToUpload = controller.driverLicensePath.isNotEmpty && controller.insurancePath.isNotEmpty;
                    return Align(
    alignment: Alignment.center, 
    child: FractionallySizedBox(
      widthFactor: 0.63, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: Size(screenWidth * 0.59, screenHeight * 0.06),
          minimumSize: Size(screenWidth * 0.59, screenHeight * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isReadyToUpload ? Color(0xFF25AD34) : Color(0xFF8D8D8D),
        ),
        onPressed: () {
          userData.driverLicensePath = controller.driverLicensePath.value;
          userData.insurancePath = controller.insurancePath.value;
        isReadyToUpload ? controller.uploadFiles(context, userData) : null;
        },
        child: Text(
          "Upload",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
                  }),SizedBox(height: screenHeight * 0.04,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFilePicker({
    required String title,
    required RxString filePath,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 53,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filePath.isEmpty ? title : filePath.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: filePath.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
                 Image.asset("assets/upload.png"),
              ],
            ),
          ),
        ),
      );
    });
  }
}
