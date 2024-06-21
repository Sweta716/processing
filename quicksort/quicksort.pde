import gifAnimation.*;

PFont font;
GifMaker gifExport;
int[] array = {38, 27, 43, 3, 9, 82, 10};
ArrayList<int[]> frames = new ArrayList<int[]>();

// Colors from the provided palette
color barColor = color(167, 231, 182); // Light green for bars
color pivotColor = color(247, 157, 100); // Orange for pivot
color comparisonColor = color(239, 107, 72); // Red-orange for elements being compared

void setup() {
  size(1920, 1080);
  font = createFont("Lato", 32);
  textFont(font);
  textAlign(CENTER, CENTER);

  // Prepare the Quicksort visualization
  quicksort(array, 0, array.length - 1);

  gifExport = new GifMaker(this, "quicksort_visualization.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(200); // Slower GIF speed for better understanding
}

void draw() {
  background(255);
  int[] currentFrame = frames.get(frameCount % frames.size());
  displayArray(currentFrame);

  gifExport.addFrame(); // Add the current frame to the GIF
  if (frameCount >= frames.size()) {
    gifExport.finish(); // Finish the GIF once done
    noLoop();
  }

  // Display algorithm name
  fill(0);
  textSize(28);
  text("Quicksort Visualization", width / 2, height - 50);
}

void displayArray(int[] array) {
  for (int i = 0; i < array.length; i++) {
    fill(barColor); // Default bar color
    rect(100 + i * 100, height - array[i] * 10 - 100, 80, array[i] * 10);
    fill(0);
    text(array[i], 140 + i * 100, height - array[i] * 10 - 120);
  }
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

  frames.add(array.clone());
  return i + 1;
}
