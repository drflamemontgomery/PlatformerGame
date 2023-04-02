package;

class GameObject extends h2d.Object {

  public var g_parent(default, null) : Null<GameObject>;
  public var scene(get, null) : GameScene;
  public var GRID(get, never) : Int;
  inline function get_GRID() {
    return 32;
  }

  var g_children : Array<GameObject> = [];
  public var g_numChildren(get, never) : Int;

  function get_g_numChildren() {
    return g_children.length;
  }
  
  function get_scene() : GameScene {
    if(g_parent == null) {
      throw "Root Node is not of type 'Root'";
    }
    return g_parent.get_scene();
  }

  public function new(?g_parent : GameObject, ?parent : h2d.Object) {
    if( g_parent != null ) {
      g_parent.g_addChild(this);
      super();
    }else {
      super(parent);
    }

  }

  public function g_addChild( s : GameObject ) {
    g_addChildAt(s, g_children.length);
  }

  public function g_addChildAt( s : GameObject, pos : Int ) {
    addChildAt(s, pos);
    if( pos < 0 ) pos = 0;
    if( pos > g_children.length ) pos = g_children.length;
    var p = this;

    while( p != null ) {
      if( p == s ) throw "Recursive g_addChild";
      p = p.g_parent;
    }
    if( s.g_parent != null ) {
      // prevent calling onRemove
      var old = s.allocated; 
      s.allocated = false;
      s.g_parent.g_removeChild(s);
      s.allocated = old;
    }
    g_children.insert(pos, s);

    s.g_parent = this;
  }

  public function g_removeChild( s : GameObject ) {
    g_children.remove( s );
  }

  public function update(dt : Float) {
    for(c in g_children) {
      c.update(dt);
    }
  }

  public function physicsUpdate(dt : Float) {
    for(c in g_children) {
      c.physicsUpdate(dt);
    }
  }

  override function draw( ctx : h2d.RenderContext ) {
    super.draw(ctx);
    for(c in g_children) {
      c.draw(ctx);
    }
  }
}
