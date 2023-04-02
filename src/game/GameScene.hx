package;

//import GameObject;
//import World;

class GameScene extends h2d.Scene {

  var physics : phy.PhysicsManager;
  
  // LDTK Level Data
  public var cWid(default, null): Int = 0;
  public var cHei(default, null): Int = 0;

  public var world_data(default, null) : World.World_Level;  
  var tilesetSource : h2d.Tile;
  
  public var marks : dn.MarkerMap<LevelMark>;

  var layers : Array<h2d.Layers>;

  var root : node.Root;

  public function addShapeToLayer(s:phy.PhysicsShape, id:Int) {
    physics.addToLayer(s, id);
  }

  function initLayers() {
    layers = [
      new h2d.Layers(this), // UI
      new h2d.Layers(this), // UI_BG
      new h2d.Layers(this), // FG
      new h2d.Layers(this), // MAIN 
      new h2d.Layers(this), // BG
      new h2d.Layers(this), // SCREEN 
    ];

  }

  function initPhysics() {
    this.physics = new phy.PhysicsManager(this);
  }

  function initRoot() {
    this.root = new node.Root(this);
  }

  function initLevel() {
    createLevel(Assets.worldData.all_levels.Level_0);
  }

  function createLevel(ldtkLevel:World.World_Level) {
    world_data = ldtkLevel;
    cWid = world_data.l_Collisions.cWid;
    trace(cWid);
    cHei = world_data.l_Collisions.cHei;
    //tilesetSource = hxd.Res.levels.testTiles.toTile();
    tilesetSource = hxd.Res.levels.testTiles.toTile();

    marks = new dn.MarkerMap(cWid, cHei);
    for(cy in 0...cHei)
    for(cx in 0...cWid) {
      if(world_data.l_Collisions.getInt(cx, cy) == 1)
        marks.set(Coll_Wall, cx,cy);
    }
    
    var tg = new h2d.TileGroup(tilesetSource, this);

    var layer = world_data.l_Collisions;
    for(autoTile in layer.autoTiles) {
      var tile = layer.tileset.getAutoLayerTile(autoTile);
      tg.add(autoTile.renderX, autoTile.renderY, tile);
    } 
  }

  public function isValid(cx,cy) : Bool {
    return cx>=0 && cx<cWid && cy>=0 && cy<cHei;
  }

  public function hasCollision(cx,cy) : Bool {
    return !isValid(cx,cy) ? false : marks.has(Coll_Wall, cx,cy);
  }

  public function new() {
    super();
    initLayers();
    initLevel();
    initPhysics();
    initRoot();
  }


  public function update( dt : Float ) {
    // Physics Stepping
    root.physicsUpdate(dt);
    physics.update(); 

    // Idle/Process
    root.update(dt);
  }
}

enum abstract LayerName(Int) to Int {
  var UI = 0;
  var UI_BG = 1;
  var FG = 2;
  var MAIN = 3;
  var BG = 4;
  var SCREEN = 5;
}
