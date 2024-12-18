import 'package:flutter/material.dart';
import 'package:kuvaka/widgets/btn.dart';
// import 'package:kuvaka_bhavesh/utils/app_color.dart';
// import 'package:kuvaka_bhavesh/widgets/btn.dart';

class DeliveryTable extends StatelessWidget {
  const DeliveryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFF8D8D8D), width: 1),
              bottom: BorderSide(color: Color(0xFF8D8D8D), width: 1),
            ),
            defaultColumnWidth:
                const IntrinsicColumnWidth(), // Ensures columns auto-fit
            children: [
              /// Header Row
              const TableRow(
                decoration: BoxDecoration(color: Colors.white),
                children: [
                  TableCellText(label: "Order ID"),
                  TableCellText(label: "Status"),
                  TableCellText(label: "Outlet"),
                  TableCellText(label: "Delivered in"),
                  TableCellText(label: "EE share"),
                  SizedBox(), // Empty cell for the action button
                ],
              ),

              /// Data Rows
              ...List.generate(3, (index) {
                return TableRow(
                  children: [
                    const TableCellValue(label: "Task ID1"),
                    const TableCellValue(label: "Driver Assigned"),
                    const TableCellValue(label: "Outlet Name"),
                    const TableCellValue(label: "25 min"),
                    const TableCellValue(label: "£12"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: buildCustomButton(
                          borderRadius: 14,
                          textColor: Colors.white,
                          buttonText: 'Track Delivery',
                          onTap: () {
            //                 Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MapScreen()),
            // );
                          },
                          width: 160,
                          textSize: 16,
                          verticalPadding: 12),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TableCellText extends StatelessWidget {
  final String label;

  const TableCellText({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF413F3F),
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class TableCellValue extends StatelessWidget {
  final String label;

  const TableCellValue({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF413F3F),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
