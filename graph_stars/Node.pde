public class Node {

  private String name;
  private int x, y;

  private List<Node> shortestPath = new LinkedList<Node>();
  private Integer distance = Integer.MAX_VALUE;

  int diam = 5;

  Map<Node, Integer> adjacentNodes = new HashMap<Node, Integer>();

  public Node(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
  }

  public void addDestination(Node destination) {
    adjacentNodes.put(destination, int(getPointDistance(this, destination)));
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
      names += n.getName() + "->";
    }
    names += name;
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
    if (mouseOver()) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
    } else {
      fill(255);
      stroke(255);
    }
    ellipse(x, y, diam, diam);

    //if (mode != VISUALIZE) {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    textSize(18);
    text(name, x, y);
    //}

    showDestinationLines();
  }

  public boolean mouseOver() {
    float d = sqrt((mouseX - this.x)*(mouseX - this.x) + ((mouseY - this.y)*(mouseY - this.y)));
    return (d < diam);
  }

  public void showDestinationLines() {
    for (Map.Entry < Node, Integer> adjacencyPair : getAdjacentNodes().entrySet()) {
      Node adjacentNode = adjacencyPair.getKey();
      stroke(255);
      fill(255);
      line(getX(), getY(), adjacentNode.getX(), adjacentNode.getY());
    }
  }

  public void move(int dx, int dy) {
    this.x +=dx;
    this.y += dy;
  }

  public void saveNode() {
    processing.data.JSONObject json;
    json = new processing.data.JSONObject();

    json.setString("name", name);
    json.setInt("x", x);
    json.setInt("y", y);

    // adjacent node names
    processing.data.JSONArray adjacentNodes = new processing.data.JSONArray();
    int i = 0;
    for (Map.Entry < Node, Integer> adjacencyPair : getAdjacentNodes().entrySet()) {
      Node adjacentNode = adjacencyPair.getKey();
      adjacentNodes.setString(i++, adjacentNode.getName());
    }
    json.setJSONArray("adjacentNodes", adjacentNodes);
    saveJSONObject(json, "data/" + name + ".json");
  }

  
}