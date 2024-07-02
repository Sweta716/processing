import gifAnimation.*;

int[] array = {38, 27, 43, 3, 9, 82, 10};
int[] tempArray;
GifMaker gifExport;
int frameDelay = 1000; // delay in milliseconds
int frameCounter = 0;
String stage = "";

void setup() {
  size(800, 600);
  tempArray = new int[array.length];
  gifExport = new GifMaker(this, "merge_sort_demo.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(frameDelay); // frame duration
  frameRate(1); // for demonstration purposes
  noLoop(); // we'll control the loop manually

  // Start merge sort
  mergeSort(array, tempArray, 0, array.length - 1);

  gifExport.finish();
}

void draw() {
  // No continuous drawing needed, handled in mergeSort and merge functions
}

void saveFrameWithStage(int[] array, int low, int high, String stage) {
  background(255);
  int w = width / array.length;
  for (int i = 0; i < array.length; i++) {
    if (i >= low && i <= high) {
      if (stage.equals("Divide")) {
        fill(250, 100, 100); // Red for divide stage
      } else if (stage.equals("Sort")) {
        fill(100, 100, 250); // Blue for sort stage
      } else if (stage.equals("Merge")) {
        fill(100, 250, 100); // Green for merge stage
      }
    } else {
      fill(200, 200, 200); // Grey for rest
    }
    rect(i * w, height - array[i] * 50, w, array[i] * 50);
  }
  textSize(32);
  fill(0);
  textAlign(CENTER, CENTER);
  text(stage, width / 2, 50);
  gifExport.addFrame();
  delay(frameDelay);
}

void mergeSort(int[] array, int[] tempArray, int leftStart, int rightEnd) {
  if (leftStart >= rightEnd) {
    return;
  }

  int mid = (leftStart + rightEnd) / 2;

  saveFrameWithStage(array, leftStart, mid, "Divide");
  saveFrameWithStage(array, mid + 1, rightEnd, "Divide");

  mergeSort(array, tempArray, leftStart, mid);
  mergeSort(array, tempArray, mid + 1, rightEnd);

  mergeHalves(array, tempArray, leftStart, rightEnd);
}

void mergeHalves(int[] array, int[] tempArray, int leftStart, int rightEnd) {
  int leftEnd = (leftStart + rightEnd) / 2;
  int rightStart = leftEnd + 1;
  int size = rightEnd - leftStart + 1;

  int left = leftStart;
  int right = rightStart;
  int index = leftStart;

  while (left <= leftEnd && right <= rightEnd) {
    if (array[left] <= array[right]) {
      tempArray[index] = array[left];
      left++;
    } else {
      tempArray[index] = array[right];
      right++;
    }
    index++;
  }

  System.arraycopy(array, left, tempArray, index, leftEnd - left + 1);
  System.arraycopy(array, right, tempArray, index, rightEnd - right + 1);
  System.arraycopy(tempArray, leftStart, array, leftStart, size);

  saveFrameWithStage(array, leftStart, rightEnd, "Merge");
}
