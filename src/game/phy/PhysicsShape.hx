package phy;

enum PhysicsShapeType {
  None;
  Rect;
  Circle;
}

class PhysicsShape {
  
  public var x(default, set) : Float;
  public var y(default, set) : Float;

  function set_x(v) {
    return x = v;
  }
  function set_y(v) {
    return y = v;
  }

  public var type(get, never) : PhysicsShapeType;

  public var onShapeEnter(default, null) : (PhysicsShape)->Void;
  public var onShapeExit(default, null)  : (PhysicsShape)->Void;

  public var userData : UserData;

  public var collisions : Array<PhysicsShape> = [];

  function get_type() {
    return None;
  }

  public function new() {
    x = 0.0;
    y = 0.0;

    onShapeEnter = function(s:PhysicsShape) {};
    onShapeExit  = function(s:PhysicsShape) {};

    userData = {name : "", data : null};
  }
}
