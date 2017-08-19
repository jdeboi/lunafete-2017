import java.util.*;
boolean showEdges = false;
ArrayList<Node> stars;

int mode = 1;
int VISUALIZE = 0;
int ADD_STARS = 1;
int ADD_EDGES = 2;
int MOVE_STARS = 3;

Node currentNode = null;
Node startNode;
Node currentStar = null;

Graph graph;

void setup() {
  size(600, 600);

  stars = new ArrayList<Node>();

}

void draw() {
  setBackground();
  if (mode != VISUALIZE) {
    for (int i = 0; i < stars.size(); i++) {
      stars.get(i).display();
    }
  }
  else {
    graph.display();
  }
  if (mode == ADD_EDGES) {
    if (currentNode != null) {
      stroke(255);
      line(currentNode.getX(), currentNode.getY(), mouseX, mouseY);
    }
  }
}

void mouseClicked() {
  if (mode == ADD_STARS) {
    stars.add(new Node(stars.size()+"", mouseX, mouseY));
  } else if (mode == MOVE_STARS) {
    for (int i = 0; i < stars.size(); i++) {
      if (stars.get(i).mouseOver()) {
        currentStar = stars.get(i);
        return;
      }
    }
  }else if (mode == ADD_EDGES) {
    for (int i = 0; i < stars.size(); i++) {
      if (stars.get(i).mouseOver()) {
        // haven't clicked on a star yet
        if (currentNode == null) {
          currentNode = stars.get(i);
        } 
        // clicked on the same star
        else if (currentNode.equals(stars.get(i))) {
          currentNode = null;
        // clicked a new star! let's add an edge
        } else {
          // undirected graph now?
          currentNode.addDestination(stars.get(i));
          stars.get(i).addDestination(currentNode);
          currentNode = stars.get(i);
        }
        return;
      }
    }
    currentNode = null;
    return;
  }
}

void keyPressed() {
  if (key == 's') {
    if (stars.size() > 1) {
      graph = new Graph();
      for (int i = 0; i < stars.size(); i++) {
        graph.addNode(stars.get(i));
      }
      startNode = stars.get(0);
      graph = calculateShortestPathFromSource(graph, startNode);
      graph.printSet(); 
      mode = VISUALIZE;
    }
    graph.saveGraph();
  }
  else if (key == 'l') {
    mode = VISUALIZE;
    stars = new ArrayList<Node>();
    graph = new Graph();
    graph.loadGraph();  
    graph.printSet();
  }
  else if (key == 'a') {
    mode = ADD_STARS;
  }
  else if (key == 'e') {
    mode = ADD_EDGES;
  }
  else if (key == 'm') {
    mode = MOVE_STARS;
  }
  else if (mode == MOVE_STARS) {
    if (currentStar != null) {
      if (keyCode == UP) currentStar.move(0, -1);
       else if (keyCode == DOWN) currentStar.move(0, 1);
       else if (keyCode == RIGHT) currentStar.move(1, 0);
       else if (keyCode == LEFT) currentStar.move(-1, 0);
    }
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

void setBackground() {
  if (mode == ADD_EDGES) {
    background(100, 0, 100);
  }
  else if (mode == ADD_STARS) {
    background(0, 100, 100);
  }
  else {
    background(0);
  }
}

public void visualizeArm(float xp1, float yp1, float xp2, float yp2) {
  
}