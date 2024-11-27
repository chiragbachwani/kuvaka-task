import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
final  controller = Get.put(AuthController());
class SignUpScreen3 extends StatelessWidget {
  
  final nameController = TextEditingController();
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  

  SignUpScreen3({super.key});


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             Image.asset("assets/topi.png", width: screenWidth*1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: screenHeight * 0.033,
                      backgroundColor: Color(0xFF25AD34),
                      child: Icon(Icons.arrow_back_ios_new, size: screenHeight * 0.025,color: Colors.white,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth *0.09, screenHeight * 0.015, screenWidth *0.09, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.values[2],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/right.png'),
                        Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenHeight * 0.035,
                                fontWeight: FontWeight.w600,),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.02,)
                          ],
                        ),
                        Image.asset('assets/left.png'),
                      ],
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.005,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: RichText(
                      text: TextSpan(
                        text: "Step 1",
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF413F3F),
                        ),
                        children: [
                          TextSpan(
                            text: " Personal Details",
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8D8D8D))
                        )]
                    )),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  _buildTextField(
                    controller: emailOrPhoneController,
                    hintText: "Driver Name",
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: passwordController,
                    hintText: "Email Address",
                    isPassword: true,
                  ),
                   SizedBox(height: screenHeight * 0.01),
                  //  _buildDateOfBirthField(context),
                    SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: passwordController,
                    hintText: "Email Address",
                    isPassword: true,
                  ),
                  SizedBox(height: screenHeight * 0.079),
                 
                  _buildSubmitButton(screenHeight, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                   
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08,),
                      Center(   
                        child: GestureDetector(
                          onTap: () {
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
                                   color: Colors.blue
                           ),
                          ),]
                        ),)),
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


  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
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
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'inter', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: InputBorder.none,
        ),
      ),
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
          backgroundColor: Color(0xFF25AD34),
        ),
        onPressed: () {},
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
