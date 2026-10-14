import 'package:flutter/material.dart';
import 'dashboard_card.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: const [
        SizedBox(
          width: 300,
          child: DashboardCard(
            icon: Icons.menu_book_rounded,
            iconColor: Color(0xff6C4EF6),
            bgColor: Color(0xffF3EEFF),
            title: "Total Books",
            value: "1,250",
            growth: "12% from last month",
          ),
        ),
        SizedBox(
          width: 300,
          child: DashboardCard(
            icon: Icons.shopping_bag_rounded,
            iconColor: Colors.green,
            bgColor: Color(0xffEAFBF0),
            title: "Total Orders",
            value: "850",
            growth: "18% from last month",
          ),
        ),
        SizedBox(
          width: 300,
          child: DashboardCard(
            icon: Icons.people_alt_rounded,
            iconColor: Colors.blue,
            bgColor: Color(0xffEEF5FF),
            title: "Total Users",
            value: "2,340",
            growth: "15% from last month",
          ),
        ),
        SizedBox(
          width: 300,
          child: DashboardCard(
            icon: Icons.attach_money_rounded,
            iconColor: Colors.redAccent,
            bgColor: Color(0xffFFF2F2),
            title: "Total Revenue",
            value: "\$24,560",
            growth: "20% from last month",
          ),
        ),
      ],
    );
  }
}