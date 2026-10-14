import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_images.dart';

enum BacksideGameMode {
  fullBoard,
  noughtsAndCrosses,
  printableBoard,
  fyraIRad,
  backgammon,
  yatzy,
  trivialPursuit,
  illustratedBoard,
}

/// Interactive widget representing the Back Side (Baksida) of the Dodis Godis board
/// ("MULTIFUNCTIONAL BOARD"): Yatzy, Backgammon, Four in a Row & TP compatibility.
class MultifunctionalBoardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final VoidCallback? onFlipToFront;

  const MultifunctionalBoardWidget({
    super.key,
    this.width,
    this.height,
    this.onFlipToFront,
  });

  @override
  State<MultifunctionalBoardWidget> createState() =>
      _MultifunctionalBoardWidgetState();
}

class _MultifunctionalBoardWidgetState
    extends State<MultifunctionalBoardWidget> {
  BacksideGameMode _selectedMode = BacksideGameMode.fullBoard;

  // 7 columns x 6 rows for Four in a Row interactive demonstration
  late List<List<int>> _connectFourGrid; // 0 = empty, 1 = red, 2 = white/yellow
  int _currentPlayerTurn = 1;

  // 3x3 Grid for Noughts & Crosses (Corner Game)
  late List<int> _ticTacToeGrid; // 0 = empty, 1 = red chip (X), 2 = yellow chip (O)
  int _ticTacToeTurn = 1;
  String? _ticTacToeWinner;

  @override
  void initState() {
    super.initState();
    _resetConnectFour();
    _resetTicTacToe();
  }

  void _resetTicTacToe() {
    _ticTacToeGrid = List.filled(9, 0);
    // Pre-place a couple of pieces like the corner sketch (center = O, top-left = X)
    _ticTacToeGrid[4] = 2; // Center Yellow O
    _ticTacToeGrid[0] = 1; // Top-Left Red X
    _ticTacToeTurn = 1;
    _ticTacToeWinner = null;
  }

  void _tapTicTacToe(int idx) {
    if (_ticTacToeGrid[idx] != 0 || _ticTacToeWinner != null) return;
    setState(() {
      _ticTacToeGrid[idx] = _ticTacToeTurn;
      const winLines = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
      ];
      for (final line in winLines) {
        if (_ticTacToeGrid[line[0]] != 0 &&
            _ticTacToeGrid[line[0]] == _ticTacToeGrid[line[1]] &&
            _ticTacToeGrid[line[0]] == _ticTacToeGrid[line[2]]) {
          _ticTacToeWinner = _ticTacToeGrid[line[0]] == 1 ? '🔴 Red Candy Wins!' : '🟡 Yellow Candy Wins!';
          return;
        }
      }
      if (!_ticTacToeGrid.contains(0)) {
        _ticTacToeWinner = 'Tie! Both get candy 🍬';
      } else {
        _ticTacToeTurn = _ticTacToeTurn == 1 ? 2 : 1;
      }
    });
  }

  void _resetConnectFour() {
    _connectFourGrid = List.generate(6, (_) => List.filled(7, 0));
    _currentPlayerTurn = 1;
    // Pre-populate a few pieces to look like an exciting match in progress
    _connectFourGrid[5][3] = 1; // Red
    _connectFourGrid[5][2] = 2; // White
    _connectFourGrid[5][4] = 1; // Red
    _connectFourGrid[4][3] = 2; // White
    _connectFourGrid[4][2] = 1; // Red
  }

  void _dropPiece(int col) {
    for (int r = 5; r >= 0; r--) {
      if (_connectFourGrid[r][col] == 0) {
        setState(() {
          _connectFourGrid[r][col] = _currentPlayerTurn;
          _currentPlayerTurn = _currentPlayerTurn == 1 ? 2 : 1;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF7EE),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3E2723).withValues(alpha: 0.12),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header / Mode Switcher Pills
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'BACK SIDE',
                    style: GoogleFonts.comicNeue(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Multifunctional Board',
                    style: GoogleFonts.comicNeue(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2E1C0C),
                    ),
                  ),
                ),
                if (widget.onFlipToFront != null)
                  TextButton.icon(
                    onPressed: widget.onFlipToFront,
                    icon: Icon(
                      Icons.flip_to_front_rounded,
                      size: 16.sp,
                      color: const Color(0xFFE65100),
                    ),
                    label: Text(
                      'Front Side',
                      style: GoogleFonts.comicNeue(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE65100),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
              ],
            ),
          ),

          // Game Mode Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                _buildModePill('🎯 Full Board', BacksideGameMode.fullBoard),
                _buildModePill('❌⭕ Noughts & Crosses', BacksideGameMode.noughtsAndCrosses),
                _buildModePill('📄 Printable Front Side', BacksideGameMode.printableBoard),
                _buildModePill('🔴 Four in a Row', BacksideGameMode.fyraIRad),
                _buildModePill('🎲 Backgammon', BacksideGameMode.backgammon),
                _buildModePill('📝 Yatzy', BacksideGameMode.yatzy),
                _buildModePill('🍰 Trivial Pursuit', BacksideGameMode.trivialPursuit),
                _buildModePill('🎨 Illustrated Board', BacksideGameMode.illustratedBoard),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Mode Content Display
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: _buildCurrentModeContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildModePill(String label, BacksideGameMode mode) {
    final isSelected = _selectedMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: Container(
        margin: EdgeInsets.only(right: 6.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1B5E20)
                : const Color(0xFFD7CCC8),
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                    blurRadius: 6.r,
                    offset: Offset(0, 2.h),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.comicNeue(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF5D4037),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentModeContent() {
    switch (_selectedMode) {
      case BacksideGameMode.fullBoard:
        return _buildFullBoardView();
      case BacksideGameMode.noughtsAndCrosses:
        return _buildNoughtsAndCrossesInteractiveView();
      case BacksideGameMode.printableBoard:
        return _buildPrintableBoardView();
      case BacksideGameMode.fyraIRad:
        return _buildFyraIRadInteractiveView();
      case BacksideGameMode.backgammon:
        return _buildBackgammonDetailView();
      case BacksideGameMode.yatzy:
        return _buildYatzyDetailView();
      case BacksideGameMode.trivialPursuit:
        return _buildTrivialPursuitCompatibilityView();
      case BacksideGameMode.illustratedBoard:
        return _buildIllustratedBoardView();
    }
  }

  /// 1. Full Board View: Custom drawn board matching design
  Widget _buildFullBoardView() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 380.h,
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF8D6E63), width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.r),
            child: CustomPaint(
              painter: _MultifunctionalBoardPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Explanatory Chips Bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFD7CCC8)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  size: 16.sp, color: const Color(0xFF2E7D32)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  '3-in-1 Back Side: Yatzy at top, Backgammon points on sides, and Four in a Row (7x6) in the center! 42 candy chips in the bag.',
                  style: GoogleFonts.comicNeue(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4E342E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Noughts & Crosses (Corner Game from Printable Sketch)
  Widget _buildNoughtsAndCrossesInteractiveView() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF673AB7).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF673AB7), width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Noughts & Crosses (Corner Game)',
                      style: GoogleFonts.comicNeue(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF311B92),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Tic-Tac-Toe in top-right corner with candy chips',
                      style: GoogleFonts.comicNeue(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5E35B1),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(_resetTicTacToe),
                icon: const Icon(Icons.refresh_rounded),
                color: const Color(0xFF311B92),
                tooltip: 'Restart',
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // 3x3 Tic-Tac-Toe Grid
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFD1C4E9), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: SizedBox(
              width: 210.w,
              height: 210.w,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, idx) {
                  final cell = _ticTacToeGrid[idx];
                  return GestureDetector(
                    onTap: () => _tapTicTacToe(idx),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cell == 1
                            ? const Color(0xFFFFEBEE)
                            : cell == 2
                                ? const Color(0xFFFFFDE7)
                                : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: cell == 1
                              ? const Color(0xFFE53935)
                              : cell == 2
                                  ? const Color(0xFFFBC02D)
                                  : const Color(0xFFE0E0E0),
                          width: 1.8,
                        ),
                      ),
                      child: Center(
                        child: cell == 1
                            ? Text(
                                '🔴',
                                style: TextStyle(fontSize: 26.sp),
                              )
                            : cell == 2
                                ? Text(
                                    '🟡',
                                    style: TextStyle(fontSize: 26.sp),
                                  )
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Status & Winner text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _ticTacToeWinner != null
                  ? const Color(0xFFFFD54F)
                  : const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              _ticTacToeWinner != null
                  ? '🎉 $_ticTacToeWinner'
                  : 'Turn: ${_ticTacToeTurn == 1 ? "🔴 Red Candy" : "🟡 Yellow Candy"}',
              style: GoogleFonts.comicNeue(
                fontSize: 13.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF311B92),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Printable Front Side Board View
  Widget _buildPrintableBoardView() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF8D6E63).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '📄 Printable Board (Front Side)',
                  style: GoogleFonts.comicNeue(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4E342E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF43A047),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Print Ready',
                  style: GoogleFonts.comicNeue(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'The board front side formatted for print: 6 color spokes connecting to center Trivial Pursuit pie, START ZONE in bottom-left, and Noughts & Crosses in top-right corner!',
            style: GoogleFonts.comicNeue(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5D4037),
            ),
          ),
          SizedBox(height: 10.h),
          InteractiveViewer(
            minScale: 1.0,
            maxScale: 3.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                kPrintableBoardFrontside,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Center(
            child: Text(
              'Pinch to zoom printable layout & symbols',
              style: GoogleFonts.comicNeue(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8D6E63),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 2. Interactive Four in a Row (Connect 4) View
  Widget _buildFyraIRadInteractiveView() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2E7D32), width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Four in a Row (7 x 6 = 42 slots)',
                      style: GoogleFonts.comicNeue(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1B5E20),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '21x Red vs 21x White candies from the bag',
                      style: GoogleFonts.comicNeue(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF388E3C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(_resetConnectFour),
                icon: const Icon(Icons.refresh_rounded),
                color: const Color(0xFF1B5E20),
                tooltip: 'Restart',
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Connect 4 Grid (Interactive!)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: List.generate(6, (r) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (c) {
                      final cell = _connectFourGrid[r][c];
                      Color cellColor;
                      if (cell == 1) {
                        cellColor = const Color(0xFFFF3D00); // Red
                      } else if (cell == 2) {
                        cellColor = const Color(0xFFFFF9C4); // White / Light Yellow
                      } else {
                        cellColor = const Color(0xFF1B5E20); // Empty hole
                      }

                      return GestureDetector(
                        onTap: () => _dropPiece(c),
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cellColor,
                            border: Border.all(
                              color: cell == 0
                                  ? const Color(0xFF0F3913)
                                  : Colors.white,
                              width: cell == 0 ? 1.5 : 2.0,
                            ),
                            boxShadow: cell != 0
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 4.r,
                                      offset: Offset(0, 2.h),
                                    ),
                                  ]
                                : null,
                          ),
                          child: cell != 0
                              ? Center(
                                  child: Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(alpha: 0.5),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap any column to drop a candy! Turn: ${_currentPlayerTurn == 1 ? "🔴 Red Candy" : "⚪ White Candy"}',
            style: GoogleFonts.comicNeue(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  /// 3. Backgammon Detailed Explanation
  Widget _buildBackgammonDetailView() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD7CCC8).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF8D6E63), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '🎲 Backgammon – 24 Points',
                  style: GoogleFonts.comicNeue(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4E342E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF8D6E63),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '15 vs 15 Checkers',
                  style: GoogleFonts.comicNeue(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'The board’s back side features standard 24 triangular points in red and blue, divided by a center wooden bar.',
            style: GoogleFonts.comicNeue(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5D4037),
            ),
          ),
          SizedBox(height: 8.h),
          _buildInfoRow('🔴 15x Red Candies', 'Player 1 moves their checkers towards their home board.'),
          _buildInfoRow('⚪ 15x White Candies', 'Player 2 moves towards their opposite home board.'),
          _buildInfoRow('🎲 4x Candy Dice', 'Each player rolls 2 dice to make moves.'),
          _buildInfoRow('🧊 Doubling Cube', 'Centered cube (2, 4, 8, 16, 32, 64) for raising match stakes.'),
        ],
      ),
    );
  }

  /// 4. Yatzy Scorecard Detail
  Widget _buildYatzyDetailView() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFA000), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '📝 Yatzy Score Sheet',
                  style: GoogleFonts.comicNeue(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFE65100),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA000),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '5x Candy Dice',
                  style: GoogleFonts.comicNeue(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'The top section of the back side is a printed Yatzy score sheet with columns for players A, B, C, D and all 18 categories:',
            style: GoogleFonts.comicNeue(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5D4037),
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: [
              'Ones', 'Twos', 'Threes', 'Fours', 'Fives', 'Sixes',
              'Sum', 'Bonus (+50)', '1 Pair', '2 Pairs', '3 of a Kind', '4 of a Kind',
              'Small Straight', 'Large Straight', 'Full House', 'Chance', 'Yatzy (50p)', 'Total Score'
            ].map((cat) => Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFFFFD54F)),
              ),
              child: Text(
                cat,
                style: GoogleFonts.comicNeue(
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE65100),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  /// 5. Trivial Pursuit Compatibility View
  Widget _buildTrivialPursuitCompatibilityView() {
    final categories = [
      ('🔵 Blue', 'Geography', const Color(0xFF1E88E5)),
      ('🟣 Purple', 'Art & Literature', const Color(0xFF8E24AA)),
      ('🟡 Yellow', 'History', const Color(0xFFFBC02D)),
      ('🧪 Green', 'Science & Nature', const Color(0xFF43A047)),
      ('🟠 Orange', 'Sports & Leisure', const Color(0xFFFB8C00)),
      ('🌸 Pink', 'Entertainment', const Color(0xFFE91E63)),
    ];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF1E88E5).withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '🍰 Trivial Pursuit Wedges',
                  style: GoogleFonts.comicNeue(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0D47A1),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '6 Colors • 42 chips',
                  style: GoogleFonts.comicNeue(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'The 42 candy chips in the bag precisely match the 6 category colors of Trivial Pursuit! Players collect one candy piece of each color to win:',
            style: GoogleFonts.comicNeue(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF37474F),
            ),
          ),
          SizedBox(height: 8.h),
          Column(
            children: categories.map((cat) {
              return Container(
                margin: EdgeInsets.only(bottom: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: cat.$3.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: cat.$3.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: cat.$3,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      cat.$1,
                      style: GoogleFonts.comicNeue(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        color: cat.$3,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        cat.$2,
                        style: GoogleFonts.comicNeue(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF263238),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 6. Illustrated Board View
  Widget _buildIllustratedBoardView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          InteractiveViewer(
            minScale: 1.0,
            maxScale: 3.5,
            child: Image.asset(
              kMultifunctionalBoardSketch,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Pinch to zoom & inspect board details',
            textAlign: TextAlign.center,
            style: GoogleFonts.comicNeue(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF6D4C41),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String desc) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.comicNeue(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4E342E),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              desc,
              style: GoogleFonts.comicNeue(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF5D4037),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter that renders the entire double-sided multifunctional board:
/// - Yatzy grid on top
/// - Wooden borders
/// - 24 Backgammon points (alternating Red / Blue)
/// - Backgammon center divider bar with 15x red, 15x white chips, dice & cube
/// - Centered Four in a Row 7x6 circular grid
class _MultifunctionalBoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Wooden Outer Border Frame
    final woodPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8D6E63), Color(0xFF5D4037), Color(0xFF4E342E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), woodPaint);

    // Inner Green Felt Field
    final frameMargin = 12.0;
    final feltRect = Rect.fromLTWH(
      frameMargin,
      frameMargin,
      w - frameMargin * 2,
      h - frameMargin * 2,
    );
    final feltPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF388E3C), Color(0xFF2E7D32), Color(0xFF1B5E20)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(feltRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(feltRect, const Radius.circular(8)),
      feltPaint,
    );

    // 2. Yatzy Score Sheet (Top Section: 0 to h * 0.17)
    final yatzyH = h * 0.17;
    final yatzyRect = Rect.fromLTWH(frameMargin, frameMargin, w - frameMargin * 2, yatzyH);
    final yatzyBg = Paint()..color = const Color(0xFFFFFDE7);
    canvas.drawRect(yatzyRect, yatzyBg);

    // Yatzy Title & Header
    final titleTp = TextPainter(
      text: const TextSpan(
        text: 'YATZY',
        style: TextStyle(
          color: Color(0xFF3E2723),
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    titleTp.paint(canvas, Offset(frameMargin + 8, frameMargin + 4));

    final diceNoteTp = TextPainter(
      text: const TextSpan(
        text: '5x CANDY DICE 🎲',
        style: TextStyle(
          color: Color(0xFFD84315),
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    diceNoteTp.paint(canvas, Offset(w - frameMargin - diceNoteTp.width - 8, frameMargin + 5));

    // Yatzy grid lines
    final gridLinePaint = Paint()
      ..color = const Color(0xFFBCAAA4)
      ..strokeWidth = 0.8;

    final categories = [
      '1s', '2s', '3s', '4s', '5s', '6s',
      'Sum', 'Bon', '1P', '2P', '3K', '4K',
      'S.St', 'L.St', 'Full', 'Chc', 'Yatz', 'Tot'
    ];
    final colWidth = (w - frameMargin * 2 - 36) / categories.length;

    // Draw horizontal dividing line in Yatzy
    canvas.drawLine(
      Offset(frameMargin, frameMargin + 18),
      Offset(w - frameMargin, frameMargin + 18),
      gridLinePaint,
    );
    canvas.drawLine(
      Offset(frameMargin, frameMargin + yatzyH),
      Offset(w - frameMargin, frameMargin + yatzyH),
      Paint()..color = const Color(0xFF5D4037)..strokeWidth = 2.0,
    );

    // Category columns
    for (int i = 0; i < categories.length; i++) {
      final x = frameMargin + 34 + i * colWidth;
      canvas.drawLine(
        Offset(x, frameMargin + 18),
        Offset(x, frameMargin + yatzyH),
        gridLinePaint,
      );

      final catTp = TextPainter(
        text: TextSpan(
          text: categories[i],
          style: const TextStyle(
            color: Color(0xFF4E342E),
            fontSize: 6.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      catTp.paint(canvas, Offset(x + (colWidth - catTp.width) / 2, frameMargin + 20));
    }

    // 3. Backgammon Points (Top half & Bottom half)
    final gameAreaTop = frameMargin + yatzyH;
    final gameAreaH = h - frameMargin - gameAreaTop;
    final midBarY = gameAreaTop + gameAreaH * 0.48;
    final midBarH = 24.0;

    // Upper 12 triangular points (pointing DOWN)
    final pointW = (w - frameMargin * 2 - 14) / 12;
    final pointH = gameAreaH * 0.38;

    for (int i = 0; i < 12; i++) {
      final px = frameMargin + (i >= 6 ? 14 : 0) + i * pointW;
      final isRed = i % 2 == 0;
      final trianglePath = Path()
        ..moveTo(px, gameAreaTop)
        ..lineTo(px + pointW, gameAreaTop)
        ..lineTo(px + pointW / 2, gameAreaTop + pointH)
        ..close();

      final triPaint = Paint()
        ..color = isRed
            ? const Color(0xFFE53935).withValues(alpha: 0.85)
            : const Color(0xFF1E88E5).withValues(alpha: 0.85);
      canvas.drawPath(trianglePath, triPaint);
    }

    // Lower 12 triangular points (pointing UP)
    final bottomY = h - frameMargin;
    for (int i = 0; i < 12; i++) {
      final px = frameMargin + (i >= 6 ? 14 : 0) + i * pointW;
      final isRed = i % 2 != 0;
      final trianglePath = Path()
        ..moveTo(px, bottomY)
        ..lineTo(px + pointW, bottomY)
        ..lineTo(px + pointW / 2, bottomY - pointH)
        ..close();

      final triPaint = Paint()
        ..color = isRed
            ? const Color(0xFFE53935).withValues(alpha: 0.85)
            : const Color(0xFF1E88E5).withValues(alpha: 0.85);
      canvas.drawPath(trianglePath, triPaint);
    }

    // 4. Center Wood Divider Bar ("BACKGAMMON")
    final midBarRect = Rect.fromLTWH(frameMargin, midBarY, w - frameMargin * 2, midBarH);
    final midBarPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF6D4C41), Color(0xFF4E342E), Color(0xFF3E2723)],
      ).createShader(midBarRect);
    canvas.drawRect(midBarRect, midBarPaint);

    final bgTitleTp = TextPainter(
      text: const TextSpan(
        text: 'BACKGAMMON  •  15x 🔴  15x ⚪  DICE 4x 🎲',
        style: TextStyle(
          color: Color(0xFFFFD54F),
          fontSize: 9.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    bgTitleTp.paint(
      canvas,
      Offset(
        frameMargin + (w - frameMargin * 2 - bgTitleTp.width) / 2,
        midBarY + (midBarH - bgTitleTp.height) / 2,
      ),
    );

    // 5. Centered 7x6 Circular Hole Grid for "FOUR IN A ROW"
    final gridCols = 7;
    final gridRows = 6;
    final gridW = (w - frameMargin * 2) * 0.72;
    final cellD = gridW / gridCols;
    final startX = frameMargin + ((w - frameMargin * 2) - gridW) / 2;
    final startY = midBarY + midBarH + 6.0;

    // Draw Four in a Row title banner
    final f4TitleTp = TextPainter(
      text: const TextSpan(
        text: '↑  FOUR IN A ROW (42 candy chips: 21x 🔴  21x ⚪)  ↑',
        style: TextStyle(
          color: Color(0xFFFFF9C4),
          fontSize: 8.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    f4TitleTp.paint(canvas, Offset(startX + (gridW - f4TitleTp.width) / 2, startY + (cellD * gridRows) + 4));

    for (int r = 0; r < gridRows; r++) {
      for (int c = 0; c < gridCols; c++) {
        final cx = startX + c * cellD + cellD / 2;
        final cy = startY + r * cellD + cellD / 2;
        final radius = cellD * 0.40;

        // Hole recessed shadow
        canvas.drawCircle(
          Offset(cx, cy + 1),
          radius,
          Paint()..color = Colors.black.withValues(alpha: 0.4),
        );

        // Hole base
        final isSampleRed = (r == 5 && (c == 2 || c == 4)) || (r == 4 && c == 3);
        final isSampleWhite = (r == 5 && c == 3) || (r == 4 && c == 2);

        if (isSampleRed) {
          canvas.drawCircle(
            Offset(cx, cy),
            radius,
            Paint()..color = const Color(0xFFFF3D00),
          );
          canvas.drawCircle(
            Offset(cx, cy),
            radius,
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.2,
          );
        } else if (isSampleWhite) {
          canvas.drawCircle(
            Offset(cx, cy),
            radius,
            Paint()..color = const Color(0xFFFFF9C4),
          );
          canvas.drawCircle(
            Offset(cx, cy),
            radius,
            Paint()
              ..color = const Color(0xFFBCAAA4)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.2,
          );
        } else {
          canvas.drawCircle(
            Offset(cx, cy),
            radius,
            Paint()
              ..color = const Color(0xFF1B5E20).withValues(alpha: 0.6)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
