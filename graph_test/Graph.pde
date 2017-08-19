public class Graph {

  private Set<Node> nodes = new HashSet<Node>();

  public void addNode(Node nodeA) {
    nodes.add(nodeA);
  }

  public void printMe() {
    for (Node node : nodes) {
      println(node.getDistance());
    }
  }

  public void printSet() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node n = it.next();
      System.out.println(n.getName() + " " + n.getDistance() + n.getShortestPathNames());
    }
  }

  public void display() {
    Iterator<Node> it = nodes.iterator();
    while (it.hasNext()) {
      Node currentNode = it.next();
      currentNode.display();
      for (Map.Entry < Node, Integer> adjacencyPair : 
        currentNode.getAdjacentNodes().entrySet()) {
        Node adjacentNode = adjacencyPair.getKey();
        line(currentNode.getX(), currentNode.getY(), adjacentNode.getX(), adjacentNode.getY());
      }
    }
  }
}