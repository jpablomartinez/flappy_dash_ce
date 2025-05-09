import 'dart:ui';

import 'package:flappy_dash_ce/configuration/game_config.dart';
import 'package:flappy_dash_ce/engine/audio/audio.dart';
import 'package:flappy_dash_ce/utils/sprite.dart';

class AssetManager {
  /*Singleton definition */
  static final AssetManager _instance = AssetManager._internal();
  factory AssetManager() => _instance;
  AssetManager._internal();

  late Image dashSprite;
  late Image upperPipe;
  late Image lowerPipe;
  late Image floor;
  late AudioSettings audioSettings;

  final GameConfig gameConfig = GameConfig();

  int loadedAssets = 0;
  int totalAssets = 0;

  void setAudioSettings(AudioSettings a) {
    audioSettings = a;
  }

  Future<void> loadSprites(Map<String, void Function(Image)> sprites) async {
    for (final asset in sprites.entries) {
      final image = await loadSprite(asset.key);
      asset.value(image);
      loadedAssets++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> loadAudios(List<String> audios) async {
    for (final audio in audios) {
      await audioSettings.preload(audio);
      loadedAssets++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> loadConfiguration() async {
    await gameConfig.load('assets/configuration/game_config.json');
    return;
  }

  Future<void> loadAssets() async {
    final List<String> bgAudiosPath = [
      'sounds/bg-song1.mp3',
      'sounds/bg-song2.mp3',
      'sounds/bg-song3.mp3',
      'sounds/gameover.mp3',
    ];
    final assetsToLoad = <String, void Function(Image)>{
      'assets/sprites/basic_pipe.png': (img) => upperPipe = img,
      'assets/sprites/lower_pipe.png': (img) => lowerPipe = img,
      'assets/sprites/base.png': (img) => floor = img,
      'assets/sprites/dash/birdie.png': (img) => dashSprite = img,
    };
    totalAssets += assetsToLoad.length + bgAudiosPath.length;
    await loadConfiguration();
    await loadSprites(assetsToLoad);
    await loadAudios(bgAudiosPath);
  }

  double getLoadedAssetsPercentage() {
    if (totalAssets == 0) return 0;
    return ((loadedAssets / totalAssets) * 100);
  }
}
