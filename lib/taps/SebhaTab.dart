import 'package:flutter/material.dart';
import 'package:islamy/core/app_colors.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int textIndex = 0;
  double _angle = 0.0;

  final List<String> tasabeeh = [
    'سبحان الله',
    'الحمدلله',
    'الله اكبر',
  ];

  void onSebhaPressed() {
    setState(() {
      counter++;
      _angle += 0.26;

      if (counter > 33) {
        counter = 1;
        textIndex = (textIndex + 1) % tasabeeh.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSebhaPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'سَبِّحْ اسْمَ رَبِّكَ الأَعْلَى',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/Group 37.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 5),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedRotation(
                          turns: _angle,
                          duration: const Duration(milliseconds: 300),
                          child: Image.asset(
                            'assets/images/SebhaBody 1.png',
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tasabeeh[textIndex],
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$counter',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}