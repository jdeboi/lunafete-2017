public class Node {

  private String name;

  private int x, y;

  private List<Node> shortestPath = new LinkedList<Node>();

  private Integer distance = Integer.MAX_VALUE;

  Map<Node, Integer> adjacentNodes = new HashMap<Node, Integer>();

  //public void addDestination(Node destination, int distance) {
  //adjacentNodes.put(destination, distance);
  //}

  public void addDestination(Node destination) {
    adjacentNodes.put(destination, int(getPointDistance(this, destination)));
  }

  public Node(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
  }

  public void setDistance(int val) {
    distance = val;
  }

  public Integer getDistance() {
    return distance;
  }

  public List<Node> getShortestPath() {
    return shortestPath;
  }

  public String getShortestPathNames() {
    String names = " ";
    Iterator<Node> it = shortestPath.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      names += n.getName() + " ";
    }
    return names;
  }

  public Map<Node, Integer> getAdjacentNodes() {
    return adjacentNodes;
  }

  public String getName() {
    return name;
  }

  public int getX() {
    return this.x;
  }

  public int getY() {
    return this.y;
  }


  public void setShortestPath(List<Node> shortPath) {
    shortestPath = shortPath;
  }

  public void display() {
    fill(255);
    stroke(255);
    ellipse(x, y, 20, 20);
    stroke(0);
    fill(0);
    text(name, x, y);
  }

  public void displayShortestPath() {
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

  public boolean mouseOver() {
    float d = sqrt((mouseX - this.x)*(mouseX - this.x) + ((mouseY - this.y)*(mouseY - this.y)));
    return (d < 5);
  }
}