import gifAnimation.*;
GifMaker gifExport;

int totalFrames = 240;
int currentFrame = 0;
PFont font;
color[] palette;

void setup() {
  size(800, 800);
  background(255);
  font = createFont("Arial", 16, true);
  textFont(font);
  
  // Define the color palette
  palette = new color[7];
  palette[0] = color(62, 105, 129);  // Blue
  palette[1] = color(26, 43, 60);    // Navy
  palette[2] = color(21, 59, 51);    // Green
  palette[3] = color(247, 190, 70);  // Yellow
  palette[4] = color(214, 171, 104); // Tan
  palette[5] = color(233, 102, 52);  // Orange
  palette[6] = color(186, 76, 37);   // Red
  
  gifExport = new GifMaker(this, "optimal_substructure_explanation_enhanced.gif");
  gifExport.setRepeat(0); // repeat indefinitely
  gifExport.setQuality(10); // set the quality
  gifExport.setDelay(100); // set the delay time in milliseconds
}

void draw() {
  background(255);
  
  fill(0);
  textAlign(CENTER);
  text("Expanding from a small path to a larger path while maintaining optimal substructure", width / 2, height / 10);
  textAlign(LEFT);
  
  if (currentFrame > 20 && currentFrame <= 60) {
    text("Initial small path (12 nodes)", 50, 150);
  }
  if (currentFrame > 60 && currentFrame <= 120) {
    text("Expanding to 100 nodes", 50, 150);
  }
  if (currentFrame > 120 && currentFrame <= 180) {
    text("Expanding to 1000 nodes", 50, 150);
  }
  if (currentFrame > 180 && currentFrame <= 240) {
    text("Expanding to 10000 nodes", 50, 150);
  }
  
  drawPath(currentFrame);
  
  gifExport.addFrame();
  
  currentFrame++;
  if (currentFrame == totalFrames) {
    gifExport.finish();
    println("GIF saved successfully.");
    exit();
  }
}

void drawPath(int frame) {
  int offsetX = 50;
  int offsetY = 250;
  int nodeSize = 15;
  int gap = 25;
  int initialNodes = 12;
  
  if (frame <= 60) {
    // Draw initial small path (12 nodes)
    fill(palette[0]);
    stroke(palette[0]);
    for (int i = 0; i < initialNodes; i++) {
      ellipse(offsetX + i * gap, offsetY, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + (i - 1) * gap, offsetY, offsetX + i * gap, offsetY);
      }
    }
  } else if (frame <= 120) {
    // Expand to 100 nodes
    fill(palette[1]);
    stroke(palette[1]);
    for (int i = 0; i < 100; i++) {
      ellipse(offsetX + (i % 10) * gap, offsetY + (i / 10) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 10) * gap, offsetY + ((i - 1) / 10) * gap, offsetX + (i % 10) * gap, offsetY + (i / 10) * gap);
      }
    }
  } else if (frame <= 180) {
    // Expand to 1000 nodes
    fill(palette[2]);
    stroke(palette[2]);
    for (int i = 0; i < 1000; i++) {
      ellipse(offsetX + (i % 40) * gap, offsetY + (i / 40) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 40) * gap, offsetY + ((i - 1) / 40) * gap, offsetX + (i % 40) * gap, offsetY + (i / 40) * gap);
      }
    }
  } else {
    // Expand to 10000 nodes
    fill(palette[3]);
    stroke(palette[3]);
    for (int i = 0; i < 10000; i++) {
      ellipse(offsetX + (i % 100) * gap, offsetY + (i / 100) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 100) * gap, offsetY + ((i - 1) / 100) * gap, offsetX + (i % 100) * gap, offsetY + (i / 100) * gap);
      }
    }
  }
  
  // Highlight initial small path
  if (frame > 60) {
    stroke(palette[4]);
    for (int i = 0; i < initialNodes - 1; i++) {
      line(offsetX + i * gap, offsetY, offsetX + (i + 1) * gap, offsetY);
    }
    stroke(0);
  }
}
