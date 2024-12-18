import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kuvaka/widgets/custom_dialog2.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color(0xFF25AD34), // Green border
          width: 1, // Thin border
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF25AD34),
        ),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green header with "Call and settle" text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF25AD34), // Green color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Call and settle',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 19.98,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                 Radius.circular(10)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildContainer(
                      title: 'Order No.',
                      image: Image.asset('assets/line.png',width: MediaQuery.of(context).size.width*0.2,),
                      value: '000000',
                      additionalContent: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order items: Item 1, Item 2, Item 3 & Item 4'),
                          SizedBox(height: 4),
                          Text('Restaurant address: Address 1, Address 2, Pin code'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContainer(
                      title: 'Restaurant Name',
                      value: '',
                      additionalContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Food delivered to?\nCustomer Name', style:TextStyle(color: Color(0xFF413F3F), fontSize: 12, fontFamily: 'inter', fontWeight: FontWeight.w500) ,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                             Text('+44 1234567890', style: TextStyle(color: const Color(0xFF413F3F), fontSize: MediaQuery.of(context).size.width*0.02, fontFamily: 'inter', fontWeight: FontWeight.w500),),
                             ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),),
                              backgroundColor: const Color(0xFF25AD34),
                            ),
                            child:  Text('Call Restaurant', style: TextStyle(color: Colors.white, fontSize:  MediaQuery.of(context).size.width*0.03, fontFamily: 'inter'),),
                          ),
                             
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContainer(
                      title: 'Settle Payment',
                      value: '',
                      additionalContent: Column(
                        children:  [
                          Row(
                            children: [
                              const Text('Order Value:',style:TextStyle(color: Color(0xFF413F3F), fontSize: 14, fontFamily: 'inter', fontWeight: FontWeight.w500) ),
                              Image.asset('assets/line.png', width: MediaQuery.of(context).size.width*0.2,),
                              const Text(' \$100',style:TextStyle(color: Color(0xFF413F3F), fontSize: 14, fontFamily: 'inter', fontWeight: FontWeight.w500) )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Amount outstanding',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '\$80',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF413F3F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                                showDialog(
              context: context,
              builder: (context) => const CustomDialog2(),
            );
                             
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),),
                              backgroundColor: const Color(0xFF25AD34),
                            ),
                            child: const Text('Payment Deposited?', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'inter'),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({
    required String title,
    required String value,
    var image,
    required Widget additionalContent,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              image ?? const Spacer(),

              Text(value),
            ],
          ),
          const SizedBox(height: 8),
          additionalContent,
        ],
      ),
    );
  }
}







