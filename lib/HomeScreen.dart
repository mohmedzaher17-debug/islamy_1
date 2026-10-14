import 'package:flutter/material.dart';
import 'package:islamy/taps/RadioTab.dart';
import 'taps/HadithTab.dart';
import 'taps/QuranTab.dart';
import 'taps/SebhaTab.dart';
import 'taps/TimesTab.dart';
import 'core/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _backgroundImages = [
    'assets/images/quran_bg.png',
    'assets/images/hadith_bg.png',
    'assets/images/sebha_bg.png',
    'assets/images/radio_bg.png',
    'assets/images/more_bg.png',
  ];

  final List<Widget> _tabs = const [
    QuranTab(),
    HadithTab(),
    SebhaTab(),
    RadioTab(),
    TimesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_backgroundImages[_currentIndex]),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.black.withValues(alpha: 0.85),
              AppColors.black.withValues(alpha: 0.50),
              AppColors.black.withValues(alpha: 0.95),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/Group 30.png',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _tabs[_currentIndex],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: AppColors.gold,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('assets/icons/ic_quran.png', 'Quran', 0),
                _buildNavItem('assets/icons/Page-1.png', 'Hadith', 1),
                _buildNavItem('assets/icons/necklace-islam-svgrepo-com 1.png', 'Sebha', 2),
                _buildNavItem('assets/icons/radio-svgrepo-com 1.png', 'Radio', 3),
                _buildNavItem('assets/icons/Vector.png', 'Time', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String assetPath, String label, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
            : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(
              AssetImage(assetPath),
              color: isSelected ? AppColors.gold : AppColors.black,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}C:\Users\user\StudioProjects\islamy