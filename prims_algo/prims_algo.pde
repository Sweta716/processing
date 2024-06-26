import gifAnimation.*;

class Edge {
  int src, dest;
  float weight;
  color col;

  Edge(int src, int dest, float weight, color col) {
    this.src = src;
    this.dest = dest;
    this.weight = weight;
    this.col = col;
  }
}

ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<Edge> mstEdges = new ArrayList<Edge>();
boolean[] inMST;
int V = 6; // Number of vertices
PVector[] positions;
GifMaker gifExport;

void setup() {
  size(1920, 1080);
  edges.add(new Edge(0, 1, 4, color(167, 199, 231))); // light blue
  edges.add(new Edge(0, 2, 4, color(167, 199, 231))); // light blue
  edges.add(new Edge(1, 2, 2, color(167, 199, 231))); // light blue
  edges.add(new Edge(1, 3, 6, color(167, 199, 231))); // light blue
  edges.add(new Edge(2, 3, 8, color(167, 199, 231))); // light blue
  edges.add(new Edge(2, 4, 10, color(167, 199, 231))); // light blue
  edges.add(new Edge(3, 4, 8, color(167, 199, 231))); // light blue
  edges.add(new Edge(3, 5, 10, color(167, 199, 231))); // light blue
  edges.add(new Edge(4, 5, 4, color(167, 199, 231))); // light blue

  inMST = new boolean[V];
  positions = new PVector[V];
  positions[0] = new PVector(300, 200);
  positions[1] = new PVector(500, 200);
  positions[2] = new PVector(700, 300);
  positions[3] = new PVector(900, 400);
  positions[4] = new PVector(700, 500);
  positions[5] = new PVector(500, 600);

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
  textSize(24);
  textAlign(LEFT);
  text("Visualizing Prim's Algorithm", 50, 40);

  textSize(20);
  for (int i = 0; i < edges.size(); i++) {
    Edge edge = edges.get(i);
    fill(edge.col);
    text("Edge " + (i + 1) + ": (" + edge.src + ", " + edge.dest + ") - Weight = " + edge.weight, 50, 80 + i * 30);
  }

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
  for (Edge edge : edges) {
    stroke(edge.col);
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }

  for (Edge edge : mstEdges) {
    stroke(color(99, 177, 142)); // green for MST edges
    strokeWeight(3);
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }

  for (int i = 0; i < V; i++) {
    fill(inMST[i] ? color(247, 157, 100) : color(248, 200, 164)); // orange for nodes in MST, light orange for nodes not in MST
    ellipse(positions[i].x, positions[i].y, 40, 40);
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
