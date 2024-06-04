import gifAnimation.*;
import java.util.ArrayList;

int[] socksMergeSort = {38, 27, 43, 3, 9, 82, 10}; // Example array for Merge Sort (socks sizes)
int[] socksQuicksort = {38, 27, 43, 3, 9, 82, 10}; // Example array for Quicksort (socks sizes)
ArrayList<int[]> framesMergeSort = new ArrayList<int[]>();
ArrayList<int[]> framesQuicksort = new ArrayList<int[]>();
GifMaker gifExport;
PFont lato;

boolean isMergeSort = true; // Toggle between Merge Sort and Quicksort
int[] arrayCopy;

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);

  // Prepare the Merge Sort visualization
  arrayCopy = socksMergeSort.clone();
  mergeSort(arrayCopy, 0, arrayCopy.length - 1);

  // Prepare the Quicksort visualization
  arrayCopy = socksQuicksort.clone();
  quicksort(arrayCopy, 0, arrayCopy.length - 1);

  gifExport = new GifMaker(this, "beary_sorting_socks.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(100); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  ArrayList<int[]> frames = isMergeSort ? framesMergeSort : framesQuicksort;
  int[] currentFrame = frames.get(frameCount % frames.size());
  displaySocks(currentFrame);

  gifExport.addFrame(); // Add the current frame to the GIF
  if (frameCount >= frames.size()) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }

  // Display algorithm name and scenario
  fill(0);
  text(isMergeSort ? "Beary the Bear using Merge Sort to organize his socks" : "Beary the Bear using Quicksort to organize his socks", width / 2, height - 50);
}

void displaySocks(int[] array) {
  for (int i = 0; i < array.length; i++) {
    fill(isMergeSort ? color(41, 116, 150) : color(12, 51, 84)); // Blue 004 for Merge Sort, Blue 005 for Quicksort
    rect(200 + i * 150, 500 - array[i] * 5, 100, array[i] * 5);
    fill(255);
    text(array[i], 250 + i * 150, 500 - array[i] * 5 - 20);
  }
}

void mergeSort(int[] array, int left, int right) {
  if (left < right) {
    int mid = (left + right) / 2;
    mergeSort(array, left, mid);
    mergeSort(array, mid + 1, right);
    merge(array, left, mid, right);
  }
}

void merge(int[] array, int left, int mid, int right) {
  int n1 = mid - left + 1;
  int n2 = right - mid;
  int[] leftArray = new int[n1];
  int[] rightArray = new int[n2];

  for (int i = 0; i < n1; i++) leftArray[i] = array[left + i];
  for (int i = 0; i < n2; i++) rightArray[i] = array[mid + 1 + i];

  int i = 0, j = 0, k = left;
  while (i < n1 && j < n2) {
    if (leftArray[i] <= rightArray[j]) {
      array[k] = leftArray[i];
      i++;
    } else {
      array[k] = rightArray[j];
      j++;
    }
    k++;
  }

  while (i < n1) {
    array[k] = leftArray[i];
    i++;
    k++;
  }

  while (j < n2) {
    array[k] = rightArray[j];
    j++;
    k++;
  }

  framesMergeSort.add(array.clone());
}

void quicksort(int[] array, int low, int high) {
  if (low < high) {
    int pi = partition(array, low, high);
    quicksort(array, low, pi - 1);
    quicksort(array, pi + 1, high);
  }
}

int partition(int[] array, int low, int high) {
  int pivot = array[high];
  int i = (low - 1);
  for (int j = low; j < high; j++) {
    if (array[j] < pivot) {
      i++;
      int temp = array[i];
      array[i] = array[j];
      array[j] = temp;
    }
  }
  int temp = array[i + 1];
  array[i + 1] = array[high];
  array[high] = temp;

  framesQuicksort.add(array.clone());
  return i + 1;
}

void keyPressed() {
  if (key == ' ') {
    isMergeSort = !isMergeSort;
    frameCount = 0; // Restart animation
    loop();
  }
}
