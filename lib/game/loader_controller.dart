import 'package:flappy_dash_ce/core/asset_manager.dart';
import 'package:flappy_dash_ce/core/base_game_loop.dart';
import 'package:flappy_dash_ce/game/loader.dart';

class LoaderController extends BaseGameLoop {
  late AssetManager assetManager;
  late Loader loader;
  double progress = 0;

  LoaderController() {
    loader = Loader();
    assetManager = AssetManager();
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
