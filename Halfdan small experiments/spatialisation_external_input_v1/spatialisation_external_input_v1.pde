/* ToDO
- Create an OSC bridge to Max
- Send a 9 channel message for each sound, adressing how much volume (0-1) the given sound has in each speaker
*/

SoundManager sm;

void setup(){
  size(6*50, 11*50);
  sm = new SoundManager();  
}

void draw(){
  background(0);
  sm.moveSounds();
  sm.sendVolOSC();
  sm.display();
}

void keyReleased(){
  if (key == 'm') sm.mouse = ! sm.mouse;   
}
