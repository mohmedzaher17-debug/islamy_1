import 'package:flutter/material.dart';
import 'package:islamy/core/app_colors.dart';
import 'package:islamy/surah_model.dart';
import 'sura_details_screen.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  String searchQuery = '';

  final List<RecentSuraModel> _recentSuras = const [
    RecentSuraModel(
      suraNameEn: 'Al-Anbiya',
      suraNameAr: 'الأنبياء',
      versesCount: '112 Verses',
      index: 21,
    ),
    RecentSuraModel(
      suraNameEn: 'Al-Fatiha',
      suraNameAr: 'الفاتحه',
      versesCount: '7 Verses',
      index: 1,
    ),
    RecentSuraModel(
      suraNameEn: 'Al-Baqarah',
      suraNameAr: 'البقرة',
      versesCount: '286 Verses',
      index: 2,
    ),
    RecentSuraModel(
      suraNameEn: 'Yasin',
      suraNameAr: 'يس',
      versesCount: '83 Verses',
      index: 36,
    ),
    RecentSuraModel(
      suraNameEn: 'Al-Kahf',
      suraNameAr: 'الكهف',
      versesCount: '110 Verses',
      index: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const goldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: AppColors.gold, width: 2),
    );

    final filteredSuras = SurahModel.allSurahs.where((surah) {
      return surah.nameEn.toLowerCase().contains(searchQuery.toLowerCase()) ||
          surah.nameAr.contains(searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            style: const TextStyle(color: AppColors.white),
            cursorColor: AppColors.gold,
            decoration: InputDecoration(
              hintText: 'Sura Name',
              hintStyle: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/icons/ic_quran.png',
                  color: AppColors.gold,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              filled: true,
              fillColor: AppColors.black.withValues(alpha: 0.6),
              enabledBorder: goldBorder,
              focusedBorder: goldBorder,
            ),
          ),
          const SizedBox(height: 16),
          if (searchQuery.isEmpty) ...[
            const Text(
              'Most Recently',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _recentSuras.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = _recentSuras[index];
                  return GestureDetector(
                    onTap: () {
                      final surahModel = SurahModel.allSurahs[item.index - 1];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuraDetailsScreen(
                            surah: surahModel,
                            index: item.index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 285,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  item.suraNameEn,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.suraNameAr,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.versesCount,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/img_most_recent.png',
                            width: 153,
                            height: 136,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          const Text(
            'Suras List',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredSuras.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.white,
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            itemBuilder: (context, index) {
              final surah = filteredSuras[index];
              final originalIndex = SurahModel.allSurahs.indexOf(surah) + 1;
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuraDetailsScreen(
                        surah: surah,
                        index: originalIndex,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Vector.png',
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            '$originalIndex',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surah.nameEn,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${surah.versesCount} Verses',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        surah.nameAr,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecentSuraModel {
  final String suraNameEn;
  final String suraNameAr;
  final String versesCount;
  final int index;

  const RecentSuraModel({
    required this.suraNameEn,
    required this.suraNameAr,
    required this.versesCount,
    required this.index,
  });
}