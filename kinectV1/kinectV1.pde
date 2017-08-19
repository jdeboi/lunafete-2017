/**
 * Chris Kalani - http://synapsekinect.tumblr.com/
 *
 *
 * oscP5sendreceive by andreas schlegel
 * oscP5 website at http://www.sojamo.de/oscP5
 */

//import org.openkinect.freenect.*;
//import org.openkinect.processing.*;

//Kinect kinect;
//  float deg;
//  boolean ir = false;
//  boolean colorDepth = false;


import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

PImage bg;
Skeleton skeleton;
boolean never = true;


Boolean tracking = false;

//// Which pixels do we care about?
//int minDepth =  860;
//int maxDepth = 960;
//// Depth image
//PImage depthImg;

//Button [] buttons;

void setup() {
  fullScreen();
  frameRate(25);
  bg = loadImage("galaxy.jpg");

  skeleton = new Skeleton();

  //kinect = new Kinect(this);
  //kinect.initDepth();
  //kinect.initVideo();
  //kinect.enableIR(ir);
  //kinect.enableColorDepth(colorDepth);

  //deg = kinect.getTilt();
  //// kinect.tilt(deg);
  //kinect.enableMirror(true);

  //initButtons();
}


void draw() {
  if (never) {
    // start oscP5, listening for incoming messages from Synapse
    // 12347
    println("bout to start");
    oscP5 = new OscP5(this, 12347);
    println("blame oscp5?");
    // send messages to Synapse on port 12346
    myRemoteLocation = new NetAddress("127.0.0.1", 12346); //12346
    println("myremote");
    never = false;
  }

  if(tracking) {
    background(0);  
  }
  else {
    //image(bg, 0, 0, width, height);
    background(0);
  }
  skeleton.drawSkeleton();
  skeleton.update();

  //for(int i = 0; i < buttons.length; i++) {
  //  buttons[i].drawButton();
  //}
  //checkButtons();
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


//void drawSkin() {
//  // Threshold the depth image
//    PImage colorKinect = kinect.getVideoImage(); 
//    int[] rawDepth = kinect.getRawDepth();
//    for (int i=0; i < rawDepth.length; i++) {
//      if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
//        depthImg.pixels[i] = colorKinect.pixels[i];
//      } else {
//        depthImg.pixels[i] = color(0);
//      }
//    }
//    image(depthImg, 0, 0);
//    // Draw the thresholded image
//    depthImg.updatePixels();
//}

// This allows you to cut the background out of the 
// depth image and only see the user.  Valid values to pass are: 
// 0 to see the whole depth buffer, 1 to see only the tracked 
// user (or all person-shaped things if no one is tracked), 
// 2 to see all person-shaped things even if a user is tracked.
//void setDepthMode(int mode) {
//  String message = "/depth_mode";
//  OscMessage myMessage = new OscMessage(message);
//  if(mode >= 0 && mode <= 2) {
//    myMessage.add(mode); 
//    oscP5.send(myMessage, myRemoteLocation); 
//  }
//  else println("mode must be 0, 1, or 2");
//}

//void initButtons() {
//  buttons = new Button[10];
//  for(int i = 0; i < buttons.length; i++) {
//    buttons[i] = new Button(100, i*50+20, 30, 30);
//  }
//}

//void checkButtons() {
//  for(int i = 0; i < buttons.length; i++) {
//    if(buttons[i].isPressed(int(skeleton.getRightHandX()), int(skeleton.getRightHandY())) ||
//      buttons[i].isPressed(int(skeleton.getLeftHandX()), int(skeleton.getLeftHandY()))) {
//        println("button pressed");
//    }
//  }
//}