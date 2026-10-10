import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../splash/widgets/tap_to_play_button.dart';
import '../bloc/create_party_bloc.dart';
import '../bloc/create_party_event.dart';
import '../bloc/create_party_state.dart';
import '../widgets/party_hero_header_widget.dart';
import '../widgets/party_mode_selector_widget.dart';
import '../widgets/party_name_input_widget.dart';
import '../widgets/party_player_names_list_widget.dart';
import '../widgets/party_player_selector_widget.dart';

class CreatePartyScreen extends StatelessWidget {
  const CreatePartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreatePartyBloc>(),
      child: const _CreatePartyBody(),
    );
  }
}

class _CreatePartyBody extends StatefulWidget {
  const _CreatePartyBody();

  @override
  State<_CreatePartyBody> createState() => _CreatePartyBodyState();
}

class _CreatePartyBodyState extends State<_CreatePartyBody>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _partyNameController;
  late final AnimationController _floatController;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _partyNameController = TextEditingController(text: kDefaultPartyName);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _partyNameController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onStartParty(BuildContext context, CreatePartyState state) {
    // Navigate to Choose Holder Screen with configured players
    context.push(Routes.chooseHolder, extra: state.players);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyBloc, CreatePartyState>(
      builder: (context, state) {
        return AppCustomScaffold(
          backgroundColor: kPartySkyLight,
          appBar: AppCustomAppBar(
            title: kCreatePartyTitle,
            onBackTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.go(Routes.home);
              }
            },
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPartySkyLight,
                  kPartySkyMid,
                  kPartySkyWhite,
                ],
              ),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
                child: Column(
                  children: [
                    // 1. Hero 3D Illustration & Candy Composition (Modular Widget)
                    PartyHeroHeaderWidget(floatAnim: _floatAnim),
                    SizedBox(height: 16.h),

                    // 2. Main Party Setup Form Card driven by BLoC
                    _buildPartySetupCard(context, state),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Clean White Setup Form Card hosting modular widgets driven by BLoC
  Widget _buildPartySetupCard(BuildContext context, CreatePartyState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: kPartyCardBackground,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: kPartyCardShadow.withValues(alpha: 0.08),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Party Name Input
          PartyNameInputWidget(
            controller: _partyNameController,
            onChanged: (name) {
              context.read<CreatePartyBloc>().add(UpdatePartyNameEvent(name));
            },
          ),
          SizedBox(height: 18.h),

          // 2. Player Count Selector (2, 3, 4, 5, 6)
          PartyPlayerSelectorWidget(
            selectedPlayerCount: state.playerCount,
            onPlayerCountChanged: (count) {
              context.read<CreatePartyBloc>().add(UpdatePlayerCountEvent(count));
            },
          ),
          SizedBox(height: 18.h),

          // 3. Dynamic Player Names & Avatars List (2-6 items)
          PartyPlayerNamesListWidget(
            players: state.players,
            onNameChanged: (index, newName) {
              context.read<CreatePartyBloc>().add(
                    UpdatePlayerNameEvent(index: index, name: newName),
                  );
            },
            onClearName: (index) {
              context.read<CreatePartyBloc>().add(ClearPlayerNameEvent(index));
            },
          ),
          SizedBox(height: 18.h),

          // 4. Game Mode Selector (Classic / Quick)
          PartyModeSelectorWidget(
            selectedMode: state.mode,
            onModeChanged: (mode) {
              context.read<CreatePartyBloc>().add(UpdateGameModeEvent(mode));
            },
          ),
          SizedBox(height: 24.h),

          // 5. Start Party Action Button (TapToPlayButton)
          Center(
            child: TapToPlayButton(
              text: kStartPartyButton,
              width: double.infinity,
              height: 58.h,
              fontSize: 21.sp,
              gradientColors: kPartyButtonGradient,
              borderColor: kPartyButtonGreenBorder,
              textColor: kWhite,
              onPressed: () => _onStartParty(context, state),
            ),
          ),
        ],
      ),
    );
  }
}
