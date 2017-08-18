class Nylon {

  PVector points []; 
  int type;

  Nylon(int type) {
    this.type = type;
    initPoints();
  }

  void display(boolean lit) {
    if (lit) {
      strokeWeight(2);
      stroke(255);
      fill(255);
    } else {
      strokeWeight(1);
      stroke(50);
      fill(50);
    }

    for (int i = 0; i < points.length-1; i++) {
      PVector v1 = points[i];
      PVector v2 = points[i];
      line(v1.x, v1.y, v2.x, v2.y);
    }
  }
  
  void initPoints() {
    if (type == HORIZ) {
      points = new PVector[xNum];
    }
    else if (type == VERT) {
      points = new PVector[zNum];
    } 
    for (int i = 0; i < points.length; i++) {
      points[i] = new PVector(0, 0, 0);
    }
  }
}