import gifAnimation.*;
import java.util.Arrays;

int[] array = {9, 5, 13, 8, 2}; // The array to be sorted
int i = 1;                      // The index of the current element to be inserted
int j = i;                      // The index used for shifting elements
int key;                        // The element to be inserted
boolean isSorting = false;      // Flag to control the sorting process
GifMaker gifExport;
boolean gifFinished = false;

void setup() {
  size(600, 400);
  frameRate(1); // Slow down the animation to 1 frame per second for better visualization
  key = array[i]; // Initialize the key with the first element to be sorted

  // Initialize GIF export
  gifExport = new GifMaker(this, "insertion_sort_visualization.gif");
  gifExport.setRepeat(0);  // Make the GIF loop
  gifExport.setQuality(10);
  gifExport.setDelay(1000);  // Set delay time between frames in milliseconds
}

void draw() {
  background(255);
  displayArray();
  displayText();

  if (isSorting) {
    if (i < array.length) {
      if (j > 0 && array[j - 1] > key) {
        array[j] = array[j - 1];
        j--;
        displayArrayHighlighted(j, i, true);
      } else {
        array[j] = key;
        i++;
        if (i < array.length) {
          key = array[i];
          j = i;
        }
        displayArrayHighlighted(j, i, false);
      }
    } else {
      isSorting = false; // Sorting is complete
      gifFinished = true;
    }
  }

  // Add the current frame to the GIF
  gifExport.addFrame();
  if (gifFinished) {
    gifExport.finish(); // Finish the GIF once done
    gifFinished = false; // Ensure finish is called only once
  }
}

void displayArray() {
  for (int k = 0; k < array.length; k++) {
    fill(200);
    rect(50 + k * 70, 150, 50, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text(array[k], 50 + k * 70 + 25, 175);
  }
}

void displayArrayHighlighted(int index, int currentIndex, boolean isShifting) {
  for (int k = 0; k < array.length; k++) {
    if (k == index) {
      fill(100, 200, 100); // Highlight the current element being compared
    } else if (k == currentIndex) {
      fill(100, 100, 200); // Highlight the current element being sorted
    } else if (isShifting && k == index + 1) {
      fill(255, 200, 200); // Highlight the element being shifted
    } else {
      fill(200);
    }
    rect(50 + k * 70, 150, 50, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text(array[k], 50 + k * 70 + 25, 175);
  }
}

void displayText() {
  fill(0);
  textSize(16);
  textAlign(LEFT, TOP);
  if (isSorting) {
    text("Insertion Sort Visualization", 10, 10);
    if (i < array.length) {
      text("Key = " + key, 10, 40);
      text("Inserting element " + key + " into the sorted part of the array", 10, 60);
      if (j > 0 && array[j - 1] > key) {
        text("Shifting element " + array[j - 1] + " to the right", 10, 80);
      } else {
        text("Placing key " + key + " at position " + j, 10, 80);
      }
    } else {
      text("Sorting complete", 10, 40);
    }
  } else {
    text("Click to start the sorting process", 10, 10);
  }
}

void mousePressed() {
  if (!isSorting) {
    isSorting = true;
    key = array[i];
    j = i;
  }
}
