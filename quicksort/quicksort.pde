int[] values = {90, 30, 60, 40, 20};
int n = values.length;
int currentPivotIndex = -1; // To highlight the pivot
int currentLow = 0;
int currentHigh = n - 1;
int[] stack = new int[n];
int top = -1;

void setup() {
  size(500, 250);
  textSize(16);
  frameRate(2); // Slow the animation for better visualization
  stack[++top] = 0;
  stack[++top] = n - 1;
}

void draw() {
  background(255);
  displayArray();

  if (top >= 0) {
    currentHigh = stack[top--];
    currentLow = stack[top--];
    int pi = partition(currentLow, currentHigh);
    if (pi - 1 > currentLow) {
      stack[++top] = currentLow;
      stack[++top] = pi - 1;
    }
    if (pi + 1 < currentHigh) {
      stack[++top] = pi + 1;
      stack[++top] = currentHigh;
    }
  } else {
    noLoop(); // Stop the animation when sorting is complete
  }
}

int partition(int low, int high) {
  int pivot = values[high];
  currentPivotIndex = high;
  int i = (low - 1);
  for (int j = low; j < high; j++) {
    if (values[j] < pivot) {
      i++;
      int temp = values[i];
      values[i] = values[j];
      values[j] = temp;
    }
  }
  int temp = values[i + 1];
  values[i + 1] = values[high];
  values[high] = temp;
  return i + 1;
}

void displayArray() {
  for (int i = 0; i < values.length; i++) {
    if (i == currentPivotIndex) fill(255, 0, 0); // Red for pivot
    else if (i >= currentLow && i <= currentHigh) fill(100, 200, 100); // Green for active segment
    else fill(150);
    rect(20 + i * 90, 50, 60, values[i] + 10);
    fill(0);
    text(values[i], 20 + i * 90 + 30, 50 + values[i] + 25);
  }
}
