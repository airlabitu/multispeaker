class Speaker{
  PVector position; // position NB: z can be used to implement height if needed at a later time
  int id;
  
  Speaker(int x, int y, int id_){
    position = new PVector(x, y);
    id = id_;
  }
}
