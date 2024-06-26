import gifAnimation.*;

int[] socks = {90, 30, 60, 40, 20, 70, 50, 10, 80, 110, 100, 130, 120, 140}; // Example array representing Beary's socks
ArrayList<int[]> frames = new ArrayList<int[]>();
GifMaker gifExport;
PFont lato;

// Colors from the provided palette
color colorDividing = color(248, 200, 164); // Light orange
color colorSorting = color(247, 157, 100);  // Orange
color colorMerging = color(239, 107, 72);   // Red-orange

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  frameRate(1); // Slow the animation for better visualization

  // Prepare the Merge Sort visualization
  int[] arrayCopy = socks.clone();
  mergeSort(arrayCopy, 0, arrayCopy.length - 1);

  gifExport = new GifMaker(this, "beary_merge_sort.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  int[] currentFrame = frames.get(frameCount % frames.size());
  displaySocks(currentFrame);

  gifExport.addFrame(); // Add the current frame to the GIF
  if (frameCount >= frames.size()) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }

  // Display algorithm name and scenario
  fill(0);
  textSize(28);
  text("Beary the Bear using Merge Sort to organize his socks", width / 2, height - 150);
  text("Merge Sort Steps: Divide, Sort, and Merge", width / 2, height - 100);
  text("Current Step: " + getCurrentStep(), width / 2, height - 50);
}

void displaySocks(int[] array) {
  for (int i = 0; i < array.length; i++) {
    if (frameCount < frames.size() / 3) {
      fill(colorDividing); // Color for dividing step
    } else if (frameCount < 2 * frames.size() / 3) {
      fill(colorSorting); // Color for sorting step
    } else {
      fill(colorMerging); // Color for merging step
    }
    rect(50 + i * 100, 600 - array[i] * 4, 80, array[i] * 4);
    fill(0);
    text(array[i], 90 + i * 100, 600 - array[i] * 4 - 20);
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

  frames.add(array.clone());
}

String getCurrentStep() {
  int frame = frameCount % frames.size();
  if (frame < frames.size() / 3) return "Dividing";
  else if (frame < 2 * frames.size() / 3) return "Sorting";
  else return "Merging";
}
