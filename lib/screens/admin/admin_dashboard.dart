import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/login_email_screen.dart';

import 'books/all_books_screen.dart';

import 'widgets/admin_sidebar.dart';
import 'widgets/admin_header.dart';
import 'widgets/chart_card.dart';
import 'widgets/dashboard_cards.dart';
import 'widgets/order_status_card.dart';
import 'widgets/recent_orders_table.dart';
import 'widgets/sales_chart.dart';
import 'widgets/top_books_card.dart';
// import 'providers/category_provider.dart';
import 'users/users_screen.dart';
import 'categories/all_categories_screen.dart';
import 'orders/orders_screen.dart';
import 'books/books_screen.dart';
import 'reviews/reviews_screen.dart';
import 'coupons/coupons_screen.dart';
import 'reports/reports_screen.dart';
import 'settings/settings_screen.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  Future<void> _logout() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginEmailScreen()),
      (route) => false,
    );
  }

  Widget dashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminHeader(onLogout: _logout),
          const SizedBox(height: 30),
          const DashboardCards(),
          const SizedBox(height: 30),

          SizedBox(
            height: 380,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ChartCard(
                    title: "Sales Overview",
                    child: const SalesChart(),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  flex: 2,
                  child: ChartCard(
                    title: "Order Status",
                    child: const OrderStatusCard(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 430,
            child: Row(
              children: [
                const Expanded(flex: 3, child: RecentOrdersTable()),
                const SizedBox(width: 25),
                const Expanded(flex: 2, child: TopBooksCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== MAIN FIX ==================
Widget buildPage() {
  switch (selectedIndex) {
    case 0:
      return dashboardHome();

    case 1:
      return const AllBooksScreen();

   case 2:
  return AllCategoriesScreen();
    case 3:
      return const OrdersScreen();

    case 4:
      return const UsersScreen();

    case 5:
      return const ReviewsScreen();

    case 6:
      return const CouponsScreen();

    case 7:
      return const ReportsScreen();

    case 8:
      return const SettingsScreen();

    default:
      return dashboardHome();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 280,
              child: AdminSidebar(
                selectedIndex: selectedIndex,
                onChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
            Expanded(
              child: buildPage(),
            ),
          ],
        ),
      ),
    );
  }
}