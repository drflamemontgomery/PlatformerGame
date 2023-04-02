package node;

import phy.shape.CircleShape;

class CircleCollider extends GameObject {
  
  public var collider : RectShape;

  public function new(x : Float, y : Float, hx : Float, hy : Float, ?parent : GameObject) {
    super(parent);

    collider = new RectShape(x, y, hx, hy);
  } 

  public override function physicsUpdate(dt : Float) {
    var p = localToGlobal();
    collider.x = p.x/GRID;
    collider.y = p.y/GRID;
  }
}
