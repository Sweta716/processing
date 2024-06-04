class Item {
  float weight;
  float value;
  float ratio;
  color col;

  Item(float weight, float value, color col) {
    this.weight = weight;
    this.value = value;
    this.ratio = value / weight;
    this.col = col;
  }
}

ArrayList<Item> items = new ArrayList<Item>();
float[] selectedWeights;
float knapsackCapacity = 100;
float currentWeight = 0;
float currentValue = 0;
int step = 0;

void setup() {
  size(1920, 1080);
  items.add(new Item(10, 60, color(255, 0, 0)));  // Add some items (weight, value, color)
  items.add(new Item(20, 100, color(0, 255, 0)));
  items.add(new Item(30, 120, color(0, 0, 255)));
  items.add(new Item(25, 75, color(255, 255, 0)));
  items.add(new Item(15, 45, color(255, 0, 255)));
  items.add(new Item(10, 40, color(0, 255, 255)));
  items.sort((a, b) -> Float.compare(b.ratio, a.ratio));  // Sort items by value-to-weight ratio
  selectedWeights = new float[items.size()];
  frameRate(1);
}

void draw() {
  background(255);
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Visualizing Fractional Knapsack Problem", 50, 40);
  text("Knapsack Capacity: " + knapsackCapacity, 50, 80);
  text("Current Weight: " + currentWeight, 50, 110);
  text("Current Value: " + currentValue, 50, 140);

  textSize(20);
  for (int i = 0; i < items.size(); i++) {
    Item item = items.get(i);
    fill(item.col);
    text("Item " + (i + 1) + ": Weight = " + item.weight + ", Value = " + item.value + ", Ratio = " + nf(item.ratio, 0, 2), 50, 180 + i * 30);
  }

  visualizeKnapsack();
  if (step < items.size()) {
    addItemToKnapsack();
    step++;
    saveFrame("frames/frame-######.png");
  } else {
    noLoop();
  }
}

void visualizeKnapsack() {
  float knapsackX = 600;
  float knapsackY = 200;
  float knapsackWidth = 300;
  float knapsackHeight = 600;

  // Draw the knapsack
  fill(200);
  rect(knapsackX, knapsackY, knapsackWidth, knapsackHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Knapsack", knapsackX + knapsackWidth / 2, knapsackY - 20);

  float currentY = knapsackY + knapsackHeight;

  for (int i = 0; i < step; i++) {
    float itemHeight = (selectedWeights[i] / knapsackCapacity) * knapsackHeight;
    fill(items.get(i).col, 150);
    rect(knapsackX, currentY - itemHeight, knapsackWidth, itemHeight);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Item " + (i + 1) + " (" + nf(selectedWeights[i], 0, 2) + ")", knapsackX + knapsackWidth / 2, currentY - itemHeight / 2);
    currentY -= itemHeight;
  }
}

void addItemToKnapsack() {
  if (step >= items.size()) return;

  Item item = items.get(step);
  float availableCapacity = knapsackCapacity - currentWeight;
  float weightToAdd = min(item.weight, availableCapacity);
  selectedWeights[step] = weightToAdd;
  currentWeight += weightToAdd;
  currentValue += weightToAdd * item.ratio;
}
