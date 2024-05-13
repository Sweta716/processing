int[] values = {90, 30, 60, 40, 20}; // Array to sort
int i = 0;
int j = 0;

void setup() {
  size(400, 200);
  frameRate(10); // Slow down the animation
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
}

void displayArray() {
  for (int k = 0; k < values.length; k++) {
    if (k == j || k == j + 1) fill(180, 100, 120); // Highlight the current elements
    else fill(150);
    rect(20 + k * 76, 50, 30, values[k] + 10);
  }
}
