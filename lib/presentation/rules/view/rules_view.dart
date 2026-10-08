import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../home/widgets/qr_scanner_dialog.dart';
import '../widgets/challenge_card_widget.dart';
import '../widgets/rules_header_banner_widget.dart';
import '../widgets/rules_step_section_widget.dart';

class RulesView extends StatefulWidget {
  const RulesView({super.key});

  @override
  State<RulesView> createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
  String _searchQuery = '';
  String _selectedTab = kRulesTabAll;

  final List<_ChallengeData> _challenges = [
    _ChallengeData(
      number: 1,
      title: kChallenge1Title,
      swedishSubtitle: kChallenge1Swedish,
      description: kChallenge1Desc,
      tag: kChallenge1Tag,
      imagePath: kChallengeDropImage,
      accentColor: const Color(0xFFF1C40F),
    ),
    _ChallengeData(
      number: 2,
      title: kChallenge2Title,
      swedishSubtitle: kChallenge2Swedish,
      description: kChallenge2Desc,
      tag: kChallenge2Tag,
      imagePath: kChallengeTrueFalseImage,
      accentColor: const Color(0xFF2ECC71),
    ),
    _ChallengeData(
      number: 3,
      title: kChallenge3Title,
      swedishSubtitle: kChallenge3Swedish,
      description: kChallenge3Desc,
      tag: kChallenge3Tag,
      imagePath: kChallengeClosestTossImage,
      accentColor: const Color(0xFF3498DB),
    ),
    _ChallengeData(
      number: 4,
      title: kChallenge4Title,
      swedishSubtitle: kChallenge4Swedish,
      description: kChallenge4Desc,
      tag: kChallenge4Tag,
      imagePath: kChallengeCoinFlipImage,
      accentColor: const Color(0xFFE67E22),
    ),
    _ChallengeData(
      number: 5,
      title: kChallenge5Title,
      swedishSubtitle: kChallenge5Swedish,
      description: kChallenge5Desc,
      tag: kChallenge5Tag,
      imagePath: kChallengeGuessHandImage,
      accentColor: const Color(0xFF9B59B6),
    ),
    _ChallengeData(
      number: 6,
      title: kChallenge6Title,
      swedishSubtitle: kChallenge6Swedish,
      description: kChallenge6Desc,
      tag: kChallenge6Tag,
      imagePath: kChallengeCatchMouthImage,
      accentColor: const Color(0xFFFF527B),
    ),
    _ChallengeData(
      number: 7,
      title: kChallenge7Title,
      swedishSubtitle: kChallenge7Swedish,
      description: kChallenge7Desc,
      tag: kChallenge7Tag,
      imagePath: kChallengePullStringImage,
      accentColor: const Color(0xFF16A085),
    ),
    _ChallengeData(
      number: 8,
      title: kChallenge8Title,
      swedishSubtitle: kChallenge8Swedish,
      description: kChallenge8Desc,
      tag: kChallenge8Tag,
      imagePath: kChallengeSpinningTopImage,
      accentColor: const Color(0xFFF39C12),
    ),
    _ChallengeData(
      number: 9,
      title: kChallenge9Title,
      swedishSubtitle: kChallenge9Swedish,
      description: kChallenge9Desc,
      tag: kChallenge9Tag,
      imagePath: kChallengeSuperSourImage,
      accentColor: const Color(0xFFE74C3C),
    ),
  ];

