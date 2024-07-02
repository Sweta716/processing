import gifAnimation.*;

// Define nodes for the graph
int[][] nodes = {
  {100, 100},   // Node 0
  {300, 100},   // Node 1
  {100, 300},   // Node 2
  {300, 300}    // Node 3
};

String[] labels = {
  "0", "1", "2", "3"
};

int[][] edges = {
  {0, 1}, {1, 2}, {2, 3}, {3, 0}, {0, 2}
};

int[][] adjMatrix = {
  {0, 1, 1, 1},
  {1, 0, 1, 0},
  {1, 1, 0, 1},
  {1, 0, 1, 0}
};

int[][] adjList = {
  {1, 2, 3},
  {0, 2},
  {0, 1, 3},
  {0, 2}
};

GifMaker gifMaker;
int frameCount = 0;
boolean recording = false;

void setup() {
  size(600, 600);
  background(255);
  
  // Initialize GIF maker
  gifMaker = new GifMaker(this, "graph_data_structures.gif");
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
  
  // Draw graph edges
  for (int i = 0; i < edges.length; i++) {
    int x1 = nodes[edges[i][0]][0];
    int y1 = nodes[edges[i][0]][1];
    int x2 = nodes[edges[i][1]][0];
    int y2 = nodes[edges[i][1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Draw graph nodes
  for (int i = 0; i < labels.length; i++) {
    fill(255);
    stroke(0);
    ellipse(nodes[i][0], nodes[i][1], 30, 30);
    fill(0);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(labels[i], nodes[i][0], nodes[i][1]);
  }
  
  // Display explanation for graphs
  displayText(
    "Graphs: Powerful tools in computer science\n" +
    "Used in social networks, transportation systems, task scheduling, etc."
  );
}

void drawAdjMatrix() {
  background(255);
  stroke(0);
  strokeWeight(2);
  
  // Draw adjacency matrix
  int cellSize = 40;
  int offsetX = 100;
  int offsetY = 100;
  
  fill(0);
  textSize(12);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < adjMatrix.length; i++) {
    for (int j = 0; j < adjMatrix[i].length; j++) {
      fill(255);
      stroke(0);
      rect(offsetX + j * cellSize, offsetY + i * cellSize, cellSize, cellSize);
      fill(0);
      text(adjMatrix[i][j], offsetX + j * cellSize + cellSize / 2, offsetY + i * cellSize + cellSize / 2);
    }
  }
  
  // Draw labels
  for (int i = 0; i < labels.length; i++) {
    fill(0);
    text(labels[i], offsetX - 20, offsetY + i * cellSize + cellSize / 2);
    text(labels[i], offsetX + i * cellSize + cellSize / 2, offsetY - 20);
  }
  
  // Display explanation for adjacency matrix
  displayText(
    "Adjacency Matrix:\n" +
    "2D array where each cell [i][j] indicates whether there's an edge from node i to node j."
  );
}

void drawAdjList() {
  background(255);
  stroke(0);
  strokeWeight(2);
  
  // Draw adjacency list
  int offsetX = 100;
  int offsetY = 100;
  
  fill(0);
  textSize(12);
  textAlign(LEFT, TOP);
  for (int i = 0; i < adjList.length; i++) {
    text(labels[i] + ": " + join(intArrayToStringArray(adjList[i]), ", "), offsetX, offsetY + i * 40);
  }
  
  // Display explanation for adjacency list
  displayText(
    "Adjacency List:\n" +
    "Array of lists where each list contains the nodes connected to a specific node."
  );
}

String[] intArrayToStringArray(int[] arr) {
  String[] strArr = new String[arr.length];
  for (int i = 0; i < arr.length; i++) {
    strArr[i] = str(arr[i]);
  }
  return strArr;
}

void displayText(String msg) {
  fill(255);
  noStroke();
  rect(0, height - 100, width, 100); // Background for text
  fill(0);
  textSize(12);
  textAlign(LEFT, TOP);
  text(msg, 10, height - 90, width - 20, 90);
}

void mousePressed() {
  if (!recording) {
    recording = true;
    frameCount = 0;
  }
}

void draw() {
  if (recording) {
    if (frameCount >= 0 && frameCount < 200) {
      drawGraph();
    } else if (frameCount >= 200 && frameCount < 400) {
      drawAdjMatrix();
    } else if (frameCount >= 400 && frameCount < 600) {
      drawAdjList();
    } else if (frameCount >= 600) {
      recording = false;
      gifMaker.finish();
      println("GIF saved!");
    }
    
    gifMaker.addFrame();
    frameCount++;
  }
}
