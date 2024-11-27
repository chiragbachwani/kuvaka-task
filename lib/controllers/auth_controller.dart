
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kuvaka/widgets/custom_date_picker.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  RxBool isCalendarVisible = false.obs; // To toggle calendar visibility

  void toggleCalendarVisibility() {
    isCalendarVisible.value = !isCalendarVisible.value;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    isCalendarVisible.value = false; // Hide calendar after selection
  }

  // void selectDate() async {
  //   final pickedDate = await showCustomDatePicker(
  //     context: Get.context!,
  //     initialDate: selectedDate.value ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null) {
  //     selectedDate.value = pickedDate;
  //   }
  // }

  String getFormattedDate() {
    if (selectedDate.value == null) {
      return 'Date of Birth';
    }
    return DateFormat('MMM d, yyyy').format(selectedDate.value!);
  }
}


// Future showCustomDatePicker({
//   required BuildContext context,
//   required DateTime initialDate,
//   required DateTime firstDate,
//   required DateTime lastDate,
// }) {
//   return showDialog<DateTime>(
//     context: context,
//     builder: (_) => CustomCalendarPicker(
//       initialDate: initialDate,
//       firstDate: firstDate,
//       lastDate: lastDate,
//     ),
//   );
// }
