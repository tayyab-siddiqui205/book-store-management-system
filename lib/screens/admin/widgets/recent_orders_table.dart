import 'package:flutter/material.dart';

import 'order_status_chip.dart';

class RecentOrdersTable extends StatelessWidget {
  const RecentOrdersTable({super.key});

  DataRow buildRow(
    String id,
    String customer,
    String book,
    String date,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(customer)),
        DataCell(Text(book)),
        DataCell(Text(date)),
        DataCell(
          OrderStatusChip(
            status: status,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Recent Orders",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  Colors.grey.shade100,
                ),

                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                columns: const [

                  DataColumn(
                    label: Text("Order ID"),
                  ),

                  DataColumn(
                    label: Text("Customer"),
                  ),

                  DataColumn(
                    label: Text("Book"),
                  ),

                  DataColumn(
                    label: Text("Date"),
                  ),

                  DataColumn(
                    label: Text("Status"),
                  ),

                ],

                rows: [

                  buildRow(
                    "#1001",
                    "Ali",
                    "Flutter Guide",
                    "10 Jul",
                    "Completed",
                  ),

                  buildRow(
                    "#1002",
                    "Ahmed",
                    "Clean Code",
                    "10 Jul",
                    "Pending",
                  ),

                  buildRow(
                    "#1003",
                    "Sara",
                    "Atomic Habits",
                    "09 Jul",
                    "Completed",
                  ),

                  buildRow(
                    "#1004",
                    "Hassan",
                    "Rich Dad Poor Dad",
                    "08 Jul",
                    "Cancelled",
                  ),

                  buildRow(
                    "#1005",
                    "Usman",
                    "Deep Work",
                    "08 Jul",
                    "Completed",
                  ),

                  buildRow(
                    "#1006",
                    "Ayesha",
                    "The Alchemist",
                    "07 Jul",
                    "Pending",
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}