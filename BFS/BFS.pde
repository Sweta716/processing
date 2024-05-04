import java.util.Queue;
import java.util.LinkedList;

// Define a class to represent a graph node
class GraphNode {
  int value;
  float x, y;
  ArrayList<GraphNode> neighbors;
  boolean visited;

  GraphNode(int val, float xpos, float ypos) {
    value = val;
    x = xpos;
    y = ypos;
    neighbors = new ArrayList<GraphNode>();
    visited = false;
  }

  void addNeighbor(GraphNode neighbor) {
    neighbors.add(neighbor);
  }

  void display() {
    // Draw the node
    stroke(0);
    fill(255);
    ellipse(x, y, 30, 30);

    // Display the node value
    fill(0);
    textAlign(CENTER, CENTER);
    text(value, x, y);
  }
}

// Define a class to represent a graph
class Graph {
  ArrayList<GraphNode> nodes;
  Queue<GraphNode> queue;

  Graph() {
    nodes = new ArrayList<GraphNode>();
    queue = new LinkedList<GraphNode>();
  }

  void addNode(GraphNode node) {
    nodes.add(node);
  }

  // Perform BFS traversal starting from a given node
  void BFS(GraphNode start) {
    // Enqueue the start node
    start.visited = true;
    queue.add(start);

    while (!queue.isEmpty()) {
      // Dequeue a node from the queue
      GraphNode current = queue.poll();
      
      // Display the current node as visited
      current.display();
      
      // Visit all neighbors of the dequeued node
      for (GraphNode neighbor : current.neighbors) {
        if (!neighbor.visited) {
          neighbor.visited = true;
          queue.add(neighbor);
          
          // Draw edge as moving line
          float startX = current.x;
          float startY = current.y;
          float targetX = neighbor.x;
          float targetY = neighbor.y;
          float animFactor = 0;
          while (animFactor < 1) {
            float lineX = lerp(startX, targetX, animFactor);
            float lineY = lerp(startY, targetY, animFactor);
            stroke(lerpColor(color(0, 255, 0), color(255), animFactor));
            strokeWeight(2);
            line(startX, startY, lineX, lineY);
            animFactor += 0.05; // Speed of animation
            delay(50); // Delay between drawing frames
          }
          // Draw final edge
          stroke(0, 255, 0);
          strokeWeight(2);
          line(startX, startY, targetX, targetY);
        }
      }
    }
  }
}

// Create a new graph
Graph graph = new Graph();

void setup() {
  size(400, 400);
  background(0); // Start with black background
  
  // Create graph nodes
  GraphNode node0 = new GraphNode(0, 50, 50);
  GraphNode node1 = new GraphNode(1, 150, 50);
  GraphNode node2 = new GraphNode(2, 250, 50);
  GraphNode node3 = new GraphNode(3, 150, 150);
  GraphNode node4 = new GraphNode(4, 250, 150);

  // Connect nodes
  node0.addNeighbor(node1);
  node0.addNeighbor(node2);
  node1.addNeighbor(node3);
  node2.addNeighbor(node4);
  node3.addNeighbor(node4);

  // Add nodes to the graph
  graph.addNode(node0);
  graph.addNode(node1);
  graph.addNode(node2);
  graph.addNode(node3);
  graph.addNode(node4);

  // Perform BFS traversal starting from node 0
  graph.BFS(node0);
}
