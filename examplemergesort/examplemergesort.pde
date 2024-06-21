import java.util.*;
import gifAnimation.*;

int[] socks;
int[] temp;
int numSocks = 8;
int sockSize = 50;
String currentAction = "";
boolean isSorted = false;
int highlightLeft = -1;
int highlightRight = -1;
GifMaker gifExport;

// Colors from the provided palette
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

void setup() {
  size(800, 400);
  socks = new int[numSocks];
  temp = new int[numSocks];
  
  // Initializing socks with pairs of colors
  for (int i = 0; i < numSocks; i++) {
    socks[i] = i / 2;
  }
  
  // Shuffle socks to simulate unsorted state
  shuffleArray(socks);
  println("Initial socks: " + Arrays.toString(socks));
  
  // Set up font
  textFont(createFont("Arial", 20, true));
  
  // Initialize GIF export
  gifExport = new GifMaker(this, "merge_sort_visualization.gif");
  gifExport.setRepeat(0);  // Make the GIF loop
  gifExport.setQuality(10);
  gifExport.setDelay(1000);  // Set delay time between frames in milliseconds
  
  // Start merge sort visualization
  frameRate(1);  // Slow down the frame rate to make the process visible
  new Thread(new Runnable() {
    public void run() {
      mergeSort(0, numSocks - 1);
      isSorted = true;
      gifExport.finish();  // Finish the GIF file
    }
  }).start();
}

void draw() {
  background(255);
  displaySocks();
  fill(0);
  textAlign(CENTER);
  text(currentAction, width / 2, height - 30);
  
  if (isSorted) {
    currentAction = "Sorting complete!";
  }
  
  gifExport.addFrame();  // Add the current frame to the GIF
}

void displaySocks() {
  for (int i = 0; i < numSocks; i++) {
    if (i >= highlightLeft && i <= highlightRight) {
      fill(colors[1]);  // Highlight color (Orange)
    } else {
      fill(colors[socks[i] % colors.length]); // Use colors from the palette
    }
    rect(i * sockSize + 50, height / 2 - sockSize, sockSize, sockSize);
    fill(0);
    textAlign(CENTER, CENTER);
    text(socks[i], i * sockSize + 75, height / 2 - 25);
  }
}

void shuffleArray(int[] array) {
  for (int i = array.length - 1; i > 0; i--) {
    int index = (int) random(i + 1);
    int a = array[index];
    array[index] = array[i];
    array[i] = a;
  }
}

void mergeSort(int left, int right) {
  if (left < right) {
    int mid = left + (right - left) / 2;
    
    currentAction = "Dividing: Left: " + left + " Mid: " + mid + " Right: " + right;
    highlightLeft = left;
    highlightRight = right;
    delayAndRedraw();
    
    mergeSort(left, mid);
    mergeSort(mid + 1, right);
    
    currentAction = "Merging: Left: " + left + " Mid: " + mid + " Right: " + right;
    highlightLeft = left;
    highlightRight = right;
    delayAndRedraw();
    
    merge(left, mid, right);
  }
}

void merge(int left, int mid, int right) {
  for (int i = left; i <= right; i++) {
    temp[i] = socks[i];
  }
  
  int i = left;
  int j = mid + 1;
  int k = left;
  
  while (i <= mid && j <= right) {
    if (temp[i] <= temp[j]) {
      socks[k] = temp[i];
      i++;
    } else {
      socks[k] = temp[j];
      j++;
    }
    k++;
    delayAndRedraw();  // Redraw after each merge step to visualize
  }
  
  while (i <= mid) {
    socks[k] = temp[i];
    i++;
    k++;
    delayAndRedraw();  // Redraw after each merge step to visualize
  }
  
  while (j <= right) {
    socks[k] = temp[j];
    j++;
    k++;
    delayAndRedraw();  // Redraw after each merge step to visualize
  }
}

void delayAndRedraw() {
  delay(1000);
  redraw();
}

void delay(int ms) {
  int start = millis();
  while (millis() - start < ms) {
    // Wait
  }
}
