package node;

class CharacterBody extends GameObject {

  public var debugDraw(default, set) : Bool = false;
  var debugBounds : h2d.Tile;

  inline function set_debugDraw(v) {
    return debugDraw = v;
  }

 
  // How many cells the collision uses in the grid 

  // Velocity
  var dx : Float = 0.0;
  var dy : Float = 0.0;

  // Grid Coordinate
  var cx : Int;
  var cy : Int;

  // Sub Grid Coordinate
  var xr : Float = 0.0;
  var yr : Float = 0.0;

  var w : Float = 1.0;
  var h : Float = 1.0;

  public function new( ?parent : GameObject, x : Int = 3, y : Int = 3 ) {
    super(parent);
    cx = x;
    cy = y;
    debugBounds = h2d.Tile.fromColor(0xFF0000, Std.int(w*GRID), Std.int(h*GRID), 0.5);
    debugBounds.setCenterRatio(0.5, 0.5);
  }

  function setSize(w : Float, h : Float) {
    this.w = w;
    this.h = h;
    debugBounds.scaleToSize(w*GRID, h*GRID);
    debugBounds.setCenterRatio(0.5, 0.5);
  }

  function setPixelSize(w : Int, h : Int) {
    setSize(w/GRID, h/GRID);
  }
  
  function onPreStepX() {
    final pps = Math.ceil(h);
    final body_cell : Array<Int> = [
      Math.floor(cy + yr - h/2 + 0.001),
    ].concat([
      for(i in 1...pps) Math.floor(cy + yr - h/2 + h/pps*i)
    ]).concat([
      Math.floor(cy + yr + h/2 - 0.001),
    ]);

    final r_penetration : Float = ((cx + xr) + w/2)%1.0;
    final l_penetration : Float = ((cx + xr) - w/2)%1.0;
    final r_cx = Math.floor((cx + xr) + w/2);
    final l_cx = Math.floor((cx + xr) - w/2);


    for(body in body_cell) {
      if(dx > 0 && scene.hasCollision(r_cx, body)) {
        xr -= r_penetration;
      }

      if(dx < 0 && scene.hasCollision(l_cx, body)) {
        xr += 1.0 - l_penetration;
      }
      /*if(dx < 0 && xr < (w/2) && scene.hasCollision(cx-1, body)) {
        xr = w/2;
      }*/
    }
  }

  var isOnFloor : Bool = false;

  function onPreStepY() {
    final pps = Math.ceil(w);
    final feet_cell : Array<Int> = [
      Math.floor(cx + xr - w/2 + 0.001)
    ].concat([
        for(i in 1...pps) Math.floor(cx + xr - w/2 + w/pps*i)
    ]).concat([
      Math.floor(cx + xr + w/2 - 0.001),
    ]);

    final d_penetration : Float = ((cy + yr) + h/2)%1.0;
    final u_penetration : Float = ((cy + yr) - h/2)%1.0;
    final d_cy = Math.floor((cy + yr) + h/2);
    final u_cy = Math.floor((cy + yr) - h/2);

    for(foot in feet_cell) {
      if(dy > 0 && scene.hasCollision(foot, d_cy)) {
        yr -= d_penetration;
        dy = 0.0;
        isOnFloor = true;
      }

      if(dy < 0 && scene.hasCollision(foot, u_cy)) {
        yr += 1.0 - u_penetration;
      }
    }
  }

  override function physicsUpdate(dt : Float) {
    var steps = Math.ceil((Math.abs(dx) + Math.abs(dy)) / 0.33);

    if(steps > 0) {
      for(i in 0...steps) {
        xr += dx/steps*dt;

        if(dx != 0) {
          onPreStepX();
        }
        while(xr>1) { xr--; cx++;}
        while(xr<0) { xr++; cx--;}

        
        yr += dy/steps*dt;

        if(dy != 0) {
          onPreStepY();
        }
        while(yr>1) { yr--; cy++;}
        while(yr<0) { yr++; cy--;}

      }
    }
  } 

  override function update(dt : Float) {
    this.x = (cx + xr)*GRID;
    this.y = (cy + yr)*GRID;
  }

  override function draw( ctx : h2d.RenderContext ) {
    if(debugDraw) {
      emitTile(ctx, debugBounds);
    }
  }
}

