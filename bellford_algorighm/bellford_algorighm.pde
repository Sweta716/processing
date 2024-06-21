import gifAnimation.*;

int[][] edges = {
  {0, 1, 6}, {0, 2, 5}, {1, 3, 2}, {1, 4, 8}, {2, 3, 2},
  {2, 1, 6}, {3, 4, 1}, {4, 5, 3}, {3, 5, 6}
};
String[] nodeLabels = {"a", "b", "c", "d", "e", "f"};
PVector[] nodes = {
  new PVector(100, 300), // a
  new PVector(300, 100), // b
  new PVector(300, 500), // c
  new PVector(500, 300), // d
  new PVector(700, 300), // e
  new PVector(900, 300)  // f
};

int[] distances;
int currentIteration = 0;
int currentEdgeIndex = 0;
boolean hasNegativeCycle = false;
PFont font;
GifMaker gifMaker;

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

void setup() {
  size(1000, 600); // Increased height for bottom text
  distances = new int[nodes.length];
  for (int i = 0; i < distances.length; i++) {
    distances[i] = (i == 0) ? 0 : Integer.MAX_VALUE;
  }
  font = createFont("Lato", 32);
  textFont(font);
  frameRate(1); // Slower frame rate
  
  // Setup GifMaker
  gifMaker = new GifMaker(this, "BellmanFordAlgorithm.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
}

void draw() {
  background(255);
  drawGraph();
  
  if (currentIteration < nodes.length - 1) {
    fill(0);
    textAlign(LEFT, TOP);
    text("Iteration: " + currentIteration, 50, 50);
    relaxEdges();
    currentEdgeIndex++;
    if (currentEdgeIndex >= edges.length) {
      currentEdgeIndex = 0;
      currentIteration++;
    }
  } else if (currentIteration == nodes.length - 1) {
    checkForNegativeCycles();
    currentIteration++;
  } else {
    displayFinalResult();
    noLoop();
    gifMaker.finish(); // Finish the GIF
  }
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
}

void drawGraph() {
  strokeWeight(2);
  for (int[] edge : edges) {
    int from = edge[0];
    int to = edge[1];
    float weight = edge[2];
    stroke(0);
    line(nodes[from].x, nodes[from].y, nodes[to].x, nodes[to].y);
    fill(0);
    textAlign(CENTER, CENTER);
    text(str(weight), (nodes[from].x + nodes[to].x) / 2, (nodes[from].y + nodes[to].y) / 2 - 10);
  }
  for (int i = 0; i < nodes.length; i++) {
    fill(colors[i % colors.length]); // Use a color from the palette
    ellipse(nodes[i].x, nodes[i].y, 60, 60);
    fill(0);
    textAlign(CENTER, CENTER);
    text(nodeLabels[i], nodes[i].x, nodes[i].y);
    String distanceText = (distances[i] == Integer.MAX_VALUE) ? "∞" : str(distances[i]);
    textAlign(CENTER, BOTTOM);
    text(distanceText, nodes[i].x, nodes[i].y + 40);
  }
}

void relaxEdges() {
  int[] edge = edges[currentEdgeIndex];
  int from = edge[0];
  int to = edge[1];
  int weight = edge[2];
  
  // Highlight the current edge
  stroke(255, 0, 0);
  strokeWeight(4);
  line(nodes[from].x, nodes[from].y, nodes[to].x, nodes[to].y);
  fill(0);
  textAlign(CENTER, CENTER);
  text(str(weight), (nodes[from].x + nodes[to].x) / 2, (nodes[from].y + nodes[to].y) / 2 - 10);
  
  if (distances[from] != Integer.MAX_VALUE && distances[from] + weight < distances[to]) {
    distances[to] = distances[from] + weight;
  }
}

void checkForNegativeCycles() {
  for (int[] edge : edges) {
    int from = edge[0];
    int to = edge[1];
    int weight = edge[2];
    if (distances[from] != Integer.MAX_VALUE && distances[from] + weight < distances[to]) {
      hasNegativeCycle = true;
      break;
    }
  }
}

void displayFinalResult() {
  fill(0);
  textAlign(LEFT, TOP);
  if (hasNegativeCycle) {
    text("Negative weight cycle detected!", 50, 500); // Moved text to the bottom
  } else {
    text("No negative weight cycles detected.", 50, 500); // Moved text to the bottom
  }
  text("Time Complexity: O(VE)", 50, 550); // Moved text to the bottom
}
