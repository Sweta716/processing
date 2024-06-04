import gifAnimation.*;

PFont font;
GifMaker gifMaker;
int[] set = {3, 34, 4, 12, 5, 2};
int targetSum = 9;
boolean[] subset;
boolean found = false;
int currentStep = 0;

void setup() {
  size(800, 600);
  font = createFont("Lato", 16);
  textFont(font);
  subset = new boolean[set.length];
  frameRate(1); // Adjust the frame rate as needed
  
  // Setup GifMaker
  gifMaker = new GifMaker(this, "NP-Problem-SubsetSum.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
}

void draw() {
  background(255); // White background
  fill(0);
  textAlign(CENTER, TOP);
  text("Visualizing NP Problem: Subset Sum", width / 2, 20);
  
  drawSet();
  if (!found) {
    checkSubsetSum();
  }
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
}

void drawSet() {
  int barWidth = width / set.length;
  for (int i = 0; i < set.length; i++) {
    if (subset[i]) {
      fill(0, 255, 0); // Green for included in the subset
    } else {
      fill(200);
    }
    rect(i * barWidth, height / 2, barWidth - 1, -set[i] * 10);
    fill(0);
    textAlign(CENTER, BOTTOM);
    text(set[i], i * barWidth + barWidth / 2, height / 2 - set[i] * 10 - 5);
  }
}

void checkSubsetSum() {
  int currentSum = 0;
  for (int i = 0; i < subset.length; i++) {
    if (subset[i]) {
      currentSum += set[i];
    }
  }
  
  fill(0);
  textAlign(LEFT, TOP);
  text("Checking subset sum: " + currentSum, 50, height - 50);
  
  if (currentSum == targetSum) {
    found = true;
    fill(0);
    textAlign(LEFT, TOP);
    text("Subset found that sums to " + targetSum, 50, height - 80);
    gifMaker.finish();
    noLoop();
  } else {
    nextSubset();
  }
}

void nextSubset() {
  for (int i = 0; i < subset.length; i++) {
    if (!subset[i]) {
      subset[i] = true;
      break;
    } else {
      subset[i] = false;
    }
  }
}
