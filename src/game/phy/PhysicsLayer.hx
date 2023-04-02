package phy;

import phy.shape.*;

/**
  * Abstract Class for Physics Layers
  */
class PhysicsLayer {
 
  var bodies : Array<PhysicsShape>; 

  public function new(?parent : h2d.Object) {
    bodies = [];
  }

  function testRects(r0 : RectShape, r1 : RectShape) {
    if(r0._rect.intersects(r1._rect)) {
      if(r0.collisions.contains(r1)) return;
      r0.collisions.push(r1);
      r1.collisions.push(r0);

      r0.onShapeEnter(r1);
      r1.onShapeEnter(r0);
      return;
    }
    if(!r0.collisions.contains(r1)) return;
    r0.collisions.remove(r1);
    r1.collisions.remove(r0);

    r0.onShapeExit(r1);
    r1.onShapeExit(r0);
  }

  function testCircles(c0 : CircleShape, c1 : CircleShape) {
    if(c0._circ.collideCircle(c1._circ)) {
      if(c0.collisions.contains(c1)) return;
      c0.collisions.push(c1);
      c1.collisions.push(c0);

      c0.onShapeEnter(c1);
      c1.onShapeEnter(c0);
      return;
    }
    if(!c0.collisions.contains(c1)) return;
    c0.collisions.remove(c1);
    c1.collisions.remove(c0);

    c0.onShapeExit(c1);
    c1.onShapeExit(c0);
    
  }

  function testRectCircle(r0 : RectShape, c1 : CircleShape) {
    if(c1._circ.collideBounds(r0._rect)) {
      if(r0.collisions.contains(c1)) return;
      r0.collisions.push(c1);
      c1.collisions.push(r0);

      r0.onShapeEnter(c1);
      c1.onShapeEnter(r0);
      return;
    }
    if(!r0.collisions.contains(c1)) return;
    r0.collisions.remove(c1);
    c1.collisions.remove(r0);

    r0.onShapeExit(c1);
    c1.onShapeExit(r0);

  }

  public function update() {
    for(b in 0...bodies.length) {
      for(o in (b+1)...bodies.length) {
        final body  : PhysicsShape = bodies[b];
        final other : PhysicsShape = bodies[o];

        switch(body.type) {
          case None:
          case Rect:
            switch(other.type) {
              case None:
              case Rect:
                testRects(cast(body, RectShape), cast(other, RectShape));
              case Circle:
                testRectCircle(cast(body, RectShape), cast(other, CircleShape));
            }
          case Circle:
            switch(other.type) {
              case None:
              case Rect:
                testRectCircle(cast(other, RectShape), cast(body, CircleShape));
              case Circle:
                testCircles(cast(body, CircleShape), cast(other, CircleShape));
            }
        }
      }
    }
  }

  public function addBody(body : PhysicsShape) {
    bodies.push(body);
  }

  public function removeBody(body : PhysicsShape) {
    bodies.remove(body);
  }
}
