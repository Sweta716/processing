int[] array = {9, 5, 13, 8, 2}; // The array to be sorted
int i = 1;                      // The index of the current element to be inserted
int j = i;                      // The index used for shifting elements
int key;                        // The element to be inserted
boolean isSorting = false;      // Flag to control the sorting process

void setup() {
  size(400, 200);
  frameRate(1); // Slow down the animation to 1 frame per second for better visualization
}

void draw() {
  background(255);
  displayArray();

  if (isSorting) {
    if (i < array.length) {
      if (j > 0 && array[j - 1] > key) {
        array[j] = array[j - 1];
        j--;
        displayArrayHighlighted(j);
      } else {
        array[j] = key;
        i++;
        if (i < array.length) {
          key = array[i];
          j = i;
        }
        displayArrayHighlighted(i);
      }
    } else {
      isSorting = false; // Sorting is complete
    }
  }
}

void displayArray() {
  for (int k = 0; k < array.length; k++) {
    fill(200);
    rect(50 + k * 70, 50, 50, 50);
    fill(0);
    text(array[k], 50 + k * 70 + 25, 75);
  }
}

void displayArrayHighlighted(int index) {
  for (int k = 0; k < array.length; k++) {
    if (k == index) fill(100, 200, 100); // Highlight the current element
    else fill(200);
    rect(50 + k * 70, 50, 50, 50);
    fill(0);
    text(array[k], 50 + k * 70 + 25, 75);
  }
}

void mousePressed() {
  isSorting = true;
  key = array[i];
  j = i;
}
