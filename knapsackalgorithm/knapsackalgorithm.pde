import gifAnimation.*;

int[] weights = {1, 2, 3, 5};
int[] values = {10, 20, 30, 50};
int W = 5; // Maximum weight capacity of the knapsack
int n = weights.length;

int[][] dp = new int[n + 1][W + 1]; // DP table
GifMaker gifExport;
PFont lato;
int currentItem = 0;
int currentWeight = 0;

// Colors from the palette
color colorBlue004 = color(41, 116, 150);
color colorBlue005 = color(12, 51, 84);
color colorGreen004 = color(2, 89, 68);
color colorYellow004 = color(255, 184, 56);
color colorOrange004 = color(229, 98, 28);

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  frameRate(1); // Slow the animation for better visualization

  gifExport = new GifMaker(this, "knapsack_dynamic_programming.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding

  initializeDPTable();
}

void draw() {
  background(255);
  displayDPTable();

  gifExport.addFrame(); // Add the current frame to the GIF
  if (currentItem > n) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  } else {
    fillDPTable();
  }

  // Display algorithm name and scenario
  fill(0);
  textSize(28);
  text("0/1 Knapsack Problem using Dynamic Programming", width / 2, height - 200);
  text("Scenario: Solving problems with overlapping subproblems and optimal substructure", width / 2, height - 150);
  text("Current Step: " + getCurrentStep(), width / 2, height - 100);
  text("DP Table Values: ", width / 2, height - 50);
}

void initializeDPTable() {
  for (int i = 0; i <= n; i++) {
    for (int w = 0; w <= W; w++) {
      dp[i][w] = 0;
    }
  }
}

void fillDPTable() {
  if (currentItem <= n) {
    for (currentWeight = 0; currentWeight <= W; currentWeight++) {
      if (currentItem == 0 || currentWeight == 0) {
        dp[currentItem][currentWeight] = 0;
      } else if (weights[currentItem - 1] <= currentWeight) {
        dp[currentItem][currentWeight] = max(values[currentItem - 1] + dp[currentItem - 1][currentWeight - weights[currentItem - 1]], dp[currentItem - 1][currentWeight]);
      } else {
        dp[currentItem][currentWeight] = dp[currentItem - 1][currentWeight];
      }
    }
    currentItem++;
  }
}

void displayDPTable() {
  for (int i = 0; i <= n; i++) {
    for (int w = 0; w <= W; w++) {
      fill(0);
      if (i == currentItem && w == currentWeight) {
        fill(colorBlue004);
      } else if (i == currentItem) {
        fill(colorYellow004);
      } else if (dp[i][w] != 0) {
        fill(colorGreen004);
      } else {
        fill(200);
      }
      rect(200 + w * 150, 150 + i * 100, 100, 80);
      fill(0);
      text(dp[i][w], 250 + w * 150, 190 + i * 100);
    }
  }
  // Adding labels for the axes
  for (int i = 0; i <= n; i++) {
    fill(0);
    textAlign(LEFT, CENTER);
    text("Item " + i, 100, 190 + i * 100);
  }
  for (int w = 0; w <= W; w++) {
    fill(0);
    textAlign(CENTER, BOTTOM);
    text("Weight " + w, 250 + w * 150, 130);
  }
}

String getCurrentStep() {
  if (currentItem > n) return "Completed";
  return "Filling value for item " + currentItem + " and weight " + currentWeight;
}
