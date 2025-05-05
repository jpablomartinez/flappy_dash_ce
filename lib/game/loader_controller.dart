import 'package:flappy_dash_ce/engine/utils/asset_manager.dart';
import 'package:flappy_dash_ce/engine/audio/audio.dart';
import 'package:flappy_dash_ce/engine/core/base_game_loop.dart';
import 'package:flappy_dash_ce/game/loader.dart';

class LoaderController extends BaseGameLoop {
  late AssetManager assetManager;
  //late AudioSettings audioSettings;
  late Loader loader;
  double progress = 0;

  LoaderController() {
    loader = Loader();
    assetManager = AssetManager();
    assetManager.setAudioSettings(AudioSettings());
  }

  void loadAssets() {
    assetManager.loadAssets();
  }

  @override
  void update(double dt) {
    progress = assetManager.getLoadedAssetsPercentage();
    loader.setProgress(progress);
    loader.update(dt);
  }
}
