package node;

class Node extends h2d.Object implements NodeBase {
  
  public var GRID(get, never) : Int;
  function get_GRID() : Int {
    return scene.GRID;
  }

  public var scene(get, never) : GameScene;
  function get_scene() : GameScene {
    if(parent != null && Std.isOfType(parent, NodeBase)) {

      return cast(parent, NodeBase).get_scene();
    } else if(parent != null && Std.isOfType(parent, GameScene)) {
      return cast(parent, GameScene); 
    }
    throw "Node is not attached to a GameScene";
  }

  public function new(?parent : h2d.Object) {
    super(parent);
  } 


  public function update(dt : Float)  {
    for(child in children) {
      if(Std.isOfType(child, Node)) {
        var node : Node = cast(child, Node);
        node.update(dt);
      }
    }
  }
  public function physicsUpdate(dt : Float)  {
    for(child in children) {
      if(Std.isOfType(child, Node)) {
        var node : Node = cast(child, Node);
        node.physicsUpdate(dt);
      }
    }
  }

}
