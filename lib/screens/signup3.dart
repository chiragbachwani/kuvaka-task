import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/models/user_model.dart';
import 'package:kuvaka/screens/login_screen.dart';
import 'package:kuvaka/screens/signup4.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
final  controller = Get.put(AuthController());
class SignUpScreen3 extends StatelessWidget {
  
final UserData userData;
  

  SignUpScreen3({super.key, required this.userData});


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
                    onTap: (){Get.back();},
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
                    padding: EdgeInsets.fromLTRB(screenWidth *0.06, screenHeight * 0.015, screenWidth *0.06, 0),
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
                  SizedBox(height: screenHeight * 0.1,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: RichText(
                      text: TextSpan(
                        text: "Step 3",
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF413F3F),
                        ),
                        children: [
                          TextSpan(
                            text: " Details about vehicle",
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8D8D8D))
                        )]
                    )),
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Text("Select vehicle",   style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8D8D8D))),
                  ),
                   Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: RadioListTile<String>(
                              contentPadding: EdgeInsets.zero, // Removes extra padding around the tile
            dense: true, // Reduces the size of the tile
            visualDensity: VisualDensity.compact, // Makes the tile more compact
            activeColor: Colors.green, // Set
                              title: Text(
                                "Motorcycle",
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: "Motorcycle",
                              groupValue: controller.selectedVehicle.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedVehicle.value = value;
                                }
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile<String>(
                              contentPadding: EdgeInsets.zero, // Removes extra padding around the tile
            dense: true, // Reduces the size of the tile
            visualDensity: VisualDensity.compact, // Makes the tile more compact
            activeColor: Colors.green, // Set
                              title: Text(
                                "Car",
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: "Car",
                              groupValue: controller.selectedVehicle.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedVehicle.value = value;
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: screenHeight * 0.03),
                  _buildTextField(
                    controller: controller.vehicleRegNoController,
                    hintText: "Vehicle Registration Number",
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: controller.vehicleController,
                    hintText: "Which Vehicle is it?",
                    isPassword: false,
                    inputType: TextInputType.streetAddress
                  ),
                   
                 
                  SizedBox(height: screenHeight * 0.032),
                 Column(
                    children: [
                      SizedBox(height: screenHeight * 0.15),
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
                  _buildNextButton(screenHeight, screenWidth),
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

  

Widget _buildNextButton(double screenHeight, double screenWidth) {
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
        onPressed: () {
          userData.vehicleRegNo = controller.vehicleRegNoController.text.trim();
          userData.vehicle = controller.selectedVehicle.value;
          
          Get.to(()=>SignUpScreen4(userData : userData));
        },
        child: Text(
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

}
