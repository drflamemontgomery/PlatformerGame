package;

class Assets {
  public static var worldData : World;

  static var _initDone = false;
  public static function init() {
    if(_initDone) return;
    _initDone = true;

    worldData = new World();
  }
}
