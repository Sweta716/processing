import gifAnimation.*;

// Define nodes and edges for the tree
int[][] nodes = {
  {200, 50},   // Root node
  {100, 150}, {300, 150},
  {50, 250}, {150, 250}, {250, 250}, {350, 250}
};

String[] labels = {
  "A", "B", "C", 
  "D", "E", "F", "G"
};

int[][] treeEdges = {
  {0, 1}, {0, 2},
  {1, 3}, {1, 4}, {2, 5}, {2, 6}
};

GifMaker gifMaker;
int frameCount = 0;
boolean recording = false;

void setup() {
  size(600, 600);
  background(255);
  
  // Initialize GIF maker
  gifMaker = new GifMaker(this, "tree_rooted_tree_explanation.gif");
  gifMaker.setRepeat(0); // Loop indefinitely
  gifMaker.setQuality(10);
  gifMaker.setDelay(100);
  
  // Draw initial tree
  drawTree();
}

void drawTree() {
  background(255);
  stroke(0);
  strokeWeight(2);
  
  // Draw tree edges
  for (int i = 0; i < treeEdges.length; i++) {
    int x1 = nodes[treeEdges[i][0]][0];
    int y1 = nodes[treeEdges[i][0]][1];
    int x2 = nodes[treeEdges[i][1]][0];
    int y2 = nodes[treeEdges[i][1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Draw tree nodes
  for (int i = 0; i < labels.length; i++) {
    fill(255);
    stroke(0);
    ellipse(nodes[i][0], nodes[i][1], 30, 30);
    fill(0);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(labels[i], nodes[i][0], nodes[i][1]);
  }
  
  // Display explanation for trees
  displayText(
    "Tree: A connected graph with no cycles\n" +
    "Properties:\n" +
    "1. Connected: Path between any two nodes\n" +
    "2. Acyclic: No cycles\n" +
    "3. Unique Path: Exactly one path between any two nodes\n\n" +
    "Example:\n" +
    "    A\n" +
    "   / \\\n" +
    "  B   C\n" +
    " / \\\n" +
    "D   E"
  );
}

void drawRootedTree() {
  background(255);
  stroke(0);
  strokeWeight(2);
  
  // Draw rooted tree edges
  for (int i = 0; i < treeEdges.length; i++) {
    int x1 = nodes[treeEdges[i][0]][0];
    int y1 = nodes[treeEdges[i][0]][1];
    int x2 = nodes[treeEdges[i][1]][0];
    int y2 = nodes[treeEdges[i][1]][1];
    line(x1, y1, x2, y2);
  }
  
  // Draw rooted tree nodes
  for (int i = 0; i < labels.length; i++) {
    fill(255);
    stroke(0);
    ellipse(nodes[i][0], nodes[i][1], 30, 30);
    fill(0);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(labels[i], nodes[i][0], nodes[i][1]);
  }
  
  // Highlight the root node
  fill(255, 0, 0);
  ellipse(nodes[0][0], nodes[0][1], 30, 30);
  fill(0);
  text(labels[0], nodes[0][0], nodes[0][1]);
  
  // Display explanation for rooted trees
  displayText(
    "Rooted Tree: A tree with one designated root node\n" +
    "Properties:\n" +
    "1. Root: Designated starting point\n" +
    "2. Parent-Child Relationship: Each node has one parent (except the root)\n" +
    "3. Levels: Nodes organized into levels starting from the root\n\n" +
    "Example:\n" +
    "        Root\n" +
    "       /    \\\n" +
    "     Child1  Child2\n" +
    "     /   \\      |\n" +
    "Child1.1 Child1.2 Child2.1"
  );
}

void displayText(String msg) {
  fill(255);
  noStroke();
  rect(0, height - 150, width, 150); // Background for text
  fill(0);
  textSize(12);
  textAlign(LEFT, TOP);
  text(msg, 10, height - 140, width - 20, 140);
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
      drawTree();
    } else if (frameCount == 200) {
      drawRootedTree();
    } else if (frameCount > 400) {
      recording = false;
      gifMaker.finish();
      println("GIF saved!");
    }
    
    gifMaker.addFrame();
    frameCount++;
  }
}
