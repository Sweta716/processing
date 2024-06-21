import gifAnimation.*;
import java.util.*;
import java.util.ArrayList;
import java.util.Stack;

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

GifMaker gifExport;

// Colors from the provided palette
color nodeColor = color(167, 231, 182); // Light green for nodes
color edgeColor = color(41, 116, 150); // Blue for edges
color visitedNodeColor = color(239, 107, 72); // Red-orange for visited nodes

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

  // Setup GifMaker
  gifExport = new GifMaker(this, "topological_sort_visualization.gif");
  gifExport.setRepeat(0); // Make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Adjust GIF speed
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
    gifExport.finish(); // Finish the GIF once done
    noLoop(); // Stops draw() from continuously executing after sorting
  }
  gifExport.addFrame(); // Add the current frame to the GIF
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
  nodeX = new int[]{100, 300, 500, 100, 300, 500};
  nodeY = new int[]{100, 100, 100, 300, 300, 300};
}

void drawGraph() {
  textSize(16);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < graph.size(); i++) {
    if (visited[i]) {
      fill(visitedNodeColor); // Color for visited nodes
    } else {
      fill(nodeColor); // Default node color
    }
    ellipse(nodeX[i], nodeY[i], nodeSize, nodeSize);
    fill(0);
    text(i, nodeX[i], nodeY[i]); // Draw the node label
    for (int neighbor : graph.get(i)) {
      stroke(edgeColor); // Edge color
      line(nodeX[i], nodeY[i], nodeX[neighbor], nodeY[neighbor]);
    }
  }
}
