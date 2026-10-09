import 'package:audioplayers/audioplayers.dart';
import '../constants/app_images.dart';

class AudioService {
  static final AudioService instance = AudioService._internal();
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playDiceRoll() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(kDiceRollSound), volume: 1.0);
    } catch (_) {
      // Audio fallback for testing or non-audio devices
    }
  }

  void dispose() {
    _player.dispose();
  }
}
