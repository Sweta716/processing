import gifAnimation.*;

GifMaker gifExport;

int[] array = {10, 20, 30, 40, 50};  // Example array
int selectedIndex = 0;               // Index of the element to access
boolean done = false;                // Flag to indicate if the animation is done

color standardColor = color(41, 116, 150); // Blue 004

PFont lato;

void setup() {
  size(1920, 1080);
  lato = createFont("C:\\sweta\\processing\\processing\\data\\lato\\Lato-Regular.ttf", 32);
  textFont(lato);
  textAlign(CENTER, CENTER);
  gifExport = new GifMaker(this, "access_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(20); // Increase GIF speed
}

void draw() {
  background(255);
  displayArray();
  gifExport.addFrame(); // Add the current frame to the GIF

  if (frameCount % 30 == 0 && !done) { // Change element every 30 frames
    if (selectedIndex < array.length - 1) {
      selectedIndex++;
    } else {
      selectedIndex = 0; // Loop back to the first element
    }
  }
}

void displayArray() {
  for (int i = 0; i < array.length; i++) {
    if (i == selectedIndex) fill(standardColor); // Highlight the accessed element
    else fill(200);
    rect(150 + i * 350, 440, 200, 200); // Adjusted size and position
    fill(0);
    text(array[i], 150 + i * 350 + 100, 540);
  }
}

// Restart the animation when mouse is pressed
void mousePressed() {
  selectedIndex = 0;
  done = false;
  gifExport = new GifMaker(this, "access_animation.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(20); // Increase GIF speed
}
