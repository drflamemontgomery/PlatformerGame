package node;

class Sprite extends GameObject {
 
  var tex : h2d.Tile;

  public function new( ?parent : GameObject ) {
    super(parent);
  }

  public function setTile(t : h2d.Tile, dispose : Bool = true) {
    if( dispose && tex != null ) tex.dispose();
    tex = t;
  }

  override function draw( ctx : h2d.RenderContext ) {
    emitTile(ctx, tex);
  }

}
