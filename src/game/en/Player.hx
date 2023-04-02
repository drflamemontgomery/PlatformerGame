package en;

class Player extends node.CharacterBody {
 
  public function new(?parent : GameObject, x:Int, y:Int) {
    super(parent, x, y);
    
    debugDraw = true;
    setPixelSize(24, 30);

  }

  override function update( dt : Float ) {
    super.update(dt);
    dx = 0;
    if(hxd.Key.isDown(hxd.Key.LEFT)) {
      dx -= 10;
    }
    if(hxd.Key.isDown(hxd.Key.RIGHT)) {
      dx += 10;
    }
    if( hxd.Key.isPressed(hxd.Key.UP)) {
      dy = -6;
    }
    dy += dt * 20;
  }
}
