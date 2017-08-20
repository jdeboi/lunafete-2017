public class Graph {

  private Set<Node> nodes = new HashSet<Node>();

  private Node stem, endBone;

  public void addNode(Node nodeA) {
    nodes.add(nodeA);
  }

  public void printSet() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      System.out.println(n.getName() + " " + n.getDistance() + " | " + n.getShortestPathNames());
    }
    System.out.println("-------------");
  }

  public void display() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node currentNode = it.next();
      currentNode.display();
      currentNode.showDestinationLines();
    }
  }

  void saveGraph() {
    processing.data.JSONObject json;
    json = new processing.data.JSONObject();
    json.setInt("nodeNum", nodes.size());
    saveJSONObject(json, "data/graph.json");


    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      n.saveNode();
    }
  }

  void loadGraph() {
    processing.data.JSONObject graphJson;
    graphJson = loadJSONObject("data/graph.json");
    int numNodes = graphJson.getInt("nodeNum");

    // create the nodes from JSON file
    ArrayList<Node> tempNodes = new ArrayList<Node>();
    for (int i = 0; i < numNodes; i++) {
      processing.data.JSONObject nodeJson = loadJSONObject("data/" + i + ".json");
      String name = nodeJson.getString("name");
      int x = nodeJson.getInt("x");
      int y = nodeJson.getInt("y");

      tempNodes.add(new Node(name, x, y));
    }

    // create the edges from JSON file
    for (int i = 0; i < tempNodes.size(); i++) {
      processing.data.JSONObject nodeJson = loadJSONObject("data/" + i + ".json");
      processing.data.JSONArray adjNodes = nodeJson.getJSONArray("adjacentNodes");
      for (int j = 0; j < adjNodes.size(); j++) {
        tempNodes.get(i).addDestination(tempNodes.get(parseInt(adjNodes.getString(j))));
      }
    }

    for (int i = 0; i < tempNodes.size(); i++) {
      addNode(tempNodes.get(i));
      stars.add(tempNodes.get(i));
    }
  }


    // set first point of constellation using two points from skeleton
  public void setStem(float xp, float yp) {
    // kernel point - find closest node to point
    float dis = Integer.MAX_VALUE;
    Node joint = new Node("temp", int(xp), int(yp));
    Iterator<Node> it = nodes.iterator();

    while (it.hasNext()) {
      Node n = it.next();
      float d = getPointDistance(n, joint);
      if (d < dis) {
        stem = n;
        dis = d;
      }
    }
  }
  
  public void setEndBone(float endX, float endY) {
    float dx = endX - stem.getX();
    float dy = endY - stem.getY();
    float len = sqrt(dx * dx + dy * dy);
    // angle to actual point
    float angle = atan(dy/dx);

    endBone = stem.getAdjNodeByAngle(angle, len);
  }
  
  public void makeBone(float stemX, float stemY, float endX, float endY) {
    setStem(stemX, stemY);
    setEndBone(endX, endY);
    if (stem != null && endBone != null) drawBones();
    fill(255, 255, 0);
    stroke(255, 255, 0);
    line(stemX, stemY, endX, endY);
  }

  public void drawBones() {
    fill(0, 255, 255);
    stroke(0, 255, 255);
    stem.displayEdge(endBone);
    
    
  }


  

  
}