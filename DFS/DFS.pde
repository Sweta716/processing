import gifAnimation.*;
import java.util.*;

// Graph representation using an adjacency list
HashMap<Integer, ArrayList<Integer>> graph;
// To track visited nodes
boolean[] visited;
// Stack for DFS
Stack<Integer> stack;
// Dimensions for drawing
int nodeSize = 30;
int[] nodeX, nodeY; // Positions of nodes

GifMaker gifExport;

// Colors from the palette
color[] colors = {
  color(255, 204, 153), // Light Orange
  color(255, 153, 102), // Orange
  color(255, 102, 51),  // Dark Orange
  color(255, 255, 204), // Light Yellow
  color(255, 255, 153), // Yellow
  color(255, 255, 102), // Dark Yellow
  color(204, 255, 204), // Light Green
  color(153, 204, 153), // Green
  color(102, 153, 102), // Dark Green
  color(204, 255, 255), // Light Blue
  color(153, 204, 255), // Blue
  color(102, 153, 255)  // Dark Blue
};

color nodeColor = colors[10];       // Blue
color edgeColor = colors[6];        // Light Green
color currentColor = colors[2];     // Dark Orange
color visitedColor = colors[1];     // Orange

void setup() {
  size(800, 600);
  // Setup nodes and edges
  setupGraph();
  // Initialize visited array
  visited = new boolean[graph.size()];
  // Initialize positions for nodes for drawing
  setupPositions();
  // Initialize stack for DFS
  stack = new Stack<Integer>();
  stack.push(0);
  frameRate(1); // Slow down the animation to 1 frame per second
  
  // Setup GifMaker
  gifExport = new GifMaker(this, "dfs_animation.gif");
  gifExport.setRepeat(0); // Repeat indefinitely
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}

void draw() {
  background(255);
  drawGraph();
  // Continue DFS
  if (!stack.isEmpty()) {
    int node = stack.pop();
    if (!visited[node]) {
      visited[node] = true;
      // Highlight the current node
      fill(currentColor);
      ellipse(nodeX[node], nodeY[node], nodeSize, nodeSize);
      for (int neighbor : graph.get(node)) {
        if (!visited[neighbor]) {
          // Draw line for the edge
          stroke(currentColor);
          line(nodeX[node], nodeY[node], nodeX[neighbor], nodeY[neighbor]);
          stack.push(neighbor);
        }
      }
    }
  }
  // Add the current frame to the GIF
  gifExport.addFrame();
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
    noLoop(); // Stops draw() from continuously executing
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
    if (visited[i]) {
      fill(visitedColor);
    } else {
      fill(nodeColor);
    }
    ellipse(nodeX[i], nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(edgeColor);
      line(nodeX[i], nodeY[i], nodeX[neighbor], nodeY[neighbor]);
    }
  }
}

boolean done() {
  for (boolean v : visited) {
    if (!v) return false;
  }
  return true;
}
