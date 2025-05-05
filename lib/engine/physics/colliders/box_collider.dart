import 'package:flappy_dash_ce/engine/physics/colliders/collider.dart';
import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/game/floor.dart';

class BoxCollider {
  static bool isColliding(GameObject a, Collider b) {
    if (b.runtimeType == Floor) {
      //a.right < b.right check
      //a.right > b.left check
      //a.top < b.bottom check
      //a.bottom > b.top invalid (give tolerance, works on ios emulator)
      return a.collider.bottom >= b.collider.top - 15 && a.collider.left < b.collider.right && a.collider.right > b.collider.left;
    }
    return a.collider.overlaps(b.collider);
  }

  static List<GameObject> getCollision(GameObject target, List<GameObject> others) {
    return others.where((obj) => obj != target && isColliding(target, obj)).toList();
  }
}
