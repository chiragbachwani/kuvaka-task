import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/screens/forgot_password.dart';

var authController = Get.put(AuthController());

class LoginScreen extends StatelessWidget {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final isEmail = false.obs; // Observable to track input type

  LoginScreen({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: screenHeight * 0.033,
                        backgroundColor: Color(0xFF25AD34),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: screenHeight * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.09,
                        vertical: screenHeight * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/right.png'),
                        Column(
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenHeight * 0.035,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                        Image.asset('assets/left.png'),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.18),

                  // Input Fields
                  _buildTextField(
                    controller: emailOrPhoneController,
                    hintText: "Enter Email or Phone Number",
                    inputType: TextInputType.text,
                    onChanged: (value) {
                      // Detect if input is email or phone number
                      isEmail.value = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Password Field (Conditional)
                  Obx(
                    () => isEmail.value
                        ? Form(
                            key: formKey1,
                            child: _buildPassTextField(
                              controller: passwordController,
                              hintText: "Password",
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (value.length < 8) {
                                  return "Password must be at least 8 characters";
                                }
                                return null;
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: screenHeight * 0.079),

                  // Submit Button
                  _buildSubmitButton(screenHeight, screenWidth),
                  SizedBox(height: screenHeight * 0.02),

                  // Forgot Password
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Forgot Password?",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF413F3F),
                              ),
                              children: [
                                TextSpan(
                                  text: " Click here",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Email or Phone Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    required void Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'inter',
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Password Field
  Widget _buildPassTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    bool isPassword = false,
  }) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: authController.isShadow.value
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0),
              blurRadius: authController.isShadow.value ? 1 : 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword ? !authController.isPasswordVisible.value : false,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'inter',
              fontSize: 14,
              color: Color(0xFF8D8D8D),
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
    );
  }

  // Submit Button
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
            backgroundColor: Color(0xFF25AD34),
          ),
          onPressed: () async{
           
              if (isEmail.value) {
                 if (formKey1.currentState?.validate() ?? false) {
                await controller.loginWithEmail(emailOrPhoneController.text, passwordController.text);
                // Get.snackbar("Success", "Logged in with Email and Password!");
                }
              } else {
                controller.sendOtplogin(emailOrPhoneController.text);
                // Get.snackbar("Success", "Logged in with Phone Number!");
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
