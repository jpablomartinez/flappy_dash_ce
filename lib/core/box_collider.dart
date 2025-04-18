import 'package:flappy_dash_ce/core/collider.dart';
import 'package:flappy_dash_ce/core/game_object.dart';

class BoxCollider {
  static bool isColliding(Collider a, Collider b) {
    return a.collider.overlaps(b.collider);
  }

  static List<GameObject> getCollision(GameObject target, List<GameObject> others) {
    return others.where((obj) => obj != target && isColliding(target, obj)).toList();
  }
}
