import gifAnimation.*;

int[] values = {90, 30, 60, 40, 20}; // Array to sort
int i = 0;
int j = i + 1;
int minIndex = i;

GifMaker gifExport;

// Colors from the provided palette
color currentMinColor = color(239, 107, 72); // Red-orange for the minimum element
color currentPosColor = color(99, 177, 142); // Green for the current position
color barColor = color(167, 231, 182); // Light green for the bars

void setup() {
  size(400, 200);
  frameRate(10);

  // Setup GifMaker
  gifExport = new GifMaker(this, "selection_sort_visualization.gif");
  gifExport.setRepeat(0); // Make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(100); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  displayArray();

  if (i < values.length) {
    if (j < values.length) {
      if (values[j] < values[minIndex]) {
        minIndex = j;
      }
      j++;
    } else {
      // Swap minimum element found to the current i position
      int temp = values[minIndex];
      values[minIndex] = values[i];
      values[i] = temp;
      i++;
      minIndex = i;
      j = i + 1;
    }
    gifExport.addFrame(); // Add the current frame to the GIF
  } else {
    gifExport.finish(); // Finish the GIF once done
    noLoop(); // Stop the animation when sorting is complete
  }
}

void displayArray() {
  for (int k = 0; k < values.length; k++) {
    if (k == minIndex) fill(currentMinColor); // Highlight the minimum element
    else if (k == i) fill(currentPosColor);   // Highlight the start of unsorted part
    else fill(barColor); // General color for the bars
    rect(20 + k * 76, height - values[k], 30, values[k]);
  }
}
