package scenes;

class TestScene extends GameScene {
  
  override function get_GRID() {
    return 16;
  }

  public function new() {
    super();
    new en.Player(root, 1, 1);

    this.scaleX = 2.0;
    this.scaleY = 2.0;
  }

  override function update(dt : Float) {
    super.update(dt);
  }
}
