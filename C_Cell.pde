class Cell{
  float next = 0;
  float curr;
  
  Cell(){
    curr = random(0.4);
  }
  
  void update(){
    curr = constrain(next, 0, 1);
  }
  
  void reset(){
    next = 0;
  }
}
