import gifAnimation.*;
import java.util.ArrayList;

int[] array;
int arraySize = 50; // Number of elements in the array
int currentPivotIndex = -1;
ArrayList<int[]> frames = new ArrayList<int[]>();
boolean fastForward = true;
GifMaker gifExport;

// Colors from the provided palette
color barColor = color(167, 231, 182); // Light green for bars
color pivotColor = color(247, 157, 100); // Orange for pivot
color comparisonColor = color(239, 107, 72); // Red-orange for elements being compared

void setup() {
  size(800, 600);
  array = new int[arraySize];
  for (int i = 0; i < arraySize; i++) {
    array[i] = int(random(height - 100)) + 50;
  }
  randomizedQuickSort(array, 0, arraySize - 1);
  if (fastForward) {
    frameRate(60); // Increase frame rate for faster visualization
  } else {
    frameRate(1);
  }

  // Setup GifMaker
  gifExport = new GifMaker(this, "randomized_quicksort_visualization.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  textSize(24);
  textAlign(CENTER);
  fill(0);
  text("Visualizing Randomized QuickSort", width / 2, 30);
  textSize(18);
  text("Pivot: " + currentPivotIndex, width / 2, 60);
  drawArray(array);
  if (frames.size() > 0) {
    if (!fastForward) {
      saveFrame("frames/frame-######.png");
    }
    array = frames.remove(0);
    gifExport.addFrame(); // Add the current frame to the GIF
  } else {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }
}

void drawArray(int[] array) {
  for (int i = 0; i < array.length; i++) {
    if (i == currentPivotIndex) {
      fill(pivotColor);
    } else {
      fill(barColor);
    }
    rect(i * (width / arraySize), height - array[i], (width / arraySize) - 1, array[i]);
  }
}

void randomizedQuickSort(int[] array, int low, int high) {
  if (low < high) {
    int pi = randomizedPartition(array, low, high);
    frames.add(array.clone());
    currentPivotIndex = pi;
    randomizedQuickSort(array, low, pi - 1);
    randomizedQuickSort(array, pi + 1, high);
  }
}

int randomizedPartition(int[] array, int low, int high) {
  int pivotIndex = int(random(low, high + 1));
  swap(array, pivotIndex, high);
  return partition(array, low, high);
}

int partition(int[] array, int low, int high) {
  int pivot = array[high];
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (array[j] < pivot) {
      i++;
      swap(array, i, j);
      frames.add(array.clone());
    }
  }
  swap(array, i + 1, high);
  frames.add(array.clone());
  return i + 1;
}

void swap(int[] array, int i, int j) {
  int temp = array[i];
  array[i] = array[j];
  array[j] = temp;
}
