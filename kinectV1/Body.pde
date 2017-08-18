
class Body {
  
  Skeleton skeleton;
  
  Body() {
    skeleton = new Skeleton();
   
  }
  
  void drawBody() {
    skeleton.drawSkeleton();
    
    
    
  }
  
  void update() {
    skeleton.update();
  }
  
  void check(OscMessage theOscMessage) {
    skeleton.check(theOscMessage);
  }
  
}