import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/models/user_model.dart';
import 'package:kuvaka/screens/login_screen.dart';
import 'package:kuvaka/screens/verify_email.dart';
import 'package:kuvaka/widgets/custom_date_picker.dart';

final  authcontroller = Get.put(AuthController());
class SignUpScreen extends StatelessWidget {
  final UserData userData;

  SignUpScreen({super.key, required this.userData});


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
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: screenHeight * 0.033,
                        backgroundColor: Color(0xFF25AD34),
                        child: Icon(Icons.arrow_back_ios_new, size: screenHeight * 0.025,color: Colors.white,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth *0.01, screenHeight * 0.015, screenWidth *0.01, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.values[2],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    controller: controller.nameController,
                    hintText: "Driver Name",
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: controller.emailController,
                    hintText: "Email Address",
                    isPassword:false,
                  ),
                   SizedBox(height: screenHeight * 0.01),
                   _buildDateOfBirthField(context),
                   Obx(() {
              if (!controller.isCalendarVisible.value) {
                return SizedBox.shrink();
              }
              return  CustomCalendarPicker(
                  initialDate: controller.selectedDate.value ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  onDateSelected: (date) {
                    controller.updateSelectedDate(date);
                  },
                );
              
            }),
                    SizedBox(height: screenHeight * 0.01),
                  _buildPassTextField(
                              controller: controller.passwordController,
                              hintText: "Password",
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
  return "Password cannot be empty";
}
if(value.length<8){
  return "Password cannot be less than 8 characters";
}
                               
                                return null;
                              },
                            ),
                  SizedBox(height: screenHeight * 0.079),
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08,),
                      Center(   
                        child: GestureDetector(
                          onTap: () {
                           
                            Get.to(()=>LoginScreen());
                          },
                          child: RichText(
                           text: TextSpan(
                             text: "Already a registered user?",
                             style: TextStyle(
                               fontFamily: 'inter',
                               fontSize: 14,
                               fontWeight: FontWeight.w500,
                               color: Color(0xFF413F3F),
                             ),
                             children: [
                               TextSpan(
                                 text: " Log in",
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
                  ),
                  SizedBox(height: screenHeight * 0.035),
                  _buildNextButton(screenHeight, screenWidth,context),
                  SizedBox(height: screenHeight * 0.02),
                   
                  
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

  Widget _buildDateOfBirthField(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.toggleCalendarVisibility();
      },
      child: Obx(
        () => Container(
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    controller.getFormattedDate(),
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      color: controller.selectedDate.value == null ?
                      Colors.grey : Color(0xFF413F3F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Image.asset('assets/Calendar.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildNextButton(double screenHeight, double screenWidth,context) {
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
        onPressed:controller.isLoading.value ? null : () {
          userData.dateOfBirth = controller.selectedDate.value;
          controller.signUpWithEmail(context, userData);
        },
        child: controller.isLoading.value
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                "Next",
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


 Widget _buildPassTextField({
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
              offset: Offset(0, 1), // Position of the shadow (x, y)
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
              hintStyle: TextStyle(
                fontFamily: 'inter',
                fontSize: 14,
                color: Color(0xFF8D8D8D),
                fontWeight: FontWeight.w500,
              ),
              
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              errorStyle: TextStyle(
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
      SizedBox(height: 10), // Add spacing between the field and the next widget
    ],
  );
}


}
