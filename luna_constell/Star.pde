class Star {

  int x, y, z;
  //boolean lit = false;
  int diam = 5;

  Star(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Star() {
  }
  
  void set(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void move(int dx, int dy) {
    this.x += dx;
    this.y += dy;
  }

  void display(boolean lit) {
    if (lit) {
      fill(255);
      stroke(255);
      diam = 6;
    } else {
      fill(50);
      stroke(50);
      diam = 5;
    }
    pushMatrix();
    translate(x, y);
    sphere(diam);
    popMatrix();
  }
  
}