/* ToDO
 - Create an OSC bridge to Max
 - Send a 9 channel message for each sound, adressing how much volume (0-1) the given sound has in each speaker
 */
import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

Speaker [] speakers = new Speaker[12];

boolean mapping = false;

int reach = 250;

void setup() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, -1, "Bus 1"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
  size(6*50, 11*50);
  //sm = new SoundManager();
  
  speakers[0] = new Speaker(50, 50, 1);
  speakers[1] = new Speaker(150, 50, 2);
  speakers[2] = new Speaker(250, 50, 3);

  // row 2
  speakers[3] = new Speaker(50, 200, 4);
  speakers[4] = new Speaker(150, 200, 5);
  speakers[5] = new Speaker(250, 200, 6);
  // row 3

  speakers[6] = new Speaker(50, 350, 7);
  speakers[7] = new Speaker(150, 350, 8);
  speakers[8] = new Speaker(250, 350, 9);
  // row 4

  speakers[9] = new Speaker(50, 500, 10);
  speakers[10] = new Speaker(150, 500, 11);
  speakers[11] = new Speaker(250, 500, 12);
}

void draw() {
  background(0);
  //sm.moveSounds();
  //sm.sendVolOSC();
  //sm.display();
  display();
  println();
  for (int i = 0; i < speakers.length; i++){
    float distance = dist(speakers[i].position.x, speakers[i].position.y, mouseX, mouseY);
    //println(i, speakers[i].id, distance);
    distance = constrain(distance, 0, reach);
    //println(i, speakers[i].id, distance);
    if (!mapping) myBus.sendControllerChange(0, i+1, int(map(distance, 0, reach, 127, 20)));
    //println(i, int(map(distance, 0, reach, 127, 0)));
  }
  
  
  
}

/*
void keyReleased() {
  if (key == 'm') sm.mouse = ! sm.mouse;
}
*/


void display() {
  // speakers
  rectMode(CENTER);
  for (int i = 0; i < speakers.length; i++) {
    fill(255);
    rect(speakers[i].position.x, speakers[i].position.y, 30, 30);
    fill(0);
    text(speakers[i].id, speakers[i].position.x, speakers[i].position.y);
  }
  noFill();
  stroke(255);
  ellipse(mouseX, mouseY, reach, reach);
}

void keyReleased(){
  if (key == '1') myBus.sendControllerChange(0, 1, 0);
  if (key == '2') myBus.sendControllerChange(0, 2, 0);
  if (key == '3') myBus.sendControllerChange(0, 3, 0);
  if (key == '4') myBus.sendControllerChange(0, 4, 0);
  if (key == '5') myBus.sendControllerChange(0, 5, 0);
  if (key == '6') myBus.sendControllerChange(0, 6, 0);
  if (key == '7') myBus.sendControllerChange(0, 7, 0);
  if (key == '8') myBus.sendControllerChange(0, 8, 0);
  if (key == '9') myBus.sendControllerChange(0, 9, 0);
  if (key == '0') myBus.sendControllerChange(0, 10, 0);
  if (key == 'p') myBus.sendControllerChange(0, 11, 0);
  if (key == 'l') myBus.sendControllerChange(0, 12, 0);
  if (key == 'm') mapping = !mapping;
  println(mapping);
}
