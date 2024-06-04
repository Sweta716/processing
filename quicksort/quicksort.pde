import gifAnimation.*;

int[] socks = {90, 30, 60, 40, 20, 70, 50, 10, 80, 110, 100, 130, 120, 140}; // Example array representing Beary's socks
int n = socks.length;
int currentPivotIndex = -1; // To highlight the pivot
int currentLow = 0;
int currentHigh = n - 1;
int[] stack = new int[n * 2];
int top = -1;

GifMaker gifExport;
PFont lato;

// Colors from the palette
color colorBlue004 = color(41, 116, 150);
color colorBlue005 = color(12, 51, 84);
color colorGreen004 = color(2, 89, 68);
color colorGreen005 = color(26, 69, 56);
color colorYellow004 = color(255, 184, 56);
color colorYellow005 = color(226, 168, 85);
color colorOrange004 = color(229, 98, 28);
color colorOrange005 = color(187, 65, 0);

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  frameRate(1); // Slow the animation for better visualization

  stack[++top] = 0;
  stack[++top] = n - 1;

  gifExport = new GifMaker(this, "beary_quicksort.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  displaySocks();

  gifExport.addFrame(); // Add the current frame to the GIF
  if (top < 0) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  } else {
    quicksortStep();
  }

  // Display algorithm name and scenario
  fill(0);
  textSize(28);
  text("Beary the Bear using Quicksort to organize his socks", width / 2, height - 150);
  text("Quicksort Steps: Divide, Sort, and Combine", width / 2, height - 100);
  text("Current Step: " + getCurrentStep(), width / 2, height - 50);
}

void displaySocks() {
  for (int i = 0; i < socks.length; i++) {
    if (i == currentPivotIndex) fill(colorOrange004); // Pivot color
    else if (i >= currentLow && i <= currentHigh) fill(colorYellow004); // Active segment color
    else fill(colorBlue004); // Default color
    rect(50 + i * 100, 600 - socks[i] * 4, 80, socks[i] * 4);
    fill(0);
    text(socks[i], 90 + i * 100, 600 - socks[i] * 4 - 20);
  }
}

void quicksortStep() {
  if (top >= 0) {
    currentHigh = stack[top--];
    currentLow = stack[top--];
    int pi = partition(currentLow, currentHigh);
    if (pi - 1 > currentLow) {
      stack[++top] = currentLow;
      stack[++top] = pi - 1;
    }
    if (pi + 1 < currentHigh) {
      stack[++top] = pi + 1;
      stack[++top] = currentHigh;
    }
  }
}

int partition(int low, int high) {
  int pivot = socks[high];
  currentPivotIndex = high;
  int i = (low - 1);
  for (int j = low; j < high; j++) {
    if (socks[j] < pivot) {
      i++;
      int temp = socks[i];
      socks[i] = socks[j];
      socks[j] = temp;
    }
  }
  int temp = socks[i + 1];
  socks[i + 1] = socks[high];
  socks[high] = temp;
  return i + 1;
}

String getCurrentStep() {
  if (top < 0) return "Completed";
  return "Partitioning at pivot " + socks[currentPivotIndex];
}
