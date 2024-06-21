import gifAnimation.*;

class Edge {
  int src, dest;
  float weight;

  Edge(int src, int dest, float weight) {
    this.src = src;
    this.dest = dest;
    this.weight = weight;
  }
}

ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<Edge> mstEdges = new ArrayList<Edge>();
boolean[] inMST;
int V = 20; // Number of vertices
PVector[] positions;
GifMaker gifExport;

void setup() {
  size(800, 800);
  positions = new PVector[V];
  for (int i = 0; i < V; i++) {
    positions[i] = new PVector(random(width), random(height));
  }

  for (int i = 0; i < V; i++) {
    for (int j = i + 1; j < V; j++) {
      float weight = dist(positions[i].x, positions[i].y, positions[j].x, positions[j].y);
      edges.add(new Edge(i, j, weight));
    }
  }

  inMST = new boolean[V];
  inMST[0] = true; // Start with the first vertex
  frameRate(1);
  
  // Setup GifMaker
  gifExport = new GifMaker(this, "Prim_Algorithm.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text("Visualizing Prim's Algorithm", 20, 30);

  visualizeGraph();
  if (mstEdges.size() < V - 1) {
    addEdgeToMST();
    gifExport.addFrame(); // Add the current frame to the GIF
    saveFrame("frames/frame-######.png");
  } else {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }
}

void visualizeGraph() {
  strokeWeight(1);
  for (Edge edge : edges) {
    stroke(167, 199, 231); // Light blue for edges
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }

  strokeWeight(3);
  for (Edge edge : mstEdges) {
    stroke(99, 177, 142); // Green for MST edges
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }

  for (int i = 0; i < V; i++) {
    fill(inMST[i] ? color(247, 157, 100) : color(248, 200, 164)); // Orange for nodes in MST, light orange for nodes not in MST
    stroke(0);
    ellipse(positions[i].x, positions[i].y, 20, 20);
    fill(0);
    textAlign(CENTER, CENTER);
    text(i, positions[i].x, positions[i].y);
  }
}

void addEdgeToMST() {
  Edge nextEdge = null;
  float minWeight = Float.MAX_VALUE;

  for (Edge edge : edges) {
    if (inMST[edge.src] && !inMST[edge.dest] && edge.weight < minWeight) {
      nextEdge = edge;
      minWeight = edge.weight;
    } else if (inMST[edge.dest] && !inMST[edge.src] && edge.weight < minWeight) {
      nextEdge = edge;
      minWeight = edge.weight;
    }
  }

  if (nextEdge != null) {
    mstEdges.add(nextEdge);
    inMST[nextEdge.src] = true;
    inMST[nextEdge.dest] = true;
  }
}
