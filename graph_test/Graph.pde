public class Graph {

  private Set<Node> nodes = new HashSet<Node>();

  public void addNode(Node nodeA) {
    nodes.add(nodeA);
  }

  public void printSet() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      System.out.println(n.getName() + " " + n.getDistance() + n.getShortestPathNames());
    }
    System.out.println("---------------");
  }
  
  public Node getMouseNode() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node currentNode = it.next();
      if (currentNode.mouseOver()) {
        return currentNode;
      }
    }
    return null;
  }

  public void display() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node currentNode = it.next();
      currentNode.display();
      if (showEdges) {
        for (Map.Entry < Node, Integer> adjacencyPair : 
          currentNode.getAdjacentNodes().entrySet()) {
          Node adjacentNode = adjacencyPair.getKey();
          stroke(255);
          fill(255);
          line(currentNode.getX(), currentNode.getY(), adjacentNode.getX(), adjacentNode.getY());
        }
      }
    }
  }
  
  public void drawShortest() {
    Node mouseNode = getMouseNode();
    if (mouseNode != null) {
      mouseNode.displayShortestPath();
    }
  }
}