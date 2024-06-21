import gifAnimation.*;

PFont font;
GifMaker gifMaker;
int[] heights;
int step = 0;
int maxHeight;
int totalBars = 30;
boolean isSorted = false;
int currentComparison = 0;

// Colors from the provided palette
color barColor = color(167, 231, 182);       // Light green for bars
color comparisonColor = color(247, 157, 100); // Orange for current comparisons
color arrowColor = color(239, 107, 72);      // Red-orange for arrows

void setup() {
  size(800, 600);
  font = createFont("Lato", 16);
  textFont(font);
  heights = new int[totalBars];
  for (int i = 0; i < heights.length; i++) {
    heights[i] = int(random(height / 2));
  }
  maxHeight = height / 2;
  frameRate(1); // Adjust the frame rate as needed
  
  // Setup GifMaker
  gifMaker = new GifMaker(this, "NP_Problem.gif");
  gifMaker.setRepeat(0); // Repeat indefinitely
}

void draw() {
  background(255); // White background
  fill(0);
  textAlign(CENTER, TOP);
  text("Visualizing NP Problem and Reduction", width / 2, 20);
  
  drawBars();
  if (!isSorted) {
    bubbleSortStep();
  }
  
  // Add the current frame to the GIF
  gifMaker.addFrame();
}

void drawBars() {
  int barWidth = width / totalBars;
  for (int i = 0; i < heights.length; i++) {
    if (i == currentComparison || i == currentComparison + 1) {
      fill(comparisonColor); // Color for current comparisons
    } else {
      fill(barColor); // Color for bars
    }
    rect(i * barWidth, height - heights[i] - 150, barWidth - 1, heights[i]);
    fill(0);
    textAlign(CENTER, BOTTOM);
    text(heights[i], i * barWidth + barWidth / 2, height - heights[i] - 155);
    
    if (i == currentComparison || i == currentComparison + 1) {
      drawArrow(i * barWidth + barWidth / 2, height - heights[i] - 150, (i + 1) * barWidth + barWidth / 2, height - heights[i + 1] - 150);
    }
  }
}

void drawArrow(float x1, float y1, float x2, float y2) {
  stroke(arrowColor); // Red-orange color for arrows
  strokeWeight(2); // Thinner arrow
  line(x1, y1, x2, y2);
  float angle = atan2(y2 - y1, x2 - x1);
  float arrowSize = 8; // Smaller arrowhead
  line(x2, y2, x2 - arrowSize * cos(angle + PI / 6), y2 - arrowSize * sin(angle + PI / 6));
  line(x2, y2, x2 - arrowSize * cos(angle - PI / 6), y2 - arrowSize * sin(angle - PI / 6));
}

void bubbleSortStep() {
  if (step >= heights.length - 1) {
    step = 0;
    isSorted = true;
    for (int i = 0; i < heights.length - 1; i++) {
      if (heights[i] > heights[i + 1]) {
        isSorted = false;
        break;
      }
    }
    if (isSorted) {
      gifMaker.finish();
      noLoop();
      return;
    }
  }
  
  for (int i = 0; i < heights.length - step - 1; i++) {
    if (heights[i] > heights[i + 1]) {
      int temp = heights[i];
      heights[i] = heights[i + 1];
      heights[i + 1] = temp;
    }
  }
  currentComparison++;
  if (currentComparison >= heights.length - step - 1) {
    currentComparison = 0;
    step++;
  }
}
