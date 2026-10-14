import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class TimesTab extends StatelessWidget {
  const TimesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Prayer Times Content',
        style: TextStyle(color: AppColors.gold, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}