import gifAnimation.*;
import java.util.Collections;

ArrayList<Person> students = new ArrayList<Person>();
ArrayList<Person> programs = new ArrayList<Person>();
boolean finished = false;
String statusText = "";

GifMaker gifExport;

void setup() {
  size(1920, 1080);
  String[] studentNames = {"Alice", "Bob", "Charlie", "David", "Eve"};
  String[] programNames = {"Residency A", "Residency B", "Residency C", "Residency D", "Residency E"};
  
  for (int i = 0; i < studentNames.length; i++) {
    students.add(new Person(studentNames[i], true, 200, 100 + i * 180));
    programs.add(new Person(programNames[i], false, 1720, 100 + i * 180));
  }
  for (Person student : students) {
    student.generatePreferences(programs);
  }
  for (Person program : programs) {
    program.generatePreferences(students);
  }
  
  textSize(32);
  frameRate(0.5); // Slow down for better visualization

  gifExport = new GifMaker(this, "gale_shapley_visualization.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(10);
  gifExport.setDelay(100); // Slower GIF speed
}

void draw() {
  background(255);
  for (Person student : students) {
    student.display();
  }
  for (Person program : programs) {
    program.display();
  }
  
  // Draw lines for current matches
  for (Person student : students) {
    if (student.isMatched) {
      stroke(26, 69, 56); // Green 005 line for match
      strokeWeight(4);
      line(student.x + 50, student.y, student.currentPartner.x - 50, student.currentPartner.y);
    }
  }
  
  fill(0);
  text(statusText, 10, 1060);
  
  if (!finished) {
    finished = performOneStep();
  }

  gifExport.addFrame(); // Add the current frame to the GIF
  if (finished) {
    gifExport.finish(); // Finish the GIF once done
  }
}

boolean performOneStep() {
  boolean allMatched = true;
  for (Person student : students) {
    if (!student.isMatched) {
      allMatched = false;
      Person preferredProgram = student.getMostPreferred();
      if (preferredProgram != null) {
        student.propose(preferredProgram);
        if (student.isMatched) {
          statusText = student.name + " proposes to " + preferredProgram.name + ", accepted";
        } else {
          statusText = student.name + " proposes to " + preferredProgram.name + ", rejected";
          stroke(255, 0, 0); // Red line for rejection
          strokeWeight(2);
          line(student.x + 50, student.y, preferredProgram.x - 50, preferredProgram.y);
        }
        break; // Only one proposal per frame
      }
    }
  }
  return allMatched;
}

class Person {
  String name;
  boolean isStudent;
  int x, y;
  boolean isMatched = false;
  ArrayList<Person> preferences = new ArrayList<Person>();
  Person currentPartner = null;

  Person(String n, boolean type, int px, int py) {
    name = n;
    isStudent = type;
    x = px;
    y = py;
  }

  void generatePreferences(ArrayList<Person> others) {
    preferences.addAll(others);
    Collections.shuffle(preferences); // Randomize preferences
  }

  Person getMostPreferred() {
    for (Person p : preferences) {
      if (!p.isMatched || p.prefers(this)) {
        return p;
      }
    }
    return null; // No more preferences available
  }

  void propose(Person program) {
    if (program.currentPartner == null || program.prefers(this)) {
      if (program.currentPartner != null && program.currentPartner != this) {
        program.currentPartner.isMatched = false;
        program.currentPartner.currentPartner = null;
      }
      currentPartner = program;
      program.currentPartner = this;
      isMatched = true;
    } else {
      isMatched = false;
    }
  }

  boolean prefers(Person newSuitor) {
    return preferences.indexOf(newSuitor) < preferences.indexOf(currentPartner);
  }

  void display() {
    fill(isMatched ? color(26, 69, 56) : color(255, 184, 56)); // Green 005 for matched, Yellow 004 for unmatched
    ellipse(x, y, 100, 100);
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, x, y);
  }
}