  void _showQrScanner(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QrScannerDialog(),
    );
  }

  void _showImagePreview(BuildContext context, _ChallengeData challenge) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: challenge.accentColor, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        challenge.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Text(
                            challenge.title,
                            style: kHeadingSmall.copyWith(
                              fontSize: 18.sp,
                              color: kPrimaryTextColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            challenge.swedishSubtitle,
                            style: kBodySmall.copyWith(
                              color: kSecondaryTextColor,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            IconButton.filled(
              onPressed: () => Navigator.pop(ctx),
              icon: const Icon(Icons.close_rounded, color: kWhite),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.6),
                padding: EdgeInsets.all(12.w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.toLowerCase().trim();

    final filteredChallenges = _challenges.where((c) {
      if (query.isEmpty) return true;
      return c.title.toLowerCase().contains(query) ||
          c.swedishSubtitle.toLowerCase().contains(query) ||
          c.description.toLowerCase().contains(query) ||
          c.tag.toLowerCase().contains(query);
    }).toList();

    final showSetup = (_selectedTab == kRulesTabAll || _selectedTab == kRulesTabSetup) &&
        (query.isEmpty ||
            kSetupTitle.toLowerCase().contains(query) ||
            kSetupStep1Desc.toLowerCase().contains(query));

    final showGameplay = (_selectedTab == kRulesTabAll || _selectedTab == kRulesTabTurn) &&
        (query.isEmpty ||
            kTurnTitle.toLowerCase().contains(query) ||
            kTurnStep1Desc.toLowerCase().contains(query));

    final showWinning = (_selectedTab == kRulesTabAll || _selectedTab == kRulesTabWinning) &&
        (query.isEmpty ||
            kWinningTitle.toLowerCase().contains(query) ||
            kWinningDesc.toLowerCase().contains(query));

    final showChallenges = _selectedTab == kRulesTabAll || _selectedTab == kRulesTabChallenges;

    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kRulesTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Banner with rainbow candy title
            const RulesHeaderBannerWidget(),
            SizedBox(height: 16.h),

            // 2. Search Field
            TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: kRulesSearchHint,
                hintStyle: kBodyMedium,
                prefixIcon: const Icon(Icons.search_rounded, color: kSecondaryTextColor),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: kSecondaryTextColor),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                fillColor: kWhite,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // 3. Filter Tabs Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabChip(kRulesTabAll),
                  SizedBox(width: 8.w),
                  _buildTabChip(kRulesTabSetup),
                  SizedBox(width: 8.w),
                  _buildTabChip(kRulesTabTurn),
                  SizedBox(width: 8.w),
                  _buildTabChip(kRulesTabWinning),
                  SizedBox(width: 8.w),
                  _buildTabChip(kRulesTabChallenges),
                ],
              ),
            ),
            SizedBox(height: 18.h),

            // 4. Game Rules: Setup, Gameplay & Win
            if (showSetup || showGameplay || showWinning) ...[
              RulesStepSectionWidget(
                onQrTap: () => _showQrScanner(context),
              ),
              SizedBox(height: 24.h),
            ],

            // 5. The 9 Circular Challenges Section
            if (showChallenges && filteredChallenges.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    width: 5.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: kCandyRed,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kThe9ChallengesHeader,
                          style: kSectionHeadingStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          kThe9ChallengesSubtitle,
                          style: kBodySmall.copyWith(
                            color: kSecondaryTextColor,
                            fontSize: 11.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // Render Challenge Cards
              ...filteredChallenges.map((challenge) {
                return InkWell(
                  onTap: () => _showImagePreview(context, challenge),
                  borderRadius: BorderRadius.circular(22.r),
                  child: ChallengeCardWidget(
                    number: challenge.number,
                    title: challenge.title,
                    swedishSubtitle: challenge.swedishSubtitle,
                    description: challenge.description,
                    tag: challenge.tag,
                    imagePath: challenge.imagePath,
                    accentColor: challenge.accentColor,
                    onPlayTap: () => _showImagePreview(context, challenge),
                  ),
                );
              }),
            ],

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTabChip(String label) {
    final isSelected = _selectedTab == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: kCandyPink.withValues(alpha: 0.2),
      backgroundColor: kWhite,
      side: BorderSide(
        color: isSelected ? kCandyPink : kBorderColor,
      ),
      labelStyle: kChipTextStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? kCandyPink : kPrimaryTextColor,
      ),
      onSelected: (_) {
        setState(() {
          _selectedTab = label;
        });
      },
    );
  }
}

class _ChallengeData {
  final int number;
  final String title;
  final String swedishSubtitle;
  final String description;
  final String tag;
  final String imagePath;
  final Color accentColor;

  _ChallengeData({
    required this.number,
    required this.title,
    required this.swedishSubtitle,
    required this.description,
    required this.tag,
    required this.imagePath,
    required this.accentColor,
  });
}
