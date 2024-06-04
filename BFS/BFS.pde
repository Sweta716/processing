import gifAnimation.*;

GifMaker gifExport;

color standardColor = color(26, 69, 56); // Green 005
color highlightColor = color(255, 184, 56); // Yellow 004
PFont lato;

int[][] graph = {
  {1, 2},
  {0, 3, 4},
  {0, 5, 6},
  {1},
  {1},
  {2},
  {2}
};
boolean[] visited = new boolean[graph.length];
int[] queue = new int[graph.length];
int queueStart = 0;
int queueEnd = 0;
int currentNode = -1;

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  gifExport = new GifMaker(this, "bfs_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed

  // Initialize BFS
  queue[queueEnd++] = 0; // Start BFS from node 0
  visited[0] = true;
}

void draw() {
  background(255);
  drawGraph();

  if (frameCount % 60 == 0) {
    bfsStep();
  }

  gifExport.addFrame(); // Add the current frame to the GIF
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
  }
}

void drawGraph() {
  float[][] positions = {
    {960, 200},
    {660, 400},
    {1260, 400},
    {560, 600},
    {760, 600},
    {1160, 600},
    {1360, 600}
  };

  for (int i = 0; i < graph.length; i++) {
    for (int j : graph[i]) {
      stroke(0);
      line(positions[i][0], positions[i][1], positions[j][0], positions[j][1]);
    }
  }

  for (int i = 0; i < graph.length; i++) {
    if (i == currentNode) fill(highlightColor);
    else if (visited[i]) fill(standardColor);
    else fill(200);
    ellipse(positions[i][0], positions[i][1], 100, 100);
    fill(0);
    text(i, positions[i][0], positions[i][1]);
  }
}

void bfsStep() {
  if (queueStart < queueEnd) {
    currentNode = queue[queueStart++];
    for (int neighbor : graph[currentNode]) {
      if (!visited[neighbor]) {
        queue[queueEnd++] = neighbor;
        visited[neighbor] = true;
      }
    }
  } else {
    currentNode = -1; // BFS is done
  }
}

boolean done() {
  return currentNode == -1;
}

// Restart the animation when mouse is pressed
void mousePressed() {
  queueStart = 0;
  queueEnd = 0;
  currentNode = -1;
  visited = new boolean[graph.length];
  queue[queueEnd++] = 0; // Start BFS from node 0
  visited[0] = true;
  gifExport = new GifMaker(this, "bfs_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}
