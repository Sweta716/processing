import java.util.*;
import gifAnimation.*;

GifMaker gifExport;

int[] A;
int n = 20; // Number of elements in the array
int x = 25; // Element to search for
int low, high, mid;
boolean isFound = false;
String statusMessage = "Starting binary search for " + x + "...";

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

color midColor = colors[2];         // Dark Orange
color activeSearchColor = colors[10]; // Blue
color inactiveAreaColor = colors[0];  // Light Orange

void setup() {
  size(1200, 300);
  A = new int[n];
  generateAndSortArray();
  low = 0;
  high = n - 1;
  textSize(16);
  textAlign(CENTER, CENTER);
  frameRate(1); // Adjust frame rate for clear visualization

  // Setup GifMaker
  gifExport = new GifMaker(this, "binary_search.gif");
  gifExport.setRepeat(0); // Repeat indefinitely
  gifExport.setQuality(10);
  gifExport.setDelay(60); // Adjust GIF speed
}

void draw() {
  background(255);
  displayArray();
  if (!isFound && low <= high) {
    mid = low + (high - low) / 2;
    if (A[mid] == x) {
      isFound = true;
      statusMessage = "Element found at index " + mid;
      noLoop(); // Stop animation when found
    } else {
      if (A[mid] < x) {
        statusMessage = "Searching right half...";
        low = mid + 1;
      } else {
        statusMessage = "Searching left half...";
        high = mid - 1;
      }
    }
  } else if (!isFound) {
    noLoop(); // Stop animation if not found
    statusMessage = "Element not found.";
  }

  // Add the current frame to the GIF
  gifExport.addFrame();
  if (done()) {
    gifExport.finish(); // Finish the GIF once done
  }
}

void displayArray() {
  float rectWidth = width / (float)n;
  for (int i = 0; i < A.length; i++) {
    if (i >= low && i <= high) {
      if (i == mid) {
        fill(midColor); // Dark Orange for mid
      } else {
        fill(activeSearchColor); // Blue for active search area
      }
    } else {
      fill(inactiveAreaColor); // Light Orange for inactive area
    }
    
    rect(i * rectWidth, 60, rectWidth, 100);
    fill(0);
    text(A[i], i * rectWidth + rectWidth / 2, 110);
  }

  // Draw pointers for low, mid, and high
  drawPointer(low, rectWidth, "Low", 180);
  drawPointer(mid, rectWidth, "Mid", 200);
  drawPointer(high, rectWidth, "High", 180);

  fill(0);
  text(statusMessage, width / 2, 260);
}

void drawPointer(int index, float rectWidth, String label, int yPos) {
  if (index >= 0 && index < n) {
    fill(0);
    triangle(index * rectWidth + rectWidth / 2, yPos, 
             index * rectWidth + rectWidth / 2 - 5, yPos + 10, 
             index * rectWidth + rectWidth / 2 + 5, yPos + 10);
    text(label, index * rectWidth + rectWidth / 2, yPos - 5);
  }
}

void generateAndSortArray() {
  for (int i = 0; i < n; i++) {
    A[i] = (int)random(1, 100); // Generate random numbers between 1 and 100
  }
  Arrays.sort(A); // Sort the array to ensure binary search can be applied
}

boolean done() {
  return isFound || low > high;
}
