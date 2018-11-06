class Flock {
  ArrayList<Mover> movers;
  
  Flock() {
    movers = new ArrayList<Mover>();

  }
  
  void run() {
    for (Mover m : movers) {
       m.run(movers);
    }
    
  }
  
  void addMover (Mover m) {
    movers.add(m);
    
  }
  
  
  
}
