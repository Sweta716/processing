import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
int[] array = {5, 3, 8, 6, 2}; // The array to sum
int sum = 0;                   // Store the sum of the array elements
int currentIndex = 0;          // Current index in the array being added
boolean done = false;          // Flag to check if summing is complete

void setup() {
  size(400, 200);
  textAlign(CENTER, CENTER);
  textSize(16);
}

void draw() {
  background(255);
  // Display the array elements
  for (int i = 0; i < array.length; i++) {
    if (i == currentIndex && !done) {
      fill(100, 200, 100); // Highlight the current element
    } else {
      fill(200);
    }
    rect(50 + i * 70, 80, 50, 50);
    fill(0);
    text(array[i], 50 + i * 70 + 25, 105);
  }

  // Display the sum
  fill(0);
  text("Sum: " + sum, width / 2, 150);

  // Add elements one at a time
  if (frameCount % 60 == 0 && !done) { // Update every second
    if (currentIndex < array.length) {
      sum += array[currentIndex];
      currentIndex++;
    } else {
      done = true; // Stop when all elements are added
    }
  }
}

// Restart the summing when mouse is pressed
void mousePressed() {
  sum = 0;
  currentIndex = 0;
  done = false;
}
