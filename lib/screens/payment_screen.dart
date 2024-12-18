import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kuvaka/controllers/payment_controller.dart';
import 'package:kuvaka/screens/map_screen.dart';
import 'package:kuvaka/screens/profile_view.dart';
import 'package:kuvaka/widgets/custom_payment_dialog.dart';

class PaymentScreen extends StatelessWidget {
  final onlineController = Get.put(OnlineController());
  final RxInt selectedTabIndex = 1.obs; // To track the selected tab index

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header Section
            Container(
              
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/phool.png",), fit: BoxFit.fitWidth)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: screenHeight * 0.022),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Container(
                              height: 30,
                              
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: onlineController.isOnline.value
                                        ? Colors.green
                                        : Colors.transparent,
                                    width: 2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.scale(
                                    scale: 0.7, // Adjust this value to control the size
                                    child: Switch(
                                      trackOutlineWidth: WidgetStateProperty.all(0),
                                      thumbColor:
                                          WidgetStateProperty.all(Colors.white),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.padded,
                                      value: onlineController.isOnline.value,
                                      onChanged: (value) async{
                                        onlineController.isOnline.value = value;
                                    
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    onlineController.isOnline.value
                                        ? "You are online now"
                                        : "You are offline",
                                    style: TextStyle(
                                        fontSize: 9.91,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(ProfileView());
                            },
                            child: Image.asset("assets/profile.png",)),
                        ],
                      ),
                    ),
                    Obx(() => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => selectedTabIndex.value = 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              height: 40,
                              
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                
                                color: selectedTabIndex.value == 0
                                  ? Color(0xFF25AD34) 
                                  : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                
                              ),
                              
                              child: Center(
                                child: Text(
                                  "Delivery",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 19.9,
                                    color: selectedTabIndex.value == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => selectedTabIndex.value = 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                               height: 40,
                              
                              width: MediaQuery.of(context).size.width * 0.4,
                               decoration: BoxDecoration(
                               color: selectedTabIndex.value == 1
                                  ? Color(0xFF25AD34) // Green for selected tab
                                  : Colors.white, 
                                borderRadius: BorderRadius.circular(8),
                                
                              ),
                              // padding: EdgeInsets.symmetric(vertical: 12),
                              
                              child: Center(
                                child: Text(
                                  "Payments",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 19.9,
                                    color: selectedTabIndex.value == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => selectedTabIndex.value = 0,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              height: 6,
                              
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                
                                color: selectedTabIndex.value == 0
                                  ? Color(0xFF25AD34) 
                                  : Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                
                              ),
                              
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 10,
                                    color: selectedTabIndex.value == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => selectedTabIndex.value = 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                               height: 6,
                              
                              width: MediaQuery.of(context).size.width * 0.4,
                               decoration: BoxDecoration(
                               color: selectedTabIndex.value == 1
                                  ? Color(0xFF25AD34) // Green for selected tab
                                  : Colors.white, 
                                borderRadius: BorderRadius.circular(3),
                                
                              ),
                              // padding: EdgeInsets.symmetric(vertical: 12),
                              
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 10,
                                    color: selectedTabIndex.value == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
              ],
            )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (selectedTabIndex.value == 0) {
                  return MapScreen(); 
                } else {
                  return _buildPaymentsTab(screenWidth, screenHeight,context);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsTab(double screenWidth, double screenHeight, context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Incomplete Payment Handover
          Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Incomplete Payment\nHandover",
                  style: TextStyle(fontSize: 14, fontFamily: 'inter', fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    // Icon(Icons.error_outline, color: Colors.red),
                    Image.asset('assets/error.png'),
                    SizedBox(width: 5),
                    Text(
                      "04",
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'inter', color: Color(0xFF413F3F), fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5),
                   Image.asset('assets/up.png'),
                  ],
                ),
              ],
            ),
          ),

          // Earnings/Payments Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  backgroundColor: Colors.grey,
                ),
                child: Text(
                  "Earnings",
                  style: TextStyle(
                      fontFamily: 'inter', fontSize: 14, color: Colors.white),
                ),
              ),
              SizedBox(width: 30,),
              ElevatedButton (
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  backgroundColor: Color(0xFF25AD34),
                ),
                child: Text(
                  "Payments",
                  style: TextStyle(
                      fontFamily: 'inter', fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(width: screenWidth * 0.34,),
               Container(
                height: 6,
                width: 110,
                decoration: BoxDecoration(
                  color: Color(0xFF25AD34),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
            ],
          ),

          SizedBox(height: screenHeight * 0.02),

          // Table Section
          Text(
            "Remaining Cash Payments to Food Outlets",
            style: TextStyle(
                fontFamily: 'inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(height: screenHeight * 0.01),
           Container(
                height: 3,
                width: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF25AD34),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

          SizedBox(height: screenHeight * 0.01),

          // Scrollable Table
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 55,
                columns: [
                  DataColumn(label: Text("Deposit\nPayment To",style: TextStyle(fontFamily: 'inter', fontSize: 10, fontWeight: FontWeight.w600),)),
                  DataColumn(label: Text("Collect Payment\nFrom?",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                  DataColumn(label: Text("Order ID",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                  DataColumn(label: Text("Payment\nStatus",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                  DataColumn(label: Text("Payment\nto Deposit",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                  DataColumn(label: Text("Action",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                ],
                rows: List.generate(5, (index) {
                  return DataRow(
                   
                    cells: [
                      DataCell(Text("Restaurant\nName",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                      DataCell(Text("Customer\nName",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                      DataCell(Text("00000",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                      DataCell(Text("Collected\nfrom customer",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                      DataCell(Text("00",style: TextStyle(fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                      DataCell(SizedBox(
                        height: 46,
                        width: 73,
                        child: GestureDetector(
                          onTap: (){
                             showDialog(
              context: context,
              builder: (context) => const CustomDialog(),
            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 13, ),
                             child: Align(
                              alignment: Alignment.center,
                              child: Text("Call or Settle",style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w600))),
                          
                            decoration: BoxDecoration(
                              color: Color(0xFF25AD34),
                              borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                      )),
                    ],
                  );
                }),
              ),
            ),
          ),
          // Divider()
    
        ],
      ),
    );
  }
}
