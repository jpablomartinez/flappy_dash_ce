import 'dart:ui';

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

  int loadedAssets = 0;
  int totalAssets = 0;

  Future<void> loadSprites() async {
    final assetsToLoad = <String, void Function(Image)>{
      'assets/sprites/basic_pipe.png': (img) => upperPipe = img,
      'assets/sprites/lower_pipe.png': (img) => lowerPipe = img,
      'assets/sprites/base.png': (img) => floor = img,
      'assets/sprites/dash/birdie.png': (img) => dashSprite = img,
    };
    totalAssets += assetsToLoad.length;
    for (final entry in assetsToLoad.entries) {
      final image = await loadSprite(entry.key);
      entry.value(image);
      loadedAssets++;
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  Future<void> loadAudios() async {}

  Future<void> loadAssets() async {
    await loadSprites();
    await loadAudios();
  }

  double getLoadedAssetsPercentage() {
    if (totalAssets == 0) return 0;
    return ((loadedAssets / totalAssets) * 100);
  }
}
