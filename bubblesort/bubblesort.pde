import gifAnimation.*;

GifMaker gifExport;

int[] values = {90, 30, 60, 40, 20}; // Array to sort
int i = 0;
int j = 0;

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

color currentColor = colors[1];   // Orange
color otherColor = colors[6];     // Light Green

void setup() {
  size(400, 200);
  frameRate(10); // Slow down the animation
  
  // Setup GifMaker
  gifExport = new GifMaker(this, "bubblesort.gif");
  gifExport.setRepeat(0); // Repeat indefinitely
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}

void draw() {
  background(255);
  displayArray();

  if (i < values.length) {
    if (j < values.length - i - 1) {
      if (values[j] > values[j + 1]) {
        // Swap elements
        int temp = values[j];
        values[j] = values[j + 1];
        values[j + 1] = temp;
      }
      j++;
    } else {
      j = 0;
      i++;
    }
  } else {
    noLoop(); // Stop the animation when sorting is complete
  }

  // Add the current frame to the GIF
  gifExport.addFrame();
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
  }
}

void displayArray() {
  for (int k = 0; k < values.length; k++) {
    if (k == j || k == j + 1) fill(currentColor); // Highlight the current elements
    else fill(otherColor); // Other elements
    rect(20 + k * 76, 50, 30, values[k] + 10);
  }
}

boolean done() {
  return i >= values.length;
}
