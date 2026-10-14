import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class RadioTab extends StatelessWidget {
  const RadioTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Radio Content',
        style: TextStyle(color: AppColors.gold, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}