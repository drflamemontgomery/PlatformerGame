package en;

class TestObj extends node.Node {

  var spr : node.Sprite;

  public function new( ?parent : node.Node ) {
    super(parent);

    var t = h2d.Tile.fromColor(0xFF0000, 32, 64, 1.);
    t.setCenterRatio(0.5, 1.0);
    spr = new node.Sprite(this);
    spr.setTile(t);
    spr.scaleX = 0.5;
    spr.scaleY = 1.5;
    spr.y = 32;

    this.x = 100;
    this.y = 100;
    this.rotation = 0.79;
  }
  
  var t : Float = 0.0;

  override function update( dt : Float ) {
    t += dt*5;
    spr.scaleX = Math.sin(t)*0.25 + 0.75; 
    spr.scaleY = 1.25 - Math.sin(t)*0.25;
    this.rotation += dt;
  }
}
