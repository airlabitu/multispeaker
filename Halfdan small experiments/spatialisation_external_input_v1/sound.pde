
class Sound{
  PVector position;
  int id;
  float reach = 7; // in meters
  
  Sound(int id_){
    id = id_;
    position = new PVector(0,0);
  }
  
  void updatePosition(float x, float y){
    position.x = x;
    position.y = y;
  }
  
}
