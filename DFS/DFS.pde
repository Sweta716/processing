import java.util.Stack;
import java.util.*;
// Graph representation using an adjacency list
HashMap<Integer, ArrayList<Integer>> graph;
// To track visited nodes
boolean[] visited;
// Dimensions for drawing
int nodeSize = 30;
int[] nodeX, nodeY; // Positions of nodes

void setup() {
  size(800, 600);
  // Setup nodes and edges
  setupGraph();
  // Initialize visited array
  visited = new boolean[graph.size()];
  // Initialize positions for nodes for drawing
  setupPositions();
  frameRate(1); // Slow down the animation to 1 frame per second
}

void draw() {
  background(255);
  drawGraph();
  // Start DFS from node 0
  dfsAnimated(0);
  noLoop(); // Stops draw() from continuously executing
}

void dfsAnimated(int node) {
  if (visited[node]) return;
  visited[node] = true;
  
  // Highlight the current node
  fill(255, 0, 0);
  ellipse(nodeX[node], nodeY[node], nodeSize, nodeSize);
  
  for (int neighbor : graph.get(node)) {
    if (!visited[neighbor]) {
      // Draw line for the edge
      stroke(255, 0, 0);
      line(nodeX[node], nodeY[node], nodeX[neighbor], nodeY[neighbor]);
      delay(1000); // Wait for a second before continuing
      dfsAnimated(neighbor);
    }
  }
}

void setupGraph() {
  graph = new HashMap<Integer, ArrayList<Integer>>();
  // Example graph initialization
  graph.put(0, new ArrayList<Integer>(Arrays.asList(1, 2)));
  graph.put(1, new ArrayList<Integer>(Arrays.asList(0, 3, 4)));
  graph.put(2, new ArrayList<Integer>(Arrays.asList(0, 4)));
  graph.put(3, new ArrayList<Integer>(Arrays.asList(1)));
  graph.put(4, new ArrayList<Integer>(Arrays.asList(1, 2)));
}

void setupPositions() {
  nodeX = new int[graph.size()];
  nodeY = new int[graph.size()];
  // Arbitrary positions for nodes
  nodeX[0] = 100; nodeY[0] = 100;
  nodeX[1] = 300; nodeY[1] = 200;
  nodeX[2] = 200; nodeY[2] = 300;
  nodeX[3] = 400; nodeY[3] = 100;
  nodeX[4] = 300; nodeY[4] = 400;
}

void drawGraph() {
  for (int i = 0; i < graph.size(); i++) {
    fill(0, 0, 255);
    ellipse(nodeX[i], nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(0);
      line(nodeX[i], nodeY[i], nodeX[neighbor], nodeY[neighbor]);
    }
  }
}
