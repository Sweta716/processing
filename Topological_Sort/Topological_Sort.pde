import java.util.HashMap;
import java.util.ArrayList;
import java.util.Stack;
import java.util.*;
// Graph representation using an adjacency list
HashMap<Integer, ArrayList<Integer>> graph;
// To keep track of visited nodes
boolean[] visited;
// Stack to hold the topologically sorted elements
Stack<Integer> stack;
// Dimensions for drawing
int nodeSize = 30;
int[] nodeX, nodeY; // Positions of nodes
int current = 0; // current node being processed

void setup() {
  size(800, 600);
  // Setup nodes and edges
  setupGraph();
  // Initialize visited array and stack
  visited = new boolean[graph.size()];
  stack = new Stack<Integer>();
  // Initialize positions for nodes for drawing
  setupPositions();
  frameRate(1); // Slow down the animation for visualization
}

void draw() {
  background(255);
  drawGraph();
  if (current < graph.size()) {
    if (!visited[current]) {
      topologicalSortUtil(current);
    }
    current++;
  } else {
    displaySortOrder();
    noLoop(); // Stops draw() from continuously executing after sorting
  }
}

void topologicalSortUtil(int v) {
  // Mark the current node as visited
  visited[v] = true;
  // Recur for all vertices adjacent to this vertex
  for (int i : graph.get(v)) {
    if (!visited[i]) {
      topologicalSortUtil(i);
    }
  }
  // Push current vertex to stack which stores the result
  stack.push(v);
}

void displaySortOrder() {
  // Display the contents of stack
  fill(0);
  textSize(20);
  text("Topological Sort Order:", 50, 50);
  int posX = 50, posY = 80;
  for (int node : stack) {
    text(node, posX, posY);
    posX += 40;
  }
}

void setupGraph() {
  graph = new HashMap<Integer, ArrayList<Integer>>();
  // Example graph initialization
  graph.put(0, new ArrayList<Integer>(Arrays.asList(1, 3)));
  graph.put(1, new ArrayList<Integer>(Arrays.asList(3, 4)));
  graph.put(2, new ArrayList<Integer>(Arrays.asList(0, 5)));
  graph.put(3, new ArrayList<Integer>(Arrays.asList(5)));
  graph.put(4, new ArrayList<Integer>(Arrays.asList()));
  graph.put(5, new ArrayList<Integer>(Arrays.asList(4)));
}

void setupPositions() {
  nodeX = new int[]{100, 200, 100, 200, 300, 400};
  nodeY = new int[]{300, 200, 100, 100, 200, 300};
}

void drawGraph() {
  for (int i = 0; i < graph.size(); i++) {
    fill(200);
    ellipse(nodeX[i], nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(0);
      line(nodeX[i], nodeY[i], nodeX[neighbor], nodeY[neighbor]);
    }
  }
}
