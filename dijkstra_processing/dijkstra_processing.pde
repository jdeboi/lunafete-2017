/* 
 Visualization of Dijkstra's algorithm for finding the
 shortest path between two nodes in a (undirected?) graph.
 
 Developed and adapted from 
 http://www.baeldung.com/java-dijkstra
 */


import java.util.*;
boolean showEdges = true;
Graph graph;
Node startNode;

void setup() {
  size(600, 600);

  Node nodeA = new Node("A", 10, 10);
  startNode = nodeA;
  Node nodeB = new Node("B", 330, 22);
  Node nodeC = new Node("C", 100, 100);
  Node nodeD = new Node("D", 50, 230); 
  Node nodeE = new Node("E", 220, 170);
  Node nodeF = new Node("F", 105, 301);

  nodeA.addDestination(nodeB);
  nodeA.addDestination(nodeC);

  nodeB.addDestination(nodeD);
  nodeB.addDestination(nodeF);

  nodeC.addDestination(nodeE);

  nodeD.addDestination(nodeE);
  nodeD.addDestination(nodeF);

  nodeF.addDestination(nodeE);

  graph = new Graph();

  graph.addNode(nodeA);
  graph.addNode(nodeB);
  graph.addNode(nodeC);
  graph.addNode(nodeD);
  graph.addNode(nodeE);
  graph.addNode(nodeF);

  //graph.printSet();
  graph = calculateShortestPathFromSource(graph, nodeA);
  //graph.printSet();
}

void draw() {
  graph.display();
  graph.drawShortest();
}

void mouseClicked() {
  Node mouseNode = graph.getMouseNode();
  if (mouseNode != null) {
    startNode = mouseNode;
    graph = calculateShortestPathFromSource(graph, startNode);
  }
}

private static Node getLowestDistanceNode(Set < Node > unsettledNodes) {
  Node lowestDistanceNode = null;
  int lowestDistance = Integer.MAX_VALUE;
  for (Node node : unsettledNodes) {
    int nodeDistance = node.getDistance();
    if (nodeDistance < lowestDistance) {
      lowestDistance = nodeDistance;
      lowestDistanceNode = node;
    }
  }
  return lowestDistanceNode;
}

public static Graph calculateShortestPathFromSource(Graph graph, Node source) {
  source.setDistance(0);

  Set<Node> settledNodes = new HashSet<Node>();
  Set<Node> unsettledNodes = new HashSet<Node>();

  unsettledNodes.add(source);

  while (unsettledNodes.size() != 0) {
    Node currentNode = getLowestDistanceNode(unsettledNodes);
    unsettledNodes.remove(currentNode);
    for (Map.Entry < Node, Integer> adjacencyPair : 
      currentNode.getAdjacentNodes().entrySet()) {
      Node adjacentNode = adjacencyPair.getKey();
      Integer edgeWeight = adjacencyPair.getValue();
      if (!settledNodes.contains(adjacentNode)) {
        calculateMinimumDistance(adjacentNode, edgeWeight, currentNode);
        unsettledNodes.add(adjacentNode);
      }
    }
    settledNodes.add(currentNode);
  }
  return graph;
}

private static void calculateMinimumDistance(Node evaluationNode, 
  Integer edgeWeigh, Node sourceNode) {
  Integer sourceDistance = sourceNode.getDistance();
  if (sourceDistance + edgeWeigh < evaluationNode.getDistance()) {
    evaluationNode.setDistance(sourceDistance + edgeWeigh);
    LinkedList<Node> shortestPath = new LinkedList<Node>(sourceNode.getShortestPath());
    shortestPath.add(sourceNode);
    evaluationNode.setShortestPath(shortestPath);
  }
}

public static float getPointDistance(Node n1, Node n2) {
  return sqrt((n2.getX() - n1.getX())*(n2.getX() - n1.getX()) + (n2.getY() - n1.getY())*(n2.getY() - n1.getY()));
}