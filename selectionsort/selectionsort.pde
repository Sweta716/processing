int[] values = {90, 30, 60, 40, 20}; // Array to sort
int i = 0;
int j = i + 1;
int minIndex = i;

void setup() {
  size(400, 200);
  frameRate(10);
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
  } else {
    noLoop(); // Stop the animation when sorting is complete
  }
}

void displayArray() {
  for (int k = 0; k < values.length; k++) {
    if (k == minIndex) fill(180, 100, 120); // Highlight the minimum element
    else if (k == i) fill(100, 200, 100);   // Highlight the start of unsorted part
    else fill(150);
    rect(20 + k * 76, 50, 30, values[k] + 10);
  }
}
