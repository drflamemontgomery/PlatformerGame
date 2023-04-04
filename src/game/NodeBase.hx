package;

interface NodeBase {
  public var GRID(get, never) : Int;
  public var scene(get, never) : GameScene;

  public function update(dt : Float) : Void;
  public function physicsUpdate(dt : Float) : Void;
} 
