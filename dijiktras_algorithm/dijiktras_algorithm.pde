import gifAnimation.*;
import java.util.*;

GifMaker gifExport;
PFont lato;
int[][] graph = {
  {0, 10, 0, 0, 0, 0},
  {10, 0, 5, 15, 0, 0},
  {0, 5, 0, 10, 20, 0},
  {0, 15, 10, 0, 25, 0},
  {0, 0, 20, 25, 0, 5},
  {0, 0, 0, 0, 5, 0}
};
int[] dist;
boolean[] sptSet;
int[] parent;
int V = graph.length;
int src = 0;
int step = 0;
int maxSteps = 20;
PVector[] positions;

void setup() {
  size(1920, 1080);
  lato = createFont("Lato-Regular", 32);
  textFont(lato);
  dist = new int[V];
  sptSet = new boolean[V];
  parent = new int[V];
  positions = new PVector[V];
  positions[0] = new PVector(300, 200);  
  positions[1] = new PVector(500, 200);
  positions[2] = new PVector(700, 300);
  positions[3] = new PVector(900, 400);
  positions[4] = new PVector(700, 500);
  positions[5] = new PVector(500, 600);  
  for (int i = 0; i < V; i++) {
    dist[i] = Integer.MAX_VALUE;
    sptSet[i] = false;
    parent[i] = -1;
  }
  dist[src] = 0;
  frameRate(1);
  
  // Setup GifMaker
  gifExport = new GifMaker(this, "dijkstra_animation.gif");
  gifExport.setRepeat(0); // Repeat indefinitely
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}

void draw() {
  background(255);
  fill(0);
  textAlign(CENTER);
  textSize(32);
  text("Visualizing Dijkstra's Algorithm", width / 2, 40);
  textSize(24);
  textAlign(LEFT);
  for (int i = 0; i < V; i++) {
    text("Node " + i + ": " + (dist[i] == Integer.MAX_VALUE ? "∞" : dist[i]), 50, 100 + i * 30);
  }
  visualizeGraph();
  if (step < maxSteps) {
    dijkstraStep();
    step++;
  } else {
    noLoop();
  }
  
  // Add the current frame to the GIF
  gifExport.addFrame();
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
  }
}

void visualizeGraph() {
  for (int i = 0; i < V; i++) {
    for (int j = 0; j < V; j++) {
      if (graph[i][j] != 0) {
        stroke(100);
        line(positions[i].x, positions[i].y, positions[j].x, positions[j].y);
        fill(100);
        textSize(18);
        text(graph[i][j], (positions[i].x + positions[j].x) / 2, (positions[i].y + positions[j].y) / 2);
      }
    }
  }
  for (int i = 0; i < V; i++) {
    fill(sptSet[i] ? color(255, 165, 0) : color(229, 229, 229));  // Current node color for visited
    ellipse(positions[i].x, positions[i].y, 40, 40);
    fill(0);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(i, positions[i].x, positions[i].y);
  }
}

void dijkstraStep() {
  int u = minDistance();
  if (u == -1) return;
  sptSet[u] = true;
  for (int v = 0; v < V; v++) {
    if (!sptSet[v] && graph[u][v] != 0 && dist[u] != Integer.MAX_VALUE && dist[u] + graph[u][v] < dist[v]) {
      dist[v] = dist[u] + graph[u][v];
      parent[v] = u;
    }
  }
}

int minDistance() {
  int min = Integer.MAX_VALUE, min_index = -1;
  for (int v = 0; v < V; v++) {
    if (!sptSet[v] && dist[v] <= min) {
      min = dist[v];
      min_index = v;
    }
  }
  return min_index;
}

boolean done() {
  for (boolean v : sptSet) {
    if (!v) return false;
  }
  return true;
}
