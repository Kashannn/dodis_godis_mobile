import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../data/models/game_category_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/category_section_widget.dart';
import '../widgets/dodis_hero_card_widget.dart';
import '../widgets/featured_game_card.dart';
import '../widgets/home_header_widget.dart';
import '../widgets/online_party_banner.dart';
import '../widgets/qr_scanner_dialog.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatelessWidget {
  const _HomeViewContent();

  void _showQrScanner(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QrScannerDialog(),
    );
  }

  void _handleGameTap(BuildContext context, GameItemModel game) {
    if (game.id == 'yatzy') {
      context.push(Routes.yatzy);
    } else if (game.id == 'dejtkort' || game.id == 'naughty_18') {
      context.push(Routes.dateCards);
    } else {
      context.push(Routes.rules);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final forfestCategory = state.categories.firstWhere(
              (c) => c.id == 'forfest',
              orElse: () => state.categories.first,
            );

            final fragesportCategory = state.categories.firstWhere(
              (c) => c.id == 'fragesport',
              orElse: () => state.categories[1],
            );

            final otherCategories = state.categories
                .where((c) => c.id != 'forfest' && c.id != 'fragesport')
                .toList();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header with QR & Reward Mode Switch
                  HomeHeaderWidget(
                    onScanQrTap: () => _showQrScanner(context),
                  ),
                  SizedBox(height: 18.h),

                  // 2. Featured Dodis Godis Spelet Hero Card
                  const DodisHeroCardWidget(),
                  SizedBox(height: 22.h),

                  // 3. Förfest Section
                  _buildSectionTitle(
                    title: kCategoryParty.toUpperCase(),
                    subtitle: kPartySubtitle,
                    accentColor: kCandyPink,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: forfestCategory.games.map((game) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: game == forfestCategory.games.first ? 10.w : 0,
                          ),
                          child: FeaturedGameCard(
                            game: game,
                            onTap: () => _handleGameTap(context, game),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 22.h),

                  // 4. Frågesport Section
                  _buildSectionTitle(
                    title: kCategoryTrivia.toUpperCase(),
                    subtitle: kTriviaSubtitle,
                    accentColor: kCandyBlue,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: fragesportCategory.games.map((game) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: game == fragesportCategory.games.first ? 10.w : 0,
                          ),
                          child: FeaturedGameCard(
                            game: game,
                            onTap: () => _handleGameTap(context, game),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 22.h),

                  // 5. Online Remote Party Banner
                  const OnlinePartyBanner(),
                  SizedBox(height: 22.h),

                  // 6. Andra Kategorier Section
                  Row(
                    children: [
                      Text(
                        kOtherCategories,
                        style: kSectionHeadingStyle,
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () => context.push(Routes.rules),
                        icon: Icon(Icons.rule_folder_rounded, size: 16.sp, color: kCandyRed),
                        label: Text(
                          kAllRules,
                          style: kButtonSmallStyle.copyWith(color: kCandyRed),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  ...otherCategories.map((cat) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CategorySectionWidget(
                        category: cat,
                        onGameTap: (game) => _handleGameTap(context, game),
                      ),
                    );
                  }),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: kSectionHeadingStyle,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: kBodySmall,
        ),
      ],
    );
  }
}
