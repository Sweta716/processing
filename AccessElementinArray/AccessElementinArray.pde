int[] array = {10, 20, 30, 40, 50};  // Example array
int selectedIndex = 2;               // Index of the element to access

void setup() {
  size(500, 200);
  textAlign(CENTER, CENTER);
  textSize(16);
}

void draw() {
  background(255);
  displayArray();
}

void displayArray() {
  for (int i = 0; i < array.length; i++) {
    if (i == selectedIndex) fill(100, 200, 100); // Highlight the accessed element
    else fill(200);
    rect(50 + i * 90, 75, 60, 60);
    fill(0);
    text(array[i], 50 + i * 90 + 30, 105);
  }
}
