import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../widgets/participant_card_widget.dart';

class OnlinePlayView extends StatefulWidget {
  const OnlinePlayView({super.key});

  @override
  State<OnlinePlayView> createState() => _OnlinePlayViewState();
}

class _OnlinePlayViewState extends State<OnlinePlayView> {
  bool _isCastingToTv = false;
  bool _cameraActive = true;
  String _roomCode = 'DODIS-7842';

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kOnlineScreenTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TV Casting Status Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3799), Color(0xFF0C2461)],
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isCastingToTv
                                ? Icons.tv_rounded
                                : Icons.cast_connected_rounded,
                            color: kCandyYellow,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isCastingToTv
                                    ? kConnectedToTv
                                    : kMirrorToTv,
                                style: kHeadingSmall.copyWith(
                                  fontSize: 14.sp,
                                  color: kWhite,
                                ),
                              ),
                              Text(
                                _isCastingToTv
                                    ? kTvDescriptionConnected
                                    : kTvDescriptionPrompt,
                                style: kBodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _isCastingToTv,
                          activeThumbColor: kCandyYellow,
                          onChanged: (val) {
                            setState(() => _isCastingToTv = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Room Code & Invite
              Container(
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: kBorderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kYourRoomCode,
                              style: kMiniBadgeStyle.copyWith(
                                color: kSecondaryTextColor,
                              ),
                            ),
                            Text(
                              _roomCode,
                              style: kRoomCodeStyle,
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(kRoomLinkCopied),
                              ),
                            );
                          },
                          icon: const Icon(Icons.share_rounded, size: 16),
                          label: Text(kShare, style: kButtonSmallStyle),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kCandyBlue,
                            foregroundColor: kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Video Call Grid (Remote Opponents)
              Text(
                kConnectedFriendsTitle,
                style: kSectionHeadingStyle.copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: ParticipantCardWidget(
                      name: 'You (Host)',
                      subtitle: 'Camera on',
                      color: kCandyRed,
                      isHost: true,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ParticipantCardWidget(
                      name: 'The Larsson Family',
                      subtitle: 'Stockholm (Online)',
                      color: kCandyGreen,
                      isHost: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: ParticipantCardWidget(
                      name: 'Grandma & Grandkids',
                      subtitle: 'Gothenburg (Online)',
                      color: kCandyYellow,
                      isHost: false,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _roomCode = 'DODIS-${1000 + DateTime.now().millisecond}';
                        });
                      },
                      child: Container(
                        height: 110.h,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: kBorderColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline_rounded,
                                  color: kCandyBlue, size: 28.sp),
                              SizedBox(height: 6.h),
                              Text(
                                kInviteMore,
                                style: kChipTextStyle.copyWith(
                                  color: kCandyBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Interactive Room Camera / Fun Snaps
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: kBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kPartyCamTitle,
                          style: kHeadingSmall.copyWith(fontSize: 14.sp),
                        ),
                        Switch(
                          value: _cameraActive,
                          activeThumbColor: kCandyGreen,
                          onChanged: (v) => setState(() => _cameraActive = v),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      kPartyCamDescription,
                      style: kBodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
    );
  }
}
