int TICKRATE = 30;

class Group extends Thread {
  // Threading stuff
  private Thread t;
  int id;

  volatile boolean wait = false;


  Group(int id) { //New random game
    this.id = id;
  }

  void runLoop() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        try {
          float n = 0, nc = 0;
          for (int k = -1; k < 2; k++) {
            for (int l = -1; l < 2; l++) {
              float x = cells[i-k][j-l].curr;
              n += x;
              nc += x*sqrt(n);
            }
          }
          //println(nc, n);
          cells[i][j].next = n<2?0:n<=3?sig(nc, n)/(2*constrain(cells[i][j].curr, 0.1, 0.8)):0;
          //cells[i-2][j].update();
        }
        catch(IndexOutOfBoundsException e) {
        }
      }
    }

    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j].update();
        cells[i][j].reset();
      }
    }
    //wait = true;
  }

  public void run() { //Overrides super.run(), is called by the thread;
    while (true) {
      if (wait) {
        continue;
      }
      println(wait);
      int startTime = millis();
      try {
        runLoop();
        delay(constrain(1000/TICKRATE-(millis()-startTime), 0, 1000));
      }
      catch(ThreadDeath e) {
        println("Something happened");
      }
    }
  }

  public Group create() { //Overrides super.create(), makes everything GO
    if (t == null) {
      t = new Thread(this, str(id));
      t.start();
    }
    return this;
  }
}

float sig(float x, float a) {
  return 1/(1+exp(x-a)*4/a);
}
