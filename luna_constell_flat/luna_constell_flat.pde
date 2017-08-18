//import peasy.*;
//PeasyCam cam;

int VERT = 1;
int HORIZ = 2;

//ArrayList<Star> stars;

Star [][][] stars;
Nylon [][] horizontals;
Nylon [][] verticals;
Nylon [][] backs;

int gap = 80;

int xNum = 8;
int yNum = 8;
int zNum = 5;

int mode = 0;
int VISUALIZE = 0;
int SET_POINTS = 1;
int MOVE_POINTS = 2;
int MOVE_LINES = 3;
int SELECT_POINT = 4;
int current_row = 0;
int current_column = 0;
int current_depth = 0;
boolean xDown = false;
boolean yDown = false;
boolean zDown = false;

boolean drawLine = false;

/**
 * Chris Kalani - http://synapsekinect.tumblr.com/
 * oscP5sendreceive by andreas schlegel
 * oscP5 website at http://www.sojamo.de/oscP5
 */
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
Skeleton skeleton;
Boolean tracking = false;
boolean never = true;

void setup() {
  size(600, 600);

  stars = new Star[xNum][yNum][zNum];
  for (int z = 0; z < zNum; z++) {
    for (int y = 0; y < yNum; y++) {
      for (int x = 0; x < xNum; x++) {
        stars[x][y][z] = new Star();
      }
    }
  }

  colorMode(HSB, 255);
  skeleton = new Skeleton();
}

void draw() {
  init();
  if (mode > 0) {
    background(0, 255, 255);
  } else {
    background(0);
  }
  stroke(255);

  for (int z = 0; z < zNum; z++) {
    for (int y = 0; y < yNum; y++) {
      for (int x = 0; x < xNum; x++) {
        stars[x][y][z].display(false);
      }
    }
  }
  
  if (drawLine) drawLines();

  if (mode == SET_POINTS) {
    stroke(255);
    fill(255);
    ellipse(mouseX, mouseY, 10, 10);
  }
  //for (int i = 0; i < segments.size(); i++) {
  //  segments.get(i).display(false);
  //}

  //skeleton.drawSkeleton();
  //skeleton.update();
}

//int getBin(float bodyPoint, int offset) {
//  int bin = int(bodyPoint)-offset;
//  bin /= gap;
//  return bin;
//}

//int getStarNum(float bodyX, float bodyY, float bodyZ) {

//  int x = int(map(bodyX, 70, 450, 0, xNum));
//  if (x < 0) x = 0;
//  else if (x >= xNum) x = xNum - 1;
//  int y = int(map(bodyY, 70, 500, 0, yNum));
//  if (y < 0) y = 0;
//  else if (y >= yNum) y = yNum - 1;
//  int z = int(map(bodyZ, 200, 1000, 0, zNum));
//  if (z < 0) z = 0;
//  else if (z >= zNum) z = zNum - 1;
//  return x + y * yNum + z * xNum * yNum;
//}

int getXStar(float bodyX) {
  int x = int(map(bodyX, 70, 450, 0, xNum));
  if (x < 0) x = 0;
  else if (x >= xNum) x = xNum - 1;
  return x;
}

int getYStar(float bodyY) {
  int y = int(map(bodyY, 70, 500, 0, yNum));
  if (y < 0) y = 0;
  else if (y >= yNum) y = yNum - 1;
  return y;
}

int getZStar(float bodyZ) {
  int z = int(map(bodyZ, 200, 1000, 0, zNum));
  if (z < 0) z = 0;
  else if (z >= zNum) z = zNum - 1;
  return z;
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/tracking_skeleton")) { 
    if (theOscMessage.get(0).intValue()==1) tracking = true;
    else tracking = false;
  } else {
    skeleton.check(theOscMessage);
  }
  return;
}

void init() {
  if (never) {
    // start oscP5, listening for incoming messages from Synapse
    oscP5 = new OscP5(this, 12347);
    // send messages to Synapse on port 12346
    myRemoteLocation = new NetAddress("127.0.0.1", 12346);
    never = false;
  }
}

void mousePressed() {
  if (mode == SET_POINTS) {
    println(current_column + " " + current_row + " " + current_depth);
    stars[current_column][current_row][current_depth].set(mouseX, mouseY);
    segments[current_column][current_row][current_depth].set(mouseX, mouseY);
    current_column++;
    if (current_column == xNum) {
      current_column = 0;
      current_row++;
      if (current_row == yNum) {
        current_row = 0;
        current_depth++;
        if (current_depth == zNum) {
          current_depth = 0;
          mode = VISUALIZE;
        }
      }
    }
  } else if (mode == MOVE_POINTS) {
  } else if (mode == MOVE_LINES) {
  }
}

void keyPressed() {

  if (key == 'o') mode = SET_POINTS;
  else if (key == 'p') mode = MOVE_POINTS;
  else if (key == 'l') mode = MOVE_LINES;
  else if (key == 'e') mode = VISUALIZE;
  else if (key == 's') mode = SELECT_POINT;
  else if (key == 'd') drawLine = !drawLine;

  else if (key == 'x') xDown = true;
  else if (key == 'y') yDown = true;
  else if (key == 'z') zDown = true;


  else if (mode == SELECT_POINT) {
    if (keyCode == UP) {
      current_depth++;
      if (current_depth == zNum) current_depth = zNum -1;
    } else if (keyCode == DOWN) {
      current_depth--;
      if (current_depth < 0) current_depth = 0;
    }
  } else if (mode == SET_POINTS) {
    if (keyCode == UP) {
      stars[current_column][current_row][current_depth].move(0, -1);
    } else if (keyCode == DOWN) {
      stars[current_column][current_row][current_depth].move(0, 1);
    } else if (keyCode == LEFT) {
      stars[current_column][current_row][current_depth].move(-1, 0);
    } else if (keyCode == RIGHT) {
      stars[current_column][current_row][current_depth].move(1, 0);
    }
  }
}

void keyReleased() {
  if (key == 'x') xDown = false;
  else if (key == 'y') yDown = false;
  else if (key == 'z') zDown = false;
}

void drawLines() {
  stroke(255);
  fill(0);
  strokeWeight(2);
  for (int z = 0; z < zNum; z++) {
    for (int y = 0; y < yNum-1; y++) {
      for (int x = 0; x < xNum-1; x++) {
        // horiz
        line(stars[x][y][z].x, stars[x][y][z].y, stars[x+1][y][z].x, stars[x+1][y][z].y); 
        // vert
        line(stars[x][y][z].x, stars[x][y][z].y, stars[x][y+1][z].x, stars[x][y+1][z].y);
        // back
        line(stars[x][y][z].x, stars[x][y][z].y, stars[x][y][z+1].x, stars[x][y][z+1].y);
      }
    }
  }

  
}