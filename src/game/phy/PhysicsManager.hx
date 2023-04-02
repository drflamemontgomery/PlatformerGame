package phy;

class PhysicsManager {
  
  var layers : Map<Int, PhysicsLayer>;
  var parent : h2d.Object;

  public function new(?parent : h2d.Object) {
    layers = [];
    if(parent != null) {
      this.parent = parent;
    }
  }

  public function addToLayer(s : PhysicsShape, layer_id : Int) {
    if(!layers.exists(layer_id)) {
      layers.set(layer_id, new PhysicsLayer(parent));
    }
    layers.get(layer_id).addBody(s);
  }

  public function update() {
    for(layer in layers) {
      layer.update();
    }
  }
}
