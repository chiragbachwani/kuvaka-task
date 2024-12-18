import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CustomCalendarPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime)? onDateSelected;

  const CustomCalendarPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomCalendarPickerState createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late DateTime selectedDate;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(date);
    }
  }

void _changeMonth(int delta) {
  setState(() {
    // Calculate the new month and year
    DateTime newMonth = DateTime(
      currentMonth.year + (currentMonth.month + delta - 1) ~/ 12,
      ((currentMonth.month + delta - 1) % 12) + 1,
    );

    // Restrict navigation beyond December 2024
    if (newMonth.year > 2024 || (newMonth.year == 2024 && newMonth.month > DateTime.now().month)) {
      return; // Do nothing if trying to move beyond December 2024
    }

    // Update the current month
    currentMonth = newMonth;
  });
}



  void _showYearMonthPicker() async {
    final selected = await showDialog<Map<String, int>>(
      context: context,
      builder: (_) => YearMonthPickerDialog(
        initialMonth: currentMonth.month,
        initialYear: currentMonth.year,
        firstYear: widget.firstDate.year,
        lastYear: widget.lastDate.year,
      ),
    );

    if (selected != null) {
      setState(() {
        currentMonth = DateTime(selected['year']!, selected['month']!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize  = MediaQuery.of(context).size;
    var daysInMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    var firstWeekday = DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    var daysInPrevMonth = DateUtils.getDaysInMonth(
  currentMonth.month == 1 ? currentMonth.year - 1 : currentMonth.year, 
  currentMonth.month == 1 ? 12 : currentMonth.month - 1
);

    // Prepare dates for the grid
    var gridDates = <DateTime>[];
    for (var i = firstWeekday - 2; i >= 0; i--) {
      gridDates.add(DateTime(currentMonth.year, currentMonth.month - 1, daysInPrevMonth - i));
    }
    for (var i = 1; i <= daysInMonth; i++) {
      gridDates.add(DateTime(currentMonth.year, currentMonth.month, i));
    }
    for (var i = 1; gridDates.length % 7 != 0; i++) {
      gridDates.add(DateTime(currentMonth.year, currentMonth.month + 1, i));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: screenSize.width * 0.73,
        height: screenSize.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            const BoxShadow(
              color: Colors.black45,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,),
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,),  
                  child: Row(
       
                  mainAxisAlignment: MainAxisAlignment.start,
            
                  
                  children: [
                    GestureDetector(
                      onTap: _showYearMonthPicker,
                      child: Text(
                        DateFormat('MMMM').format(currentMonth),
                        style: const TextStyle(fontSize: 11.15, fontWeight: FontWeight.w600, fontFamily: 'poppins'),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.02,),
                     GestureDetector(
                      onTap: _showYearMonthPicker,
                      child: Text(
                        DateFormat('yyyy').format(currentMonth),
                        style: const TextStyle(fontSize: 18.15, fontWeight: FontWeight.w600, fontFamily: 'poppins'),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.23,),
                    GestureDetector(
                      onTap: () => _changeMonth(-1),
                      child: const Icon(
                         Icons.arrow_back_ios, size: 10,
                        
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.03,),
                    GestureDetector(
                      onTap: () => _changeMonth(1),
                      child: const Icon(
                        
                        Icons.arrow_forward_ios, size: 10,
                        
                      ),
                    ),
                  ],
                              ),
                ),
              GridView.builder(
               
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridDates.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6 ,
                  mainAxisSpacing: 1,  
            crossAxisSpacing: 8, 
            childAspectRatio: 1.5
                ),
                itemBuilder: (context, index) {
                  final dayDate = gridDates[index];
                  final isCurrentMonth = dayDate.month == currentMonth.month;
                  final isSelected = selectedDate == dayDate;
          
                  return GestureDetector(
                    onTap: isCurrentMonth ? () => _onDateSelected(dayDate) : null,
                    child: Container(
                      // margin: EdgeInsets.all(1),s
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: isSelected ? const Color(0xFF25AD34) : null,
                      ),
                      child: Center(
                        child: Text(
                          dayDate.day.toString(),
                          style: TextStyle(
                            fontSize: 11.5, fontFamily: 'poppins',
                            color: isCurrentMonth ? (isSelected ? Colors.white : Colors.black) : Colors.grey,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YearMonthPickerDialog extends StatefulWidget {
  final int initialMonth;
  final int initialYear;
  final int firstYear;
  final int lastYear;

  const YearMonthPickerDialog({
    Key? key,
    required this.initialMonth,
    required this.initialYear,
    required this.firstYear,
    required this.lastYear,
  }) : super(key: key);

  @override
  _YearMonthPickerDialogState createState() => _YearMonthPickerDialogState();
}

class _YearMonthPickerDialogState extends State<YearMonthPickerDialog> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
    selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Year Picker
            DropdownButton<int>(
              value: selectedYear,
              items: List.generate(
                widget.lastYear - widget.firstYear + 1,
                (index) => widget.firstYear + index,
              ).map((year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text('$year'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value!;
                });
              },
            ),
            // Month Picker
            DropdownButton<int>(
              value: selectedMonth,
              items: List.generate(12, (index) => index + 1).map((month) {
                return DropdownMenuItem<int>(
                  value: month,
                  child: Text(DateFormat.MMMM().format(DateTime(0, month))),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Confirm Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({'month': selectedMonth, 'year': selectedYear});
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
