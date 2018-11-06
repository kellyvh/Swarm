class Attractor {
  float mass;
  PVector location;
  float G;
  float x;
  float y;
  float m;
 
 Attractor(float x, float y, float m) {
    location = new PVector (x, y);
    mass = m;
    G = 5;
    //x = random (150, width-150);
    //y = random (150, height-150);
  }
  
  
   void display() {
    fill(0, 0, 0, 0);
    mass += 0.02;
    mass = constrain(mass, 0, 50);
    ellipse (location.x, location.y, mass*2, mass*2);
    
    noStroke();
    
    
  }
  
  //Gravitational Attraction Formula
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 30.00);
    force.normalize();
    
    float strength = (G * mass * m.mass)/(distance * distance);
    
    
    if (distance > mass * 4) {
      force.mult(strength); 
      force.mult(0);
      
    }
    else if (distance < mass * 4) {
      
      force.mult(-1*strength); 
      force.mult(0);
    }
    
 
    return force;
    // if (distance > ((mass * 4)+100)) {
    //  force.mult(-1); 
    //}return force;
    
    
    
    
  }
  
  
}
