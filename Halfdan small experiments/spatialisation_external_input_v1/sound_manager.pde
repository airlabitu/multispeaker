
import oscP5.*;
import netP5.*;
  


class SoundManager{
  Speaker [] speakers = new Speaker[12];
  ArrayList<Sound> sounds  = new ArrayList<Sound>();
  
  final int PIXEL_SCALE = 50; // 50 px = 1 meter in the physical/model world
  
  OscP5 oscP5;
  NetAddress myRemoteLocation;
  
  boolean mouse = false;
  
  PVector sound3_dir;
  
  SoundManager(){
    // row 1
    speakers[0] = new Speaker(1, 1, 1);
    speakers[1] = new Speaker(3, 1, 2);
    speakers[2] = new Speaker(5, 1, 3);
    // row 2
    speakers[3] = new Speaker(1, 4, 4);
    speakers[4] = new Speaker(3, 4, 5);
    speakers[5] = new Speaker(5, 4, 6);
    // row 3
    speakers[6] = new Speaker(1, 7, 7);
    speakers[7] = new Speaker(3, 7, 8);
    speakers[8] = new Speaker(5, 7, 9);
    // row 4
    speakers[9] = new Speaker(1, 10, 10);
    speakers[10] = new Speaker(3, 10, 11);
    speakers[11] = new Speaker(5, 10, 12);
    
    sounds.add(new Sound(1)); // adding a sound with ID = 1
    sounds.add(new Sound(2)); // adding a sound with ID = 2
    sounds.add(new Sound(3)); // adding a sound with ID = 3
    
    oscP5 = new OscP5(this,12000);
    myRemoteLocation = new NetAddress("127.0.0.1",7000); // sending to local IP, PORT 7000
    
    sound3_dir = new PVector(random(-5,5), random(-5,5));
  }
  
  void display(){
    // speakers
    rectMode(CENTER);
    for (int i = 0; i < speakers.length; i++){
      fill(255);
      rect(speakers[i].position.x*50, speakers[i].position.y*50, 30, 30);
      fill(0);
      text(speakers[i].id, speakers[i].position.x*PIXEL_SCALE, speakers[i].position.y*PIXEL_SCALE);
    }
    // sounds
    for (int i = 0; i < sounds.size(); i++){
      noFill();
      stroke(255);
      Sound s = sounds.get(i);
      ellipse(s.position.x*PIXEL_SCALE, s.position.y*PIXEL_SCALE, s.reach*PIXEL_SCALE, s.reach*PIXEL_SCALE);
      fill(255);
      text(s.id, s.position.x*PIXEL_SCALE, s.position.y*PIXEL_SCALE);
      println(i, s.position.x, s.position.y);
    }
    
  }
  
  void moveSounds(){
    if (mouse){
      sounds.get(0).position.x = float(mouseX)/PIXEL_SCALE; // remap to metric scale before storing in objects
      sounds.get(0).position.y = float(mouseY)/PIXEL_SCALE;
      
      sounds.get(1).position.x = float(width-mouseX)/PIXEL_SCALE; // remap to metric scale before storing in objects
      sounds.get(1).position.y = float(height-mouseY)/PIXEL_SCALE;
    }
    else {
      sounds.get(0).position.x = (noise(frameCount * 0.01) * width)/PIXEL_SCALE;
      sounds.get(0).position.y = (noise(frameCount * 0.005 + 1000) * height)/PIXEL_SCALE;
   
      sounds.get(1).position.x = (noise(frameCount * 0.001) * width)/PIXEL_SCALE;
      sounds.get(1).position.y = (noise(frameCount * 0.0005 + 500) * height)/PIXEL_SCALE;
    }
    
    PVector pos = sounds.get(2).position;
    if (pos.x <= -2 || pos.x >= 8 || pos.y <= -2 || pos.y >= 13) { // bounding box
      pos.x = random(1, 6)/PIXEL_SCALE; // new spawn position
      pos.y = random(1, 10)/PIXEL_SCALE;
      sound3_dir.x = random(-4,4)/PIXEL_SCALE; // new direction
      sound3_dir.y = random(-4,4)/PIXEL_SCALE;
    }
    pos.x += sound3_dir.x; // move sound3
    pos.y += sound3_dir.y;
    
    println("X", sounds.get(2).position.x, "Y", sounds.get(2).position.y);
    
  }
  
  void sendVolOSC(){
    for (int i = 0; i < sounds.size(); i++) sendNormalizedVolOSC(sounds.get(i)); // calls 
  }
  
  void sendNormalizedVolOSC(Sound s){
    
    OscMessage myMessage = new OscMessage("/sound/"+s.id);
    //println("sound/"+s.id);
    for (int i = 0; i < speakers.length; i++){
      float val = map(constrain(speakers[i].position.dist(s.position), 0, s.reach), 0, s.reach, 0, -70); // remap to normalised, and flip scale
      //println(i, val);
      myMessage.add(val);
    }
    oscP5.send(myMessage, myRemoteLocation);
    //println();
     
  }
}
