import java.util.Collections;

ArrayList<Person> men = new ArrayList<Person>();
ArrayList<Person> women = new ArrayList<Person>();
boolean finished = false;
String statusText = "";

void setup() {
  size(800, 400);
  for (int i = 0; i < 5; i++) {
    men.add(new Person("M" + i, true, 100, 50 + i * 60));
    women.add(new Person("W" + i, false, 300, 50 + i * 60));
  }
  for (Person man : men) {
    man.generatePreferences(women);
  }
  for (Person woman : women) {
    woman.generatePreferences(men);
  }
  textSize(12);
  frameRate(0.5); // Adjust speed here, lower is slower
}

void draw() {
  background(255);
  for (Person man : men) {
    man.display();
  }
  for (Person woman : women) {
    woman.display();
  }
  
  // Draw lines for current matches
  for (Person man : men) {
    if (man.isMatched) {
      stroke(0, 255, 0); // Green line for match
      line(man.x, man.y, man.currentPartner.x, man.currentPartner.y);
    }
  }
  
  fill(0);
  text(statusText, 10, 360);
  
  if (!finished) {
    finished = performOneStep();
  }
}

boolean performOneStep() {
  boolean allMatched = true;
  for (Person man : men) {
    if (!man.isMatched) {
      allMatched = false;
      Person preferred = man.getMostPreferred();
      if (preferred != null) {
        man.propose(preferred);
        if (man.isMatched) {
          statusText = man.name + " proposes to " + preferred.name + ", accepted";
        } else {
          statusText = man.name + " proposes to " + preferred.name + ", rejected";
          stroke(255, 0, 0); // Red line for rejection
          line(man.x, man.y, preferred.x, preferred.y);
        }
        break; // Only one proposal per frame
      }
    }
  }
  return allMatched;
}

class Person {
  String name;
  boolean isMan;
  int x, y;
  boolean isMatched = false;
  ArrayList<Person> preferences = new ArrayList<Person>();
  Person currentPartner = null;

  Person(String n, boolean gender, int px, int py) {
    name = n;
    isMan = gender;
    x = px;
    y = py;
  }

  void generatePreferences(ArrayList<Person> others) {
    preferences.addAll(others);
    Collections.shuffle(preferences); // Randomize preferences
  }

  Person getMostPreferred() {
    for (Person p : preferences) {
      if (!p.isMatched || p.currentPartner != this) {
        return p;
      }
    }
    return null; // No more preferences available
  }

  void propose(Person woman) {
    if (woman.currentPartner == null || woman.prefers(this)) {
      if (woman.currentPartner != null && woman.currentPartner != this) {
        woman.currentPartner.isMatched = false;
        woman.currentPartner.currentPartner = null;
      }
      currentPartner = woman;
      woman.currentPartner = this;
      isMatched = true;
    } else {
      isMatched = false;
    }
  }

  boolean prefers(Person newSuitor) {
    return preferences.indexOf(newSuitor) < preferences.indexOf(currentPartner);
  }

  void display() {
    fill(isMatched ? color(0, 255, 0) : color(255, 0, 0));
    ellipse(x, y, 40, 40);
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, x, y);
  }
}
