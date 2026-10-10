import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../bloc/create_party_state.dart';

class PartyPlayerNamesListWidget extends StatelessWidget {
  final List<PartyPlayerModel> players;
  final void Function(int index, String newName) onNameChanged;
  final void Function(int index) onClearName;

  const PartyPlayerNamesListWidget({
    super.key,
    required this.players,
    required this.onNameChanged,
    required this.onClearName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(
              Icons.badge_rounded,
              color: kPartyPrimaryBlue,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              kPlayerNamesLabel,
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: kPartyTextDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // List of Dynamic Player Input Rows
        ...List.generate(players.length, (index) {
          final player = players[index];
          return _PlayerNameTile(
            key: ValueKey('player_${player.id}'),
            player: player,
            index: index,
            onNameChanged: onNameChanged,
            onClearName: onClearName,
          );
        }),
      ],
    );
  }
}

class _PlayerNameTile extends StatefulWidget {
  final PartyPlayerModel player;
  final int index;
  final void Function(int index, String newName) onNameChanged;
  final void Function(int index) onClearName;

  const _PlayerNameTile({
    super.key,
    required this.player,
    required this.index,
    required this.onNameChanged,
    required this.onClearName,
  });

  @override
  State<_PlayerNameTile> createState() => _PlayerNameTileState();
}

class _PlayerNameTileState extends State<_PlayerNameTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.player.name);
  }

  @override
  void didUpdateWidget(covariant _PlayerNameTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player.name != widget.player.name &&
        _controller.text != widget.player.name) {
      _controller.text = widget.player.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: kPartyCardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: kPartyInputBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: kPartyCardShadow.withValues(alpha: 0.04),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Player Index Number
          SizedBox(
            width: 22.w,
            child: Text(
              '${widget.player.id}',
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w900,
                color: kPartyTextDark,
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // 2. High-Quality Cartoon Avatar Badge
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.player.isHost
                    ? const Color(0xFFFFB300)
                    : kPartyLightBlue,
                width: 2.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (widget.player.isHost
                          ? const Color(0xFFFFB300)
                          : kPartyPrimaryBlue)
                      .withValues(alpha: 0.25),
                  blurRadius: 6.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.player.avatarPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // 3. Editable Player Name TextField
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                widget.onNameChanged(widget.index, val);
              },
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: kPartyTextDark,
              ),
              decoration: InputDecoration(
                hintText: 'Player ${widget.player.id}',
                hintStyle: GoogleFonts.comicNeue(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: kPartyTextSubtle,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          // 4. Action / Status Icon (Crown for Host, Clear for Others)
          if (widget.player.isHost)
            Container(
              padding: EdgeInsets.all(4.w),
              child: Icon(
                Icons.emoji_events_rounded,
                color: const Color(0xFFFFB300),
                size: 22.sp,
              ),
            )
          else
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onClearName(widget.index);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: kPartyUnselectedFill,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: kPartyTextSubtle,
                  size: 16.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
