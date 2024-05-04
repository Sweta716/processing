import java.util.Stack;
import java.util.*;
// Graph representation using an adjacency list
HashMap<Integer, ArrayList<Integer>> graph;
// To track visited nodes for both searches
boolean[] visitedDFS, visitedBFS;
// Queue for BFS
ArrayList<Integer> queue = new ArrayList<Integer>();
// Dimensions for drawing
int nodeSize = 20;
int[] nodeX, nodeY; // Positions of nodes

void setup() {
  size(800, 400);
  setupGraph();
  visitedDFS = new boolean[graph.size()];
  visitedBFS = new boolean[graph.size()];
  queue.add(0); // Start BFS from node 0
  frameRate(1); // Slows down the frame rate so we can observe the traversal
}

void draw() {
  background(255);
  drawGraph();
  
  // Perform DFS and BFS
  if (!allVisited(visitedDFS)) {
    dfs(0);
  }
  if (!queue.isEmpty()) {
    bfs();
  }
}

void dfs(int node) {
  if (visitedDFS[node]) return;
  visitedDFS[node] = true;
  highlightNode(node, color(255, 0, 0), nodeY[node]); // Red for DFS
  
  for (int neighbor : graph.get(node)) {
    if (!visitedDFS[neighbor]) {
      dfs(neighbor);
    }
  }
}

void bfs() {
  int node = queue.remove(0);
  if (visitedBFS[node]) return;
  visitedBFS[node] = true;
  highlightNode(node, color(0, 0, 255), nodeY[node]); // Blue for BFS
  
  for (int neighbor : graph.get(node)) {
    if (!visitedBFS[neighbor] && !queue.contains(neighbor)) {
      queue.add(neighbor);
    }
  }
}

void setupGraph() {
  graph = new HashMap<Integer, ArrayList<Integer>>();
  // Example graph initialization
  graph.put(0, new ArrayList<Integer>(Arrays.asList(1, 2)));
  graph.put(1, new ArrayList<Integer>(Arrays.asList(0, 3)));
  graph.put(2, new ArrayList<Integer>(Arrays.asList(0, 3)));
  graph.put(3, new ArrayList<Integer>(Arrays.asList(1, 2)));
  nodeX = new int[]{200, 300, 200, 300};
  nodeY = new int[]{50, 150, 250, 350};
}

void drawGraph() {
  for (int i = 0; i < graph.size(); i++) {
    fill(200);
    ellipse(nodeX[i], nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(150);
      line(nodeX[i], nodeY[i], nodeX[neighbor], nodeY[neighbor]);
    }
  }
}

void highlightNode(int node, color col, int posY) {
  fill(col);
  ellipse(nodeX[node], posY, nodeSize, nodeSize);
}

boolean allVisited(boolean[] visited) {
  for (boolean v : visited) {
    if (!v) return false;
  }
  return true;
}
