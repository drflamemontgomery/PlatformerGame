package en;

enum PlayerState {
  Idle;
  Run;
  Hit;
  Fall;
  Jump;
  Wall_Jump;
  Double_Jump;
}

class PlayerSprite extends node.Sprite {

  var run  : h2d.Tile;
  var idle : h2d.Tile;
  var hit  : h2d.Tile;
  var fall : h2d.Tile;
  var jump : h2d.Tile;
  var wall_jump   : h2d.Tile;
  var double_jump : h2d.Tile;

  var cur_texture : h2d.Tile;
  var state : PlayerState;

  public function new( ?parent : node.Node ) {
    super(parent);

    run = hxd.Res.en.ninja_frog.run.toTile();
    idle = hxd.Res.en.ninja_frog.idle.toTile();
    hit = hxd.Res.en.ninja_frog.hit.toTile();
    fall = hxd.Res.en.ninja_frog.fall.toTile();
    jump = hxd.Res.en.ninja_frog.jump.toTile();
    wall_jump = hxd.Res.en.ninja_frog.wall_jump.toTile();
    double_jump = hxd.Res.en.ninja_frog.double_jump.toTile();

    tex = idle.sub(0, 0, 32, 32);
    cur_texture = idle;

    state = Run;
  }

  public function setState( state : PlayerState ) {
    this.state = state;
    switch(state) {
      case Idle:
        cur_texture = idle;
      case Run:
        cur_texture = run;
      case Hit:
        cur_texture = hit;
      case Fall:
        cur_texture = fall;
      case Jump:
        cur_texture = jump;
      case Wall_Jump:
        cur_texture = wall_jump;
      case Double_Jump:
        cur_texture = double_jump;
    }
  }

  var frame : Int = 0;
  var cur_time : Float = 0;

  function getFrameLength() {
    switch(state) {
      case Run:
        return 12;
      case Idle:
        return 11;
      case Hit:
        return 7;
      case Fall:
        return 1;
      case Jump:
        return 1;
      case Wall_Jump:
        return 4;
      case Double_Jump:
        return 6;
    }
  }

  function updateImage(dt:Float) {
    cur_time += dt;
    if(cur_time < 0.05) { return; }
    cur_time -= 0.05;
    frame++;
    frame %= getFrameLength();

    tex = cur_texture.sub(32*frame, 0, 32, 32);
    tex.setCenterRatio(0.5, 1.0);
  }

  function getPlayer() : Player {
    return cast(parent, Player);
  }
  
  override function update(dt:Float) {
    super.update(dt);
    updateImage(dt);
    final player = getPlayer();
  
    if(player.dx > 0.0 && scaleX < 1.0) {
      scaleX = 1.0;
    }
    else if(player.dx < 0.0 && scaleX > -1.0) {
      scaleX = -1.0;
    }

  }

}

class Player extends node.CharacterBody {

  var stateHandler : PlayerStateHandler;
  public var sprite : PlayerSprite;

  public function new(?parent : node.Node, x:Int, y:Int) {
    super(parent, x, y);
    
    //debugDraw = true;
    setPixelSize(16, 21);
    
    sprite = new PlayerSprite(this);

    setPixelCenterRatio(8, 17);

    stateHandler = new PlayerStateHandler(this);
  }

  override function update( dt : Float ) {
    super.update(dt);
    stateHandler.update(dt);
    if( hxd.Key.isPressed(hxd.Key.UP)) {
      dy = -6;
    }
    dy += dt * 20;
  }
}

class PlayerStateHandler {
  public var state  : PlayerState;
  public var states : Map<PlayerState, State>;

  public var player(default, null) : Player;
    
  public function new(player:Player) {
    this.player = player;
    
    this.state = Idle;
    this.states = [
      Idle => new IdleState(this),
      Run => new RunState(this),
      Hit => new HitState(this),
      Fall => new FallState(this),
      Jump => new JumpState(this),
      Wall_Jump => new WallJumpState(this),
      Double_Jump => new DoubleJumpState(this),
    ];

    this.states[this.state].enter();
  }

  public function update(dt:Float) {
    switch(states[state].update(dt)) {
      case null:
        // Do nothing
      case s:
        states[state].exit();
        states[s].enter();
        state = s;
        // Do something
    }
  }
}

class IdleState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }

  override function enter() {
    player.sprite.setState(Idle);
  }

  override function update(dt:Float) : Null<PlayerState> {
    var dir = 0;
    if(hxd.Key.isDown(hxd.Key.LEFT)) {
      dir -= 1;
    }
    if(hxd.Key.isDown(hxd.Key.RIGHT)) {
      dir += 1;
    }

    if(dir != 0) { return Run; }
    return null;
  }
}
  
class RunState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }

  override function enter() {
    player.sprite.setState(Run);
  }

  override function update(dt:Float) : Null<PlayerState> {
    player.dx = 0;
    if(hxd.Key.isDown(hxd.Key.LEFT)) {
      player.dx -= 10;
    }
    if(hxd.Key.isDown(hxd.Key.RIGHT)) {
      player.dx += 10;
    }

    if(player.dx == 0) { return Idle; }
    
    return null;
  }
}
  
class HitState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }
}
  
class FallState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }
}
  
class JumpState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }
}
  
class WallJumpState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }
}
  
class DoubleJumpState extends State {
  public function new(?handler : PlayerStateHandler) {
    super(handler);
  }
}
  
class State {
  public var player(get, never) : Player;
  public var handler : PlayerStateHandler;

  inline function get_player() {
    return handler.player;
  }

  public function new(handler : PlayerStateHandler) {
    this.handler = handler;
  }

  public function enter() {
  }

  public function exit() {
  }

  public function update(dt:Float) : Null<PlayerState> {
    return null;
  }
}
