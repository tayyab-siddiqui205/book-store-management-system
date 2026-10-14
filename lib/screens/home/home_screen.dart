import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/book_provider.dart';

// Widgets Imports
import 'widgets/home_appbar.dart';
import 'widgets/hero_banner.dart';
import 'widgets/top_category_section.dart';
import 'widgets/book_section.dart';
import 'widgets/new_arrival_section.dart';     // ← Yeh line sahi honi chahiye
import 'widgets/search_result_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F7FC),
      body: SafeArea(
        child: Consumer<BookProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeAppBar(),
                  const SizedBox(height: 24),

                  if (provider.searchText.isNotEmpty) ...[
                    const SearchResultSection(),
                    const SizedBox(height: 30),
                  ] else ...[
                    const HeroBanner(),
                    const SizedBox(height: 30),

                    const TopCategorySection(),
                    const SizedBox(height: 35),

                    BookSection(),
                    const SizedBox(height: 35),

                    NewArrivalSection(),           // ← Yeh line
                    const SizedBox(height: 40),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}