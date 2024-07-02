import gifAnimation.*;
import java.util.LinkedList;
import java.util.Queue;

class Node {
  int x, y;
  String label;
  boolean visited;
  
  Node(int x, int y, String label) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.visited = false;
  }
}

class Edge {
  int from, to;
  
  Edge(int from, int to) {
    this.from = from;
    this.to = to;
  }
}

Node[] nodes = {
  new Node(960, 200, "S"),   // Node 0
  new Node(560, 400, "A"),   // Node 1
  new Node(960, 400, "B"),   // Node 2
  new Node(1360, 400, "C"),  // Node 3
  new Node(960, 600, "D")    // Node 4
};

Edge[] edges = {
  new Edge(0, 1), new Edge(0, 2), 
  new Edge(0, 3), new Edge(2, 4),
  new Edge(1, 4), new Edge(3, 4)
};

Queue<Integer> queue = new LinkedList<>();
int currentStep = 0;
String currentAction = "";
GifMaker gifMaker;
boolean recording = false;
int frameCount = 0;

void setup() {
  size(1920, 1080);
  background(255);
  
  // Initialize GIF maker
  gifMaker = new GifMaker(this, "bfs_visualization.gif");
  gifMaker.setRepeat(0); // Loop indefinitely
  gifMaker.setQuality(10);
  gifMaker.setDelay(50);
  
  // Initialize BFS
  queue.add(0); // Start from node S (index 0)
  currentAction = "Enqueue the source vertex S into queue Q.";
  nodes[0].visited = true; // Mark the source node as visited
}

void draw() {
  background(255);
  drawGraph();
  drawQueue();
  displayText(currentAction);
  
  if (recording) {
    gifMaker.addFrame();
    frameCount++;
    
    if (frameCount % 60 == 0) { // Faster step interval
      bfsStep();
    }
    
    if (queue.isEmpty() && currentStep > 0) {
      recording = false;
      gifMaker.finish();
      println("GIF saved!");
    }
  }
}

void drawGraph() {
  stroke(0);
  strokeWeight(2);
  
  // Draw edges
  for (Edge e : edges) {
    Node fromNode = nodes[e.from];
    Node toNode = nodes[e.to];
    line(fromNode.x, fromNode.y, toNode.x, toNode.y);
  }
  
  // Draw nodes
  for (Node n : nodes) {
    fill(n.visited ? color(200, 255, 200) : 255);
    ellipse(n.x, n.y, 60, 60);
    fill(0);
    textAlign(CENTER, CENTER);
    text(n.label, n.x, n.y);
  }
}

void drawQueue() {
  int offsetX = 50;
  int offsetY = 950;
  fill(0);
  textAlign(LEFT, CENTER);
  text("Queue Q:", offsetX, offsetY);
  offsetX += 80;
  
  for (int v : queue) {
    Node n = nodes[v];
    fill(255);
    stroke(0);
    rect(offsetX, offsetY - 20, 60, 60);
    fill(0);
    textAlign(CENTER, CENTER);
    text(n.label, offsetX + 30, offsetY + 10);
    offsetX += 70;
  }
}

void bfsStep() {
  if (!queue.isEmpty()) {
    int u = queue.poll();
    Node uNode = nodes[u];
    currentAction = "Dequeue vertex " + uNode.label + " from Q. Mark " + uNode.label + " as visited.";
    for (Edge e : edges) {
      if (e.from == u && !nodes[e.to].visited) {
        nodes[e.to].visited = true;
        queue.add(e.to);
        currentAction = "Visit all unvisited neighbors of " + uNode.label + " and enqueue them into Q.";
      } else if (e.to == u && !nodes[e.from].visited) {
        nodes[e.from].visited = true;
        queue.add(e.from);
        currentAction = "Visit all unvisited neighbors of " + uNode.label + " and enqueue them into Q.";
      }
    }
  }
  currentStep++;
}

void displayText(String msg) {
  fill(255);
  noStroke();
  rect(0, height - 100, width, 100); // Background for text
  fill(0);
  textSize(24);
  textAlign(LEFT, CENTER);
  text(msg, 20, height - 50);
}

//void mousePressed() {
//  if (!recording) {
//    recording = true;
//    frameCount = 0;
//  }
//}
