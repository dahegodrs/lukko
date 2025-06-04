import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'components/home_header.dart';
import 'components/image_carousel.dart';
import 'components/financial_summary_card.dart';
import 'components/top_accounts_card.dart';
import 'components/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            HomeHeader(),
            SizedBox(height: 16),
            ImageCarousel(),
            SizedBox(height: 24),
            FinancialSummaryCard(),
            SizedBox(height: 24),
            TopAccountsCard(),
          ],
        ),
      ),
    );
  }
}
