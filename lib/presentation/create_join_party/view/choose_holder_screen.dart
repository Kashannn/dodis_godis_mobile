import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../dodis_game/bloc/dodis_game_state.dart';
import '../../splash/widgets/tap_to_play_button.dart';
import '../bloc/choose_holder_bloc.dart';
import '../bloc/choose_holder_event.dart';
import '../bloc/choose_holder_state.dart';
import '../bloc/create_party_state.dart';
import '../widgets/holder_color_palette_widget.dart';
import '../widgets/holder_player_card_widget.dart';

class ChooseHolderScreen extends StatelessWidget {
  final List<PartyPlayerModel> players;

  const ChooseHolderScreen({
    super.key,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseHolderBloc(initialPlayers: players),
      child: const _ChooseHolderScreenContent(),
    );
  }
}

class _ChooseHolderScreenContent extends StatelessWidget {
  const _ChooseHolderScreenContent();

  void _onReadyPressed(BuildContext context, ChooseHolderState state) {
    final gamePlayers = state.players.map((p) {
      final displayName =
          p.name.trim().isEmpty ? 'Player ${p.id}' : p.name.trim();
      return GamePlayer(
        id: p.id.toString(),
        name: displayName,
        candyCount: 2,
        currentTile: 0,
        avatarIndex: (p.id - 1) % 6,
        avatarPath: p.avatarPath,
        holderColor: p.holderColor,
        holderColorName: p.holderColorName,
      );
    }).toList();

    context.push(Routes.dodisGame, extra: gamePlayers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseHolderBloc, ChooseHolderState>(
      builder: (context, state) {
        return AppCustomScaffold(
          backgroundColor: const Color(0xFFFBF8F2),
          appBar: AppCustomAppBar(
            title: kChooseYourHolderTitle,
            onBackTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.pop();
              }
            },
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.players.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.88,
                          ),
                          itemBuilder: (context, index) {
                            final player = state.players[index];
                            final isActive =
                                state.activePlayerIndex == index;
                            return HolderPlayerCardWidget(
                              player: player,
                              isActive: isActive,
                              onTap: () {
                                context.read<ChooseHolderBloc>().add(
                                      SelectActivePlayerEvent(index),
                                    );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        HolderColorPaletteWidget(
                          selectedColor: HolderColorOption(
                            name: state.activePlayer.holderColorName,
                            color: state.activePlayer.holderColor,
                          ),
                          onColorSelected: (option) {
                            context.read<ChooseHolderBloc>().add(
                                  ChangeActivePlayerColorEvent(option),
                                );
                          },
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: TapToPlayButton(
                    text: kReadyButton,
                    width: double.infinity,
                    height: 60.h,
                    fontSize: 24.sp,
                    gradientColors: const [
                      Color(0xFF45D461),
                      Color(0xFF28B744),
                      Color(0xFF1A9331),
                    ],
                    borderColor: const Color(0xFF116522),
                    textColor: Colors.white,
                    onPressed: () => _onReadyPressed(context, state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
