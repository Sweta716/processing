import gifAnimation.*;

PFont font;
GifMaker gifMaker;
PVector[] nodes;
int[][] edges;
boolean[] vertexCover;
boolean reductionComplete = false;
int step = 0;

void setup() {
  size(800, 600);
  font = createFont("Lato", 16);
  textFont(font);
  initializeGraph();
  frameRate(1); // Adjust the frame rate as needed
  
  // Setup GifMaker
  gifMaker = new GifMaker(this, "Reduction-VertexCover-IndependentSet.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
}

void draw() {
  background(255); // White background
  fill(0);
  textAlign(CENTER, TOP);
  text("Reduction: Vertex Cover to Independent Set", width / 2, 20);
  
  drawGraph();
  if (!reductionComplete) {
    performReductionStep();
  }
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
}

void initializeGraph() {
  nodes = new PVector[6];
  nodes[0] = new PVector(200, 200);
  nodes[1] = new PVector(400, 200);
  nodes[2] = new PVector(600, 200);
  nodes[3] = new PVector(200, 400);
  nodes[4] = new PVector(400, 400);
  nodes[5] = new PVector(600, 400);
  
  edges = new int[][] {
    {0, 1}, {1, 2}, {0, 3}, {1, 4}, {2, 5}, {3, 4}, {4, 5}
  };
  
  vertexCover = new boolean[nodes.length];
  vertexCover[1] = true; // Example of vertex cover
  vertexCover[4] = true;
}

void drawGraph() {
  strokeWeight(2);
  for (int[] edge : edges) {
    int from = edge[0];
    int to = edge[1];
    line(nodes[from].x, nodes[from].y, nodes[to].x, nodes[to].y);
  }
  for (int i = 0; i < nodes.length; i++) {
    if (vertexCover[i]) {
      fill(255, 0, 0); // Red for vertex cover
    } else {
      fill(200, 200, 255); // Blue for others
    }
    ellipse(nodes[i].x, nodes[i].y, 50, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text(char('A' + i), nodes[i].x, nodes[i].y);
  }
}

void performReductionStep() {
  if (step == 0) {
    // Highlight vertices in vertex cover
    fill(0);
    textAlign(CENTER, TOP);
    text("Vertices in Vertex Cover", width / 2, height - 50);
  } else if (step == 1) {
    // Convert vertex cover to independent set
    for (int i = 0; i < vertexCover.length; i++) {
      vertexCover[i] = !vertexCover[i];
    }
    fill(0);
    textAlign(CENTER, TOP);
    text("Convert to Independent Set", width / 2, height - 50);
  } else {
    reductionComplete = true;
    fill(0);
    textAlign(CENTER, TOP);
    text("Independent Set", width / 2, height - 50);
    gifMaker.finish();
    noLoop();
  }
  step++;
}
