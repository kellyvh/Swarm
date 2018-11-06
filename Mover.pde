class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  float directionX;
  float directionY;
  float loc;
  float r;
  float maxforce;
  float maxspeed;
  
  Mover(float x, float y, float dX, float dY) {
    location = new PVector (x, y);
    velocity = new PVector (dX,dY);
    
    velocity.normalize();
    velocity.mult(random(0.1, 1));
    velocity.limit(1);

    acceleration = new PVector (0,0);
    mass = 1.0;
    directionX = dX;
    directionY = dY;
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
    
  }
  
  void run(ArrayList<Mover> movers) {
    if (frameCount < 300) {
    limit(a.location);
    } else {
     flock(movers);
     borders();
    }
    update();
    display();
  }
  
  void update() {
    
    location.add(velocity); 
    velocity.add(acceleration);
    acceleration.mult(0);
    
    velocity.limit(maxspeed); //was velocity.limit(5) for bulb
  }
    
   void limit(PVector loc) {
    PVector max = PVector.sub(location, loc);
    float d = max.mag();  
     
    if (d > ((mass * 4) +100)){
      velocity.mult (-1);
      
    }
   }
   

  void flock(ArrayList<Mover> boids) {
    PVector sep = separate(boids);   
    PVector ali = align(boids);      
    PVector coh = cohesion(boids);   
    
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.5);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

 PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  
    // Scale to max speed
    desired.normalize();
    desired.mult(maxspeed);

   
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  
    return steer;
  }

// Wraparound
  void borders() {
    if (location.x < 100){
      velocity.mult(-1);
    }
    if (location.y < 100){
      velocity.mult(-1);
    }
    if (location.x > width-100){
      velocity.mult(-1);
    }
    if (location.y > height-100){
      velocity.mult(-1);
    }
  }

  // Separation
  PVector separate (ArrayList<Mover> movers) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    
    for (Mover other : movers) {
      float d = PVector.dist(location, other.location);
      
      if ((d > 0) && (d < desiredseparation)) {
        
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;            
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  PVector align (ArrayList<Mover> movers) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Mover other : movers) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  PVector cohesion (ArrayList<Mover> movers) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   
    int count = 0;
    for (Mover other : movers) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); 
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  
    } 
    else {
      return new PVector(0, 0);
    }
  }



  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
    acceleration.limit(2);
    
  }
  
  void display() {
    fill(255);
    noStroke();
    ellipse(location.x, location.y, mass*2, mass*2);  
 
  }
}
