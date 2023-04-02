package phy.shape;

import phy.PhysicsShape;

class CircleShape extends PhysicsShape {

  public var _circ(default, null) : h2d.col.Circle;

  override function set_x(v) {
    return _circ.x = x = v;
  }
  override function set_y(v) {
    return _circ.y = y = v;
  }

  override function get_type() {
    return Circle;
  }

  public function new(x : Float, y : Float, radius : Float) {
    _circ = new h2d.col.Circle(x, y, radius);

    super();
    this.x = x;
    this.y = y;
  }
}
