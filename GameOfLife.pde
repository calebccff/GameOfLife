int pw = 160;
int ph = 90;

Cell[][] cells = new Cell[pw][ph];

PGraphics pg;
float SCREEN_SCALE;
ArrayList<Group> groups = new ArrayList<Group>();

void setup() {
  fullScreen();
  //size(800, 450);
  noSmooth();
  //frameRate(2);
  pg = createGraphics(pw, ph);
  SCREEN_SCALE = min((float)width/(float)pg.width, (float)height/(float)pg.height);
  imageMode(CENTER);

  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      cells[i][j] = new Cell();
    }
  }

  for (int i = 0; i < 1; i+=2) {
    groups.add(new Group(i).create());
  }
}

void draw() {
  pg.beginDraw();
  pg.background(0);
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      pg.stroke(cells[i][j].curr*255);
      pg.point(i, j);
    }
  }
  pg.endDraw();
  image(pg, width/2, height/2, SCREEN_SCALE*(float)pg.width, SCREEN_SCALE*(float)pg.height);
  fill(255, 0, 0);
  String t = "";
  for(Group g : groups){
    t += g.wait+"\n";
  }
  text(t+"\n"+frameRate, 10, 10);

  boolean finished = true;
  for (Group g : groups) {
    finished = g.wait;
    if (!finished) break;
  }

  if (finished) {
    

    for (Group g : groups) {
      println(g.wait);
      g.wait = false;
    }
    println("--------");
  }
}
