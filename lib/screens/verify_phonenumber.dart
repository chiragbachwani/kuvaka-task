import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/auth_controller.dart';
import 'package:kuvaka/models/user_model.dart';

// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
final  controller = Get.put(AuthController());
class VerifyPhone extends StatelessWidget {
  final UserData userdata;

  const VerifyPhone({super.key, required this.userdata});


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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
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
                    padding: EdgeInsets.fromLTRB(screenWidth *0.01, screenHeight * 0.015, screenWidth *0.01, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.values[1],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/right.png', width: screenWidth * 0.17,),
                        Column(
                          children: [
                            Text(
                              "Verify your\n phone number ",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,),
                              textAlign: TextAlign.center,
                            ),
                            // SizedBox(height: screenHeight * 0.02,)
                          ],
                        ),
                        Image.asset('assets/left.png',width: screenWidth * 0.17),
                      ],
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.12,),
                 
                  SizedBox(height: screenHeight * 0.06),
                  _buildTextField(
                    controller: controller.otpController,
                    hintText: "OTP",
                    inputType: TextInputType.number,
                    context: context
                  ),
                
                  
                  SizedBox(height: screenHeight * 0.289),
                 Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator()) :
                  _buildSubmitButton(screenHeight, screenWidth),),
                  SizedBox(height: screenHeight * 0.02),
                   
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08,),
                      Center(   
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: RichText(
                           text: 
                               TextSpan(
                                 text: "Resent OTP?",
                                 style: TextStyle(
                                   fontFamily: 'inter',
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.blue
                           ),
                          ),
                        )),
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
    context
  }) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
      child: Container(
        
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
        onPressed: () {
           String otp = controller.otpController.text.trim();
                      if (otp.isNotEmpty) {

                        controller.verifyOtp(otp, userdata);
                      } else {
                        Get.snackbar("Error", "Please enter the OTP.");
                      }
        },
        child: Text(
          "Verify",
          style: const TextStyle(
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
