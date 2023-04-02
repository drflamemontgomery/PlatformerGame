package node;

class Root extends GameObject {
  
  var p_scene : GameScene;

  override function get_scene() : GameScene {
    return p_scene;
  }

  public function new(scene : GameScene) {
    super(null, scene);
    this.p_scene = scene;
  }

}
