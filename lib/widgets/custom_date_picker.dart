import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
      currentMonth = DateTime(currentMonth.year, currentMonth.month + delta);
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
    var daysInPrevMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month - 1);

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
        width: screenSize.width * 0.7,
        height: screenSize.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,),
                child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  GestureDetector(
                    onTap: _showYearMonthPicker,
                    child: Text(
                      DateFormat('MMMM').format(currentMonth),
                      style: TextStyle(fontSize: 11.15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.02,),
                   GestureDetector(
                    onTap: _showYearMonthPicker,
                    child: Text(
                      DateFormat('yyyy').format(currentMonth),
                      style: TextStyle(fontSize: 18.15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.19,),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 10),
                    onPressed: () => _changeMonth(-1),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 10),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
                            ),
              ),
            GridView.builder(
             
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: gridDates.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7 ,
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
                      color: isSelected ? Color(0xFF25AD34) : null,
                    ),
                    child: Center(
                      child: Text(
                        dayDate.day.toString(),
                        style: TextStyle(
                          fontSize: 11.5,
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
            SizedBox(height: 16),
            // Confirm Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({'month': selectedMonth, 'year': selectedYear});
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
