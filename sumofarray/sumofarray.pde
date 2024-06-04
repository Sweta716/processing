import gifAnimation.*;

GifMaker gifExport;

int[] array = {5, 3, 8, 6, 2}; // The array to sum
int sum = 0;                   // Store the sum of the array elements
int currentIndex = 0;          // Current index in the array being added
boolean done = false;          // Flag to check if summing is complete

color standardColor = color(41, 116, 150); // Blue 004

PFont lato;

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  gifExport = new GifMaker(this, "sum_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(20); // Increase GIF speed
}

void draw() {
  background(255);
  // Display the array elements
  for (int i = 0; i < array.length; i++) {
    if (i == currentIndex && !done) {
      fill(standardColor); // Highlight the current element
    } else {
      fill(200);
    }
    rect(150 + i * 350, 440, 200, 200); // Adjusted size and position
    fill(0);
    text(array[i], 150 + i * 350 + 100, 540);
  }

  // Display the sum
  fill(0);
  text("Sum: " + sum, width / 2, 900);

  // Add elements one at a time
  if (frameCount % 15 == 0 && !done) { // Update faster
    if (currentIndex < array.length) {
      sum += array[currentIndex];
      currentIndex++;
    } else {
      done = true; // Stop when all elements are added
      gifExport.finish(); // Finish the GIF
    }
  }
  gifExport.addFrame(); // Add the current frame to the GIF
}

// Restart the summing when mouse is pressed
void mousePressed() {
  sum = 0;
  currentIndex = 0;
  done = false;
  gifExport = new GifMaker(this, "sum_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(20); // Increase GIF speed
}
