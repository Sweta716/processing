import gifAnimation.*;

int[] bigO = {1, 2, 4, 8, 16, 32, 64, 128}; // Exponential growth for Big O
int[] bigOmega = {1, 2, 3, 4, 5, 6, 7, 8}; // Linear growth for Big Omega
int[] bigTheta = {1, 3, 6, 10, 15, 21, 28, 36}; // Quadratic growth for Big Theta

GifMaker gifExport;
PFont lato;
int currentFrame = 0;

// Colors from the palette
color colorBlue004 = color(41, 116, 150);
color colorGreen004 = color(2, 89, 68);
color colorYellow004 = color(255, 184, 56);

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  frameRate(1); // Slow the animation for better visualization

  gifExport = new GifMaker(this, "algorithm_analysis.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  displayAnalysis(currentFrame);

  gifExport.addFrame(); // Add the current frame to the GIF
  currentFrame++;
  if (currentFrame >= max(bigO.length, bigOmega.length, bigTheta.length)) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }

  // Display algorithm name and scenario
  fill(0);
  textSize(28);
  text("Understanding and Comparing Algorithm Efficiency", width / 2, height - 200);
  text("Algorithm Analysis: Big O, Big Omega, Big Theta", width / 2, height - 150);
  text("Key Points: Big O (Upper Bound), Big Omega (Lower Bound), Big Theta (Tight Bound)", width / 2, height - 100);
}

void displayAnalysis(int frame) {
  // Display Big O
  if (frame < bigO.length) {
    fill(colorBlue004);
    rect(400, height - 200 - bigO[frame] * 10, 100, bigO[frame] * 10);
    fill(0);
    text("Big O: " + bigO[frame], 450, height - 200 - bigO[frame] * 10 - 20);
  }

  // Display Big Omega
  if (frame < bigOmega.length) {
    fill(colorGreen004);
    rect(900, height - 200 - bigOmega[frame] * 10, 100, bigOmega[frame] * 10);
    fill(0);
    text("Big Ω: " + bigOmega[frame], 950, height - 200 - bigOmega[frame] * 10 - 20);
  }

  // Display Big Theta
  if (frame < bigTheta.length) {
    fill(colorYellow004);
    rect(1400, height - 200 - bigTheta[frame] * 10, 100, bigTheta[frame] * 10);
    fill(0);
    text("Big Θ: " + bigTheta[frame], 1450, height - 200 - bigTheta[frame] * 10 - 20);
  }
}
