package scenes;

class TestScene extends GameScene {

  public function new() {
    super();
    new en.TestObj(root);
    new en.Player(root, 1, 1);
  }

  override function update(dt : Float) {
    super.update(dt);
  }
}
