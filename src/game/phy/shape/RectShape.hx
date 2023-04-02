package phy.shape;

import phy.PhysicsShape;

class RectShape extends PhysicsShape {

  public var _rect(default, null) : h2d.col.Bounds;

  override function set_x(v:Float) {
    _rect.x = v - _rect.width/2;
    return x = v;
  }
  override function set_y(v:Float) {
    _rect.y = v - _rect.height/2;
    return y = v;
  }

  override function get_type() {
    return Rect;
  }

  public function new(x : Float, y : Float, hx : Float, hy : Float) {
    _rect = new h2d.col.Bounds();
    _rect.xMin = x-hx;
    _rect.yMin = y-hy;
    _rect.xMax = x+hx;
    _rect.yMax = y+hy;

    super();
    this.x = x;
    this.y = y;
  }
}
