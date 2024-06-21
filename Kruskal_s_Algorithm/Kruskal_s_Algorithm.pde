import gifAnimation.*;
import java.util.*;

class Edge implements Comparable<Edge> {
  int src, dest;
  float weight;
  color col;

  Edge(int src, int dest, float weight, color col) {
    this.src = src;
    this.dest = dest;
    this.weight = weight;
    this.col = col;
  }

  public int compareTo(Edge compareEdge) {
    return Float.compare(this.weight, compareEdge.weight);
  }
}

class Subset {
  int parent, rank;
}

ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<Edge> mstEdges = new ArrayList<Edge>();
int[] parent;
int[] rank;
int V = 6; // Number of vertices
int edgeIndex = 0;
GifMaker gifExport;

void setup() {
  size(1920, 1080);
  edges.add(new Edge(0, 1, 4, color(255, 0, 0)));
  edges.add(new Edge(0, 2, 4, color(0, 255, 0)));
  edges.add(new Edge(1, 2, 2, color(0, 0, 255)));
  edges.add(new Edge(1, 3, 6, color(255, 255, 0)));
  edges.add(new Edge(2, 3, 8, color(255, 0, 255)));
  edges.add(new Edge(2, 4, 10, color(0, 255, 255)));
  edges.add(new Edge(3, 4, 8, color(255, 127, 0)));
  edges.add(new Edge(3, 5, 10, color(127, 0, 255)));
  edges.add(new Edge(4, 5, 4, color(127, 255, 0)));
  
  Collections.sort(edges); // Sort edges by weight
  parent = new int[V];
  rank = new int[V];
  
  for (int i = 0; i < V; ++i) {
    parent[i] = i;
    rank[i] = 0;
  }

  frameRate(1);

  gifExport = new GifMaker(this, "kruskal_visualization.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(1000); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Visualizing Kruskal's Algorithm", 50, 40);
  
  textSize(20);
  for (int i = 0; i < edges.size(); i++) {
    Edge edge = edges.get(i);
    fill(edge.col);
    text("Edge " + (i + 1) + ": (" + edge.src + ", " + edge.dest + ") - Weight = " + edge.weight, 50, 80 + i * 30);
  }

  visualizeGraph();
  if (edgeIndex < edges.size()) {
    addEdgeToMST();
    edgeIndex++;
  } else {
    gifExport.finish();
    noLoop();
  }

  gifExport.addFrame(); // Add the current frame to the GIF
}

void visualizeGraph() {
  PVector[] positions = new PVector[V];
  positions[0] = new PVector(300, 200);
  positions[1] = new PVector(500, 200);
  positions[2] = new PVector(700, 300);
  positions[3] = new PVector(900, 400);
  positions[4] = new PVector(700, 500);
  positions[5] = new PVector(500, 600);

  for (Edge edge : edges) {
    stroke(edge.col);
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }
  
  for (Edge edge : mstEdges) {
    stroke(0);
    strokeWeight(3);
    line(positions[edge.src].x, positions[edge.src].y, positions[edge.dest].x, positions[edge.dest].y);
  }
  
  for (int i = 0; i < V; i++) {
    fill(200);
    ellipse(positions[i].x, positions[i].y, 40, 40);
    fill(0);
    textAlign(CENTER, CENTER);
    text(i, positions[i].x, positions[i].y);
  }
}

void addEdgeToMST() {
  Edge nextEdge = edges.get(edgeIndex);

  int x = find(nextEdge.src);
  int y = find(nextEdge.dest);

  if (x != y) {
    mstEdges.add(nextEdge);
    union(x, y);
  }
}

int find(int i) {
  if (parent[i] != i) {
    parent[i] = find(parent[i]);
  }
  return parent[i];
}

void union(int x, int y) {
  int rootX = find(x);
  int rootY = find(y);

  if (rank[rootX] < rank[rootY]) {
    parent[rootX] = rootY;
  } else if (rank[rootX] > rank[rootY]) {
    parent[rootY] = rootX;
  } else {
    parent[rootY] = rootX;
    rank[rootX]++;
  }
}
