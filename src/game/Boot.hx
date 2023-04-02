package;

class Boot extends hxd.App {
  
  var cur_scene : GameScene;

  static function main() {
    new Boot();
    hxd.Res.initLocal();
    Assets.init();
  }

  function new() {
    super();

    trace(hxd.Window.getInstance().vsync);
  }

  override function init() {
    cur_scene = new scenes.TestScene();
    setScene(cur_scene);
  }

  override function update(dt : Float) {
    cur_scene.update(dt);
  }
}
