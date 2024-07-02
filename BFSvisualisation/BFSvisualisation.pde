import gifAnimation.*;

// Variables for customization
int canvasWidth = 1920;
int canvasHeight = 1080;
int delay = 1000;  // Delay in milliseconds for each frame
int nodeSize = 50;  // Size of the nodes
int currentNodeSize = 60;  // Size of the current node being processed
int frameRateControl = 1;  // Frame rate for the Processing sketch

// Colors for nodes
color[] nodeColors = {
  color(255, 200, 150), color(255, 170, 100), color(255, 140, 80),
  color(255, 220, 120), color(255, 200, 100), color(255, 180, 80)
};
color visitedColor = color(200);
color currentNodeColor = color(255, 0, 0);

GifMaker gifExport;
PVector[] nodes;
int[][] edges;
boolean[] visited;
int currentNode = -1;
ArrayList<Integer> queue = new ArrayList<Integer>();
int step = 0;
String explanation = "";

void settings() {
  size(canvasWidth, canvasHeight);
}

void setup() {
  // Initialize GIF export
  gifExport = new GifMaker(this, "bfs_visualization.gif");
  gifExport.setRepeat(1);  // Repeat the GIF once (runs twice in total)
  
  // Define nodes and their positions
  nodes = new PVector[6];
  nodes[0] = new PVector(width/2, height/4);    // A
  nodes[1] = new PVector(width/4, height/2);    // B
  nodes[2] = new PVector(3*width/4, height/2);  // C
  nodes[3] = new PVector(width/8, 3*height/4);  // D
  nodes[4] = new PVector(width/2, 3*height/4);  // E
  nodes[5] = new PVector(7*width/8, 3*height/4);// F
  
  // Define edges between nodes
  edges = new int[][]{
    {0, 1}, {0, 2},  // A-B, A-C
    {1, 3}, {1, 4},  // B-D, B-E
    {2, 5}           // C-F
  };
  
  // Initialize visited array
  visited = new boolean[nodes.length];
  queue.add(0);  // Start with node A
  visited[0] = true;
  explanation = "Step 1: Initialize - Start with node A in the queue and mark it as visited.";
  
  // Set frame rate for Processing sketch
  frameRate(frameRateControl); 
}

void draw() {
  background(255);
  drawGraph();
  displayExplanation();
  
  // BFS algorithm processing
  if (step % 2 == 0 && !queue.isEmpty()) {
    int node = queue.remove(0);  // Dequeue node
    currentNode = node;
    explanation = "Step " + (step/2 + 2) + ": Dequeue node " + (char)(65 + node) + " and visit its neighbors.";
    
    // Visit neighbors
    for (int i = 0; i < edges.length; i++) {
      if (edges[i][0] == node && !visited[edges[i][1]]) {
        queue.add(edges[i][1]);
        visited[edges[i][1]] = true;
        explanation += " Enqueue node " + (char)(65 + edges[i][1]) + " and mark it as visited.";
      }
    }
  } else if (queue.isEmpty() && step % 2 == 0) {
    explanation = "Step " + (step/2 + 2) + ": BFS complete - all nodes visited.";
    gifExport.setDelay(delay);
    gifExport.addFrame();  // Ensure the last frame is added
    gifExport.finish();
    noLoop();  // Stop the loop
  }
  
  gifExport.setDelay(delay);
  gifExport.addFrame();
  step++;
}

// Function to draw the graph
void drawGraph() {
  for (int i = 0; i < edges.length; i++) {
    PVector start = nodes[edges[i][0]];
    PVector end = nodes[edges[i][1]];
    stroke(0);
    line(start.x, start.y, end.x, end.y);  // Draw edges
  }
  
  for (int i = 0; i < nodes.length; i++) {
    if (visited[i]) {
      fill(nodeColors[i]);
    } else {
      fill(visitedColor);
    }
    ellipse(nodes[i].x, nodes[i].y, nodeSize, nodeSize);  // Draw nodes
    fill(0);
    textAlign(CENTER, CENTER);
    text((char)(65 + i), nodes[i].x, nodes[i].y);  // Label nodes
  }
  
  if (currentNode != -1) {
    PVector currentPos = nodes[currentNode];
    fill(currentNodeColor);
    ellipse(currentPos.x, currentPos.y, currentNodeSize, currentNodeSize);  // Highlight current node
  }
}

// Function to display the explanation
void displayExplanation() {
  fill(0);
  textSize(24);
  textAlign(LEFT, TOP);
  text(explanation, 10, 10, width - 20, height - 20);  // Display explanation text
}
