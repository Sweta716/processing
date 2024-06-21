import gifAnimation.*;

int[] bigO = {1, 2, 4, 8, 16, 32, 64, 128}; // Exponential growth for Big O
int[] bigOmega = {1, 2, 3, 4, 5, 6, 7, 8}; // Linear growth for Big Omega
int[] bigTheta = {1, 3, 6, 10, 15, 21, 28, 36}; // Quadratic growth for Big Theta

GifMaker gifExport;
PFont lato;
int currentFrame = 0;

// Colors from the palette
color[] colors = {
  color(255, 204, 153), // Light Orange
  color(255, 153, 102), // Orange
  color(255, 102, 51),  // Dark Orange
  color(255, 255, 204), // Light Yellow
  color(255, 255, 153), // Yellow
  color(255, 255, 102), // Dark Yellow
  color(204, 255, 204), // Light Green
  color(153, 204, 153), // Green
  color(102, 153, 102), // Dark Green
  color(204, 255, 255), // Light Blue
  color(153, 204, 255), // Blue
  color(102, 153, 255)  // Dark Blue
};

color bigOColor = colors[2];      // Dark Orange
color bigOmegaColor = colors[6];  // Light Green
color bigThetaColor = colors[10]; // Blue

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
    fill(bigOColor);
    rect(400, height - 200 - bigO[frame] * 10, 100, bigO[frame] * 10);
    fill(0);
    text("Big O: " + bigO[frame], 450, height - 200 - bigO[frame] * 10 - 20);
  }

  // Display Big Omega
  if (frame < bigOmega.length) {
    fill(bigOmegaColor);
    rect(900, height - 200 - bigOmega[frame] * 10, 100, bigOmega[frame] * 10);
    fill(0);
    text("Big Ω: " + bigOmega[frame], 950, height - 200 - bigOmega[frame] * 10 - 20);
  }

  // Display Big Theta
  if (frame < bigTheta.length) {
    fill(bigThetaColor);
    rect(1400, height - 200 - bigTheta[frame] * 10, 100, bigTheta[frame] * 10);
    fill(0);
    text("Big Θ: " + bigTheta[frame], 1450, height - 200 - bigTheta[frame] * 10 - 20);
  }
}
