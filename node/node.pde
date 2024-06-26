import gifAnimation.*;
GifMaker gifExport;

int totalFrames = 200;
int currentFrame = 0;
PFont font;

void setup() {
  size(800, 600);
  background(255);
  font = createFont("Arial", 16, true);
  textFont(font);
  
  gifExport = new GifMaker(this, "optimal_substructure.gif");
  gifExport.setRepeat(0); // repeat indefinitely
  gifExport.setQuality(10); // set the quality
  gifExport.setDelay(100); // set the delay time in milliseconds
}

void draw() {
  background(255);
  
  fill(0);
  textAlign(CENTER);
  text("Expanding from a small path to a larger path while maintaining optimal substructure", width/2, height/4);
  textAlign(LEFT);
  if (currentFrame > 40 && currentFrame <= 80) {
    text("Initial small path (12 nodes)", 50, 100);
  }
  if (currentFrame > 80 && currentFrame <= 120) {
    text("Expanding to 100 nodes", 50, 100);
  }
  if (currentFrame > 120 && currentFrame <= 160) {
    text("Expanding to 1000 nodes", 50, 100);
  }
  if (currentFrame > 160 && currentFrame <= 200) {
    text("Expanding to 10000 nodes", 50, 100);
  }
  
  drawPath(currentFrame);
  
  gifExport.addFrame();
  
  currentFrame++;
  if (currentFrame == totalFrames) {
    gifExport.finish();
    exit();
  }
}

void drawPath(int frame) {
  int offsetX = 100;
  int offsetY = 300;
  int nodeSize = 20;
  int gap = 40;
  
  fill(0);
  stroke(0);
  
  if (frame <= 80) {
    for (int i = 0; i < 12; i++) {
      ellipse(offsetX + i * gap, offsetY, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + (i - 1) * gap, offsetY, offsetX + i * gap, offsetY);
      }
    }
  }
  else if (frame <= 120) {
    for (int i = 0; i < 100; i++) {
      ellipse(offsetX + (i % 25) * gap, offsetY + (i / 25) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 25) * gap, offsetY + ((i - 1) / 25) * gap, offsetX + (i % 25) * gap, offsetY + (i / 25) * gap);
      }
    }
  }
  else if (frame <= 160) {
    for (int i = 0; i < 1000; i++) {
      ellipse(offsetX + (i % 50) * gap, offsetY + (i / 50) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 50) * gap, offsetY + ((i - 1) / 50) * gap, offsetX + (i % 50) * gap, offsetY + (i / 50) * gap);
      }
    }
  }
  else {
    for (int i = 0; i < 10000; i++) {
      ellipse(offsetX + (i % 100) * gap, offsetY + (i / 100) * gap, nodeSize, nodeSize);
      if (i > 0) {
        line(offsetX + ((i - 1) % 100) * gap, offsetY + ((i - 1) / 100) * gap, offsetX + (i % 100) * gap, offsetY + (i / 100) * gap);
      }
    }
  }
}
