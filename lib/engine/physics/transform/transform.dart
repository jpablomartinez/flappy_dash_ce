import 'package:flappy_dash_ce/engine/physics/transform/rotation.dart';
import 'package:flappy_dash_ce/engine/physics/transform/scale.dart';
import 'package:flappy_dash_ce/engine/physics/transform/vector2.dart';

class Transform {
  late Vector2 position;
  late Rotation rotation;
  late Scale scale;

  Transform(this.position, this.rotation, this.scale);

  Transform.create() {
    position = Vector2.zero();
    rotation = Rotation(0, 0, 0);
    scale = Scale(0, 0, 0);
  }
}
