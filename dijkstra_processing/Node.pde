class Node {

  String name;
  int x, y;
  List<Node> shortestPath = new LinkedList<Node>();
  Integer distance = Integer.MAX_VALUE;
  Map<Node, Integer> adjacentNodes = new HashMap<Node, Integer>();

 
  Node(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
  }
  
  void addDestination(Node destination) {
    adjacentNodes.put(destination, int(getPointDistance(this, destination)));
  }

  void setDistance(int val) {
    distance = val;
  }

  Integer getDistance() {
    return distance;
  }

  List<Node> getShortestPath() {
    return shortestPath;
  }

  String getShortestPathNames() {
    String names = " ";
    Iterator<Node> it = shortestPath.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      names += n.getName() + " ";
    }
    return names;
  }

  Map<Node, Integer> getAdjacentNodes() {
    return adjacentNodes;
  }

  String getName() {
    return name;
  }

  int getX() {
    return this.x;
  }

  int getY() {
    return this.y;
  }


  void setShortestPath(List<Node> shortPath) {
    shortestPath = shortPath;
  }

  void display() {
    fill(255);
    stroke(255);
    ellipse(x, y, 20, 20);
    stroke(0);
    fill(0);
    text(name, x, y);
  }

  void displayShortestPath() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    Iterator<Node> it = shortestPath.iterator();
    Node lastNode = shortestPath.get(0);
    while (it.hasNext()) {
      Node n = it.next();
      line(lastNode.getX(), lastNode.getY(), n.getX(), n.getY());
      ellipse(n.getX(), n.getY(), 20, 20);
      lastNode = n;
    }
    line(getX(), getY(), lastNode.getX(), lastNode.getY());
    ellipse(x, y, 20, 20);
  }

  boolean mouseOver() {
    float d = sqrt((mouseX - this.x)*(mouseX - this.x) + ((mouseY - this.y)*(mouseY - this.y)));
    return (d < 5);
  }
}