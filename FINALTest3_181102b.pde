Flock flock;
Attractor a;

void setup() {
  //size(640, 360);
  background(0);
  fullScreen();
  a = new Attractor(width/2, height/2, 1);
  flock = new Flock();
  for (int i = 0; i < 600; i++) {
    flock.addMover (new Mover(width/2, height/2, random(-i, i), random(-100, 100)));
    
}
}

void draw() {
  
  //frameRate(50);
  if (frameCount < 300) {
  background(0);
  a.display();
  } else {
  noStroke();
  fill (0,0,0,10);
  rect(0,0, width, height);
  }
  flock.run();
 
  
  //println(frameCount);

}
