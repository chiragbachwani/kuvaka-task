import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuvaka/screens/login_screen.dart';
import 'package:kuvaka/screens/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
   

  Widget _buildtButton(double screenHeight, double screenWidth, String text, var Color, onTap) {
  return Align(
    alignment: Alignment.center, 
    child: FractionallySizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: Size(screenWidth * 0.59, screenHeight * 0.06),
          minimumSize: Size(screenWidth * 0.59, screenHeight * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Color,
        ),
        onPressed: onTap,
        child: Text(
          text,
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
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top:MediaQuery.of(context).size.width * 0.24,
            left: MediaQuery.of(context).size.width * 0.08 ,
            child: Text("EatExpress",style: TextStyle(fontFamily: 'libre',fontSize: 24,fontWeight: FontWeight.w500,color: Color(0xFF121212)),
            // Center(child: Image.asset('assets/EatExpress.png')
            ),),
            Positioned(
            top:MediaQuery.of(context).size.width * 0.37,
            left: MediaQuery.of(context).size.width * 0.08 ,
            child:RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Connect to food \noutlets",
                    style: TextStyle(fontFamily: 'inter',fontSize: 32,fontWeight: FontWeight.w600,color: Color(0xFF413F3F)),
                  ),
                  TextSpan(
                    text: " to deliver \nfood to customers",
                    style: TextStyle(fontFamily: 'inter',fontSize: 32,fontWeight: FontWeight.w400,color: Color(0xFF413F3F)),
                  ),]
            ))
            //  Center(child: Image.asset('assets/Connect.png')
            
            ),
           
          // Background image 1
          Positioned(
            top:MediaQuery.of(context).size.width * 0.28,
            left: MediaQuery.of(context).size.width * 0.0009 -10 ,
            child: Image.asset(
              'assets/background.png',
              width: MediaQuery.of(context).size.width* 1.05,
              height: MediaQuery.of(context).size.height ,
              fit: BoxFit.contain,
            ),
          ),

          // Background image 2
          Positioned(
            top: MediaQuery.of(context).size.width * 0.32,
            left: MediaQuery.of(context).size.width * 0.0009 -5,
            child: Image.asset(
              'assets/foreground.png',
              width: MediaQuery.of(context).size.width * 0.95 ,
              height: MediaQuery.of(context).size.height ,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top:MediaQuery.of(context).size.width * 0.01 - 50,
            left: MediaQuery.of(context).size.width * 0.2  ,
            child: Image.asset(
              'assets/dougnut.png',
              width: MediaQuery.of(context).size.width* .13,
              height: MediaQuery.of(context).size.height ,
              fit: BoxFit.contain,
            ),
          ),
          
          
          Positioned(
            bottom:MediaQuery.of(context).size.width * 0.16,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildtButton(screenSize.height * 0.9, screenSize.width *1.03 , "Sign Up", Color(0xFF25AD34) , (){
                  Get.to(()=>SignUpScreen());
                }),
                SizedBox(height: screenSize.height * 0.03),
                 _buildtButton(screenSize.height * 0.9, screenSize.width *1.03 , "Log In", Color(0xFF5C5C8B), (){
                  Get.to(()=>LoginScreen());
                 } ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}