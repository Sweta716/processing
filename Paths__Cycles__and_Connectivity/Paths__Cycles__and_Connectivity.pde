import gifAnimation.*;

// Variables for graph structure
int[][] nodes = {
  {100, 100}, {200, 100}, {300, 100}, 
  {100, 200}, {200, 200}, {300, 200}, 
  {100, 300}, {200, 300}, {300, 300}
};

int[][] edges = {
  {0, 1}, {1, 2}, {3, 4}, {4, 5}, {6, 7}, {7, 8},
  {0, 3}, {3, 6}, {1, 4}, {4, 7}, {2, 5}, {5, 8},
  {0, 4}, {4, 8}, {2, 4}, {4, 6}
};

color[] colors = {
  color(255, 200, 150), color(255, 150, 100), color(255, 100, 50),
  color(255, 250, 150), color(255, 230, 100), color(255, 200, 50),
  color(200, 255, 200), color(150, 200, 150), color(100, 150, 100),
  color(150, 250, 255), color(100, 200, 255), color(50, 150, 255)
};

GifMaker gifMaker;
int frameCount = 0;
boolean recording = false;

void setup() {
  size(400, 400);
  background(255);
  
  // Initialize GIF maker
  gifMaker = new GifMaker(this, "graph.gif");
  gifMaker.setRepeat(0); // Loop indefinitely
  gifMaker.setQuality(10);
  gifMaker.setDelay(100);
  
  // Draw initial graph
  drawGraph();
}

void drawGraph() {
  background(255);
  stroke(0);
  strokeWeight(2);
  
  // Draw edges
  for (int i = 0; i < edges.length; i++) {
    int x1 = nodes[edges[i][0]][0];
    int y1 = nodes[edges[i][0]][1];
    int x2 = nodes[edges[i][1]][0];
    int y2 = nodes[edges[i][1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Draw nodes
  for (int i = 0; i < nodes.length; i++) {
    fill(colors[i % colors.length]);
    ellipse(nodes[i][0], nodes[i][1], 40, 40);
  }
  
  // Display initial explanation
  displayText("Click to start the demonstration");
}

void drawPath(int[] path) {
  stroke(255, 0, 0);
  strokeWeight(4);
  
  for (int i = 0; i < path.length - 1; i++) {
    int x1 = nodes[path[i]][0];
    int y1 = nodes[path[i]][1];
    int x2 = nodes[path[i + 1]][0];
    int y2 = nodes[path[i + 1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Explanation text for path
  displayText("Path: A sequence of edges connecting distinct nodes");
}

void drawCycle(int[] cycle) {
  stroke(0, 0, 255);
  strokeWeight(4);
  
  for (int i = 0; i < cycle.length - 1; i++) {
    int x1 = nodes[cycle[i]][0];
    int y1 = nodes[cycle[i]][1];
    int x2 = nodes[cycle[i + 1]][0];
    int y2 = nodes[cycle[i + 1]][1];
    line(x1, y1, x2, y2);
  }
  
  int x1 = nodes[cycle[cycle.length - 1]][0];
  int y1 = nodes[cycle[cycle.length - 1]][1];
  int x2 = nodes[cycle[0]][0];
  int y2 = nodes[cycle[0]][1];
  line(x1, y1, x2, y2);
  
  // Explanation text for cycle
  displayText("Cycle: A path that starts and ends at the same node");
}

void drawConnectivity() {
  // Highlighting the entire graph to show connectivity
  stroke(0, 255, 0);
  strokeWeight(4);
  
  for (int i = 0; i < edges.length; i++) {
    int x1 = nodes[edges[i][0]][0];
    int y1 = nodes[edges[i][0]][1];
    int x2 = nodes[edges[i][1]][0];
    int y2 = nodes[edges[i][1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Explanation text for connectivity
  displayText("Connectivity: There is a path between any two nodes");
}

void displayText(String msg) {
  fill(255);
  noStroke();
  rect(0, height - 50, width, 50); // Background for text
  fill(0);
  textSize(14);
  textAlign(CENTER, CENTER);
  text(msg, width / 2, height - 25);
}

void mousePressed() {
  if (!recording) {
    recording = true;
    frameCount = 0;
  }
}

void draw() {
  if (recording) {
    if (frameCount == 0) {
      drawGraph();
    } else if (frameCount == 50) {
      int[] path = {0, 1, 2, 5, 8};
      drawPath(path);
    } else if (frameCount == 100) {
      int[] cycle = {0, 4, 8, 4, 0};
      drawCycle(cycle);
    } else if (frameCount == 150) {
      drawConnectivity();
    } else if (frameCount > 200) {
      recording = false;
      gifMaker.finish();
      println("GIF saved!");
    }
    
    gifMaker.addFrame();
    frameCount++;
  }
}
