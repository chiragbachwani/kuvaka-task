
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';


  var authcontroller = Get.put(AuthController());
class CreatePassword extends StatelessWidget {
  // bool isShadow = true;

  final confirmpasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Form key for validation

  CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/topi.png", width: screenWidth * 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: screenHeight * 0.033,
                        backgroundColor: const Color(0xFF25AD34),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: screenHeight * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.01, screenHeight * 0.015, screenWidth * 0.01, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/right.png', width: screenWidth * 0.17),
                        Column(
                          children: [
                            Text(
                              "Create\nPassword",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenHeight * 0.035,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Image.asset('assets/left.png', width: screenWidth * 0.17),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.18),
                  Obx(()=>
                     Form(
                      key: formKey, // Attach the form key
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: passwordController,
                            hintText: "Enter New Password",
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                authcontroller.isShadow.value = false;
                                return "Password cannot be empty";
                              }
                              if (value.length < 8) {
                                authcontroller.isShadow.value= false;
                                return "Password should be at least 8 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          _buildTextField(
                            controller: confirmpasswordController,
                            hintText: "Confirm New Password",
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password";
                              }
                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.082),
                  _buildSubmitButton(screenHeight, screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required String? Function(String?) validator,
  bool isPassword = false,
}) {
  final authController = Get.put(AuthController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color:  authcontroller.isShadow.value  ?Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0), // Adjust opacity
              blurRadius: authcontroller.isShadow.value ?1 : 0, // How much the shadow should blur
              offset: const Offset(0, 1), // Position of the shadow (x, y)
            ),
          ],
        ),
        child: Obx(
          () => TextFormField(
            controller: controller,
            obscureText: isPassword ? !authController.isPasswordVisible.value : false,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'inter',
                fontSize: 14,
                color: Color(0xFF8D8D8D),
                fontWeight: FontWeight.w500,
              ),
              
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              errorStyle: const TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
                color: Colors.red,
              ),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: authController.togglePasswordVisibility,
                      child: Image.asset(
                        authController.isPasswordVisible.value
                            ? "assets/vsible.png"
                            : "assets/notvisible.png",
                        height: 20,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10), // Add spacing between the field and the next widget
    ],
  );
}




  Widget _buildSubmitButton(double screenHeight, double screenWidth) {
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
            backgroundColor: const Color(0xFF25AD34),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Perform action on valid form
              Get.snackbar("Success", "Password created successfully!");
            }
          },
          child: Text(
            "Submit",
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
  }
}
