import gifAnimation.*;
import java.util.*;

// Graph representation using an adjacency list
HashMap<Integer, ArrayList<Integer>> graph;
// To track visited nodes for both searches
boolean[] visitedDFS, visitedBFS;
// Stack for DFS and queue for BFS
Stack<Integer> stack = new Stack<>();
Queue<Integer> queue = new LinkedList<>();
// Dimensions for drawing
int nodeSize = 30;
int[] nodeX, nodeY; // Positions of nodes

GifMaker gifExport;

void setup() {
  size(1000, 400); // Adjust size to accommodate both DFS and BFS
  setupGraph();
  visitedDFS = new boolean[graph.size()];
  visitedBFS = new boolean[graph.size()];
  stack.push(0); // Start DFS from node 0
  queue.add(0);  // Start BFS from node 0
  frameRate(1); // Slows down the frame rate so we can observe the traversal
  
  // Setup GifMaker
  gifExport = new GifMaker(this, "dfs_bfs_comparison.gif");
  gifExport.setRepeat(0); // Repeat indefinitely
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}

void draw() {
  background(255);
  drawGraph();

  // Perform DFS and BFS
  if (!stack.isEmpty()) {
    dfs();
  }
  if (!queue.isEmpty()) {
    bfs();
  }

  // Add the current frame to the GIF
  gifExport.addFrame();
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
    noLoop(); // Stops draw() from continuously executing
  }
}

void dfs() {
  int node = stack.pop();
  if (visitedDFS[node]) return;
  visitedDFS[node] = true;
  highlightNode(node, color(255, 0, 0), nodeX[node] - 400, nodeY[node]); // Red for DFS, adjust position for separation
  
  for (int neighbor : graph.get(node)) {
    if (!visitedDFS[neighbor]) {
      delay(1000); // Delay to visualize the process
      stack.push(neighbor);
    }
  }
}

void bfs() {
  int node = queue.poll();
  if (visitedBFS[node]) return;
  visitedBFS[node] = true;
  highlightNode(node, color(0, 0, 255), nodeX[node] + 400, nodeY[node]); // Blue for BFS, adjust position for separation
  
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
  nodeX = new int[]{300, 400, 300, 400}; // Adjusted positions
  nodeY = new int[]{50, 150, 250, 350};
}

void drawGraph() {
  for (int i = 0; i < graph.size(); i++) {
    fill(200);
    // Draw DFS graph
    ellipse(nodeX[i] - 400, nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(150);
      line(nodeX[i] - 400, nodeY[i], nodeX[neighbor] - 400, nodeY[neighbor]);
    }
    // Draw BFS graph
    ellipse(nodeX[i] + 400, nodeY[i], nodeSize, nodeSize);
    for (int neighbor : graph.get(i)) {
      stroke(150);
      line(nodeX[i] + 400, nodeY[i], nodeX[neighbor] + 400, nodeY[neighbor]);
    }
  }
}

void highlightNode(int node, color col, int posX, int posY) {
  fill(col);
  ellipse(posX, posY, nodeSize, nodeSize);
}

boolean allVisited(boolean[] visited) {
  for (boolean v : visited) {
    if (!v) return false;
  }
  return true;
}

boolean done() {
  return allVisited(visitedDFS) && allVisited(visitedBFS);
}
