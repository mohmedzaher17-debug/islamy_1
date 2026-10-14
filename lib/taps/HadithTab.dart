import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy/core/app_colors.dart';
import 'dart:math' as math;

class HadithTab extends StatelessWidget {
  const HadithTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HadithModel> hadiths = List.generate(50, (index) {
      int number = index + 1;
      return HadithModel(
        title: 'الحديث رقم $number',
        filePath: 'assets/files/hadith/h$number.txt',
      );
    });

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: PageView.builder(
          itemCount: hadiths.length,
          controller: PageController(viewportFraction: 0.82),
          itemBuilder: (context, index) {
            return HadithCard(hadith: hadiths[index]);
          },
        ),
      ),
    );
  }
}

class HadithCard extends StatelessWidget {
  final HadithModel hadith;

  const HadithCard({super.key, required this.hadith});

  Future<String> loadHadithContent() async {
    try {
      String content = await rootBundle.loadString(hadith.filePath);
      return content.trim();
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Opacity(
                  opacity: 0.15,
                  child: Image.asset(
                    'assets/images/welcome 3.png',
                    width: 260,
                    height: 260,
                    fit: BoxFit.contain,
                    color: AppColors.black,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/img_bottom_decoration.png',
                height: 110,
                fit: BoxFit.cover,
                color: AppColors.black,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/img_left_corner.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.contain,
                        color: AppColors.black,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      Expanded(
                        child: Text(
                          hadith.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(
                          'assets/images/img_left_corner.png',
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                          color: AppColors.black,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: FutureBuilder<String>(
                      future: loadHadithContent(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          );
                        }

                        String text = snapshot.data ?? '';

                        return SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 90),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1.8,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HadithModel {
  final String title;
  final String filePath;

  const HadithModel({
    required this.title,
    required this.filePath,
  });
}