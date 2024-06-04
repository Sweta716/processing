import gifAnimation.*;

PFont font;
GifMaker gifMaker;

void setup() {
  size(1200, 800);
  font = createFont("Lato", 32);
  textFont(font);
  frameRate(1); // Slower frame rate

  // Setup GifMaker
  gifMaker = new GifMaker(this, "Intractability.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
}

void draw() {
  background(255);
  
  // Title
  fill(0);
  textAlign(CENTER, TOP);
  text("Intractability", width / 2, 20);

  // NP problems
  fill(0, 0, 255);
  ellipse(300, 400, 400, 400);
  fill(255);
  textAlign(CENTER, CENTER);
  text("NP Problems", 300, 400);
  
  // NP-Complete problems
  fill(255, 0, 0);
  ellipse(300, 400, 200, 200);
  fill(255);
  text("NP-Complete", 300, 400);

  // P problems
  fill(0, 255, 0);
  ellipse(900, 400, 200, 200);
  fill(0);
  text("P Problems", 900, 400);

  // Reduction arrow
  stroke(0);
  strokeWeight(4);
  line(550, 400, 750, 400);
  fill(0);
  textAlign(CENTER, BOTTOM);
  text("Reduction", 650, 380);
  
  // Key Points
  fill(0);
  textAlign(LEFT, TOP);
  text("Key Points:", 50, 600);
  text("- NP: Problems verifiable in polynomial time.", 50, 650);
  text("- NP-Complete: The hardest problems in NP.", 50, 700);
  text("- Reduction: Transforming one problem into another to prove hardness.", 50, 750);
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
  
  // Finish the GIF after one frame (since this is a static visualization)
  if (frameCount == 1) {
    gifMaker.finish();
    noLoop();
  }
}
