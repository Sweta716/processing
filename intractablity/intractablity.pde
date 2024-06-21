import gifAnimation.*;
import processing.core.PFont;

PFont font;
GifMaker gifMaker;
int step = 0;

void setup() {
  size(1200, 800);
  font = createFont("Lato", 32);
  textFont(font);
  frameRate(1); // Slower frame rate

  // Setup GifMaker
  gifMaker = new GifMaker(this, "Intractability.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
  gifMaker.setQuality(10);
  gifMaker.setDelay(1000); // Set delay time between frames in milliseconds
}

void draw() {
  background(255);
  
  // Title
  fill(0);
  textAlign(CENTER, TOP);
  text("Intractability", width / 2, 20);
  
  // Draw the elements step by step
  switch (step) {
    case 0:
      drawNP();
      break;
    case 1:
      drawNPComplete();
      break;
    case 2:
      drawP();
      break;
    case 3:
      drawReductionArrow();
      break;
    case 4:
      drawKeyPoints();
      break;
  }
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
  
  // Increment step and loop the steps for demonstration
  if (step < 4) {
    step++;
  } else {
    gifMaker.finish();
    noLoop();
  }
}

void drawNP() {
  fill(0, 0, 255);
  ellipse(300, 400, 400, 400);
  fill(255);
  textAlign(CENTER, CENTER);
  text("NP Problems", 300, 400);
}

void drawNPComplete() {
  drawNP();
  fill(255, 0, 0);
  ellipse(300, 400, 200, 200);
  fill(255);
  textAlign(CENTER, CENTER);
  text("NP-Complete", 300, 400);
}

void drawP() {
  drawNPComplete();
  fill(0, 255, 0);
  ellipse(900, 400, 200, 200);
  fill(0);
  textAlign(CENTER, CENTER);
  text("P Problems", 900, 400);
}

void drawReductionArrow() {
  drawP();
  stroke(0);
  strokeWeight(4);
  line(550, 400, 750, 400);
  fill(0);
  textAlign(CENTER, BOTTOM);
  text("Reduction", 650, 380);
}

void drawKeyPoints() {
  drawReductionArrow();
  fill(0);
  textAlign(LEFT, TOP);
  text("Key Points:", 50, 600);
  text("- NP: Problems verifiable in polynomial time.", 50, 650);
  text("- NP-Complete: The hardest problems in NP.", 50, 700);
  text("- Reduction: Transforming one problem into another to prove hardness.", 50, 750);
}
