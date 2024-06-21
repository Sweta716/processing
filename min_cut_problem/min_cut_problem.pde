import gifAnimation.*;
import java.util.*;

PFont font;
GifMaker gifMaker;
PVector[] nodes;
int[][] capacity;
int[][] flow;
int[] parent;
boolean[] visited;
int source = 0;
int sink = 5;
boolean minCutFound = false;
boolean pathHighlighted = false;

// Colors from the provided palette
color colorDividing = color(248, 200, 164); // Light orange
color colorSorting = color(247, 157, 100);  // Orange
color colorMerging = color(239, 107, 72);   // Red-orange

void setup() {
  size(1200, 800);
  font = createFont("Lato", 16);
  textFont(font);
  initializeGraph();
  frameRate(1); // Adjust the frame rate as needed

  // Setup GifMaker
  gifMaker = new GifMaker(this, "min_cut_visualization.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
  gifMaker.setQuality(10);
  gifMaker.setDelay(1000); // Set delay time between frames in milliseconds
}

void draw() {
  background(255); // White background
  fill(0);
  textAlign(CENTER, TOP);
  text("Minimum Cut Problem: Ford-Fulkerson Algorithm", width / 2, 20);

  drawGraph();
  if (!minCutFound) {
    if (!pathHighlighted) {
      highlightPath();
      pathHighlighted = true;
    } else {
      findMinCut();
      pathHighlighted = false;
    }
  } else {
    fill(0);
    textAlign(CENTER, TOP);
    text("Minimum Cut Found", width / 2, height - 50);
  }

  // Add the current frame to the GIF
  gifMaker.addFrame();
}

void initializeGraph() {
  nodes = new PVector[6];
  nodes[0] = new PVector(100, 400); // Source
  nodes[1] = new PVector(300, 200);
  nodes[2] = new PVector(300, 600);
  nodes[3] = new PVector(600, 200);
  nodes[4] = new PVector(600, 600);
  nodes[5] = new PVector(900, 400); // Sink

  capacity = new int[][] {
    {0, 16, 13, 0, 0, 0},
    {0, 0, 10, 12, 0, 0},
    {0, 4, 0, 0, 14, 0},
    {0, 0, 9, 0, 0, 20},
    {0, 0, 0, 7, 0, 4},
    {0, 0, 0, 0, 0, 0}
  };

  flow = new int[6][6];
  parent = new int[6];
  visited = new boolean[6];
}

void drawGraph() {
  strokeWeight(2);
  for (int i = 0; i < capacity.length; i++) {
    for (int j = 0; j < capacity[i].length; j++) {
      if (capacity[i][j] > 0) {
        drawArrow(nodes[i].x, nodes[i].y, nodes[j].x, nodes[j].y);
        fill(0);
        textAlign(CENTER, CENTER);
        text(flow[i][j] + " / " + capacity[i][j], (nodes[i].x + nodes[j].x) / 2, (nodes[i].y + nodes[j].y) / 2 - 20);
      }
    }
  }
  for (int i = 0; i < nodes.length; i++) {
    if (i == source) {
      fill(0, 255, 0); // Green for source
    } else if (i == sink) {
      fill(255, 0, 0); // Red for sink
    } else {
      fill(200, 200, 255); // Blue for other nodes
    }
    ellipse(nodes[i].x, nodes[i].y, 50, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text(char('A' + i), nodes[i].x, nodes[i].y);
  }
}

void drawArrow(float x1, float y1, float x2, float y2) {
  stroke(0, 0, 255); // Blue color for arrows
  strokeWeight(2);
  line(x1, y1, x2, y2);
  float angle = atan2(y2 - y1, x2 - x1);
  float arrowSize = 8;
  line(x2, y2, x2 - arrowSize * cos(angle + PI / 6), y2 - arrowSize * sin(angle + PI / 6));
  line(x2, y2, x2 - arrowSize * cos(angle - PI / 6), y2 - arrowSize * sin(angle - PI / 6));
}

void highlightPath() {
  if (bfs()) {
    for (int v = sink; v != source; v = parent[v]) {
      int u = parent[v];
      stroke(colorDividing); // Highlight in light orange
      strokeWeight(4);
      line(nodes[u].x, nodes[u].y, nodes[v].x, nodes[v].y);
      fill(colorDividing); // Light orange text for highlighted path
      text(flow[u][v] + " / " + capacity[u][v], (nodes[u].x + nodes[v].x) / 2, (nodes[u].y + nodes[v].y) / 2 - 20);
    }
    fill(0);
    textAlign(CENTER, BOTTOM);
    text("Augmenting Path Found", width / 2, height - 100);
  } else {
    minCutFound = true;
    gifMaker.finish();
    noLoop();
  }
}

void findMinCut() {
  if (bfs()) {
    // Find the maximum flow through the path found by BFS
    int pathFlow = Integer.MAX_VALUE;
    for (int v = sink; v != source; v = parent[v]) {
      int u = parent[v];
      pathFlow = min(pathFlow, capacity[u][v] - flow[u][v]);
    }

    // Update residual capacities of the edges and reverse edges along the path
    for (int v = sink; v != source; v = parent[v]) {
      int u = parent[v];
      flow[u][v] += pathFlow;
      flow[v][u] -= pathFlow;
    }

    fill(0);
    textAlign(CENTER, BOTTOM);
    text("Flow updated by " + pathFlow, width / 2, height - 100);
  } else {
    minCutFound = true;
    gifMaker.finish();
    noLoop();
  }
}

boolean bfs() {
  Arrays.fill(visited, false);
  LinkedList<Integer> queue = new LinkedList<Integer>();
  queue.add(source);
  visited[source] = true;
  parent[source] = -1;

  while (queue.size() != 0) {
    int u = queue.poll();

    for (int v = 0; v < nodes.length; v++) {
      if (!visited[v] && capacity[u][v] - flow[u][v] > 0) {
        if (v == sink) {
          parent[v] = u;
          return true;
        }
        queue.add(v);
        parent[v] = u;
        visited[v] = true;
      }
    }
  }
  return false;
}
