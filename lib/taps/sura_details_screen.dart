import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:islamy/core/app_colors.dart';
import 'package:islamy/surah_model.dart';

class SuraDetailsScreen extends StatelessWidget {
  final SurahModel surah;
  final int index;

  const SuraDetailsScreen({
    super.key,
    required this.surah,
    required this.index,
  });

  Future<List<String>> loadSuraFile(int fileIndex) async {
    String content = await rootBundle.loadString('assets/files/$fileIndex.txt');
    List<String> lines = content.split('\n');
    return lines.where((line) => line.trim().isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          surah.nameEn,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/img_left_corner.png',
                      width: 60,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      surah.nameAr,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/img_left_corner.png',
                        width: 60,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: loadSuraFile(index),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.gold,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: AppColors.gold, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final verses = snapshot.data ?? [];

                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 140),
                        child: Text.rich(
                          TextSpan(
                            children: List.generate(verses.length, (i) {
                              return TextSpan(
                                text: '${verses[i].trim()} [${i + 1}] ',
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 20,
                                  height: 2.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/img_bottom_decoration.png',
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}