public class Node {

  private String name;
  
  private int x, y;

  private List<Node> shortestPath = new LinkedList<Node>();

  private Integer distance = Integer.MAX_VALUE;

  //Map<Node, Integer> adjacentNodes = new HashMap<Node>();
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
}