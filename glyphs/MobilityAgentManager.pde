class MobilityAgentManager {
  ArrayList<MobilityAgent> agents;
  RoadNetwork roadNetwork;

  MobilityAgentManager(int numAgents,RoadNetwork roadNetwork) {
    this.agents = new ArrayList<MobilityAgent>();
    this.roadNetwork = roadNetwork;

    for(int i = 0; i < numAgents; i++) {
      this.agents.add(this.createRandomAgent());   
    }
  }

  private MobilityAgent createRandomAgent() {
    switch(int(random(3))){
      case 0:
        return this.createPedestrian();
      case 1:
        return this.createCar();
      case 2:
        return this.createPEV();
      default:
        return this.createPedestrian();
    }
  }

  // TODO: enum
  private MobilityAgent createPedestrian(){
    return new MobilityAgent("pedestrian", human, 0.1, 0, 2);
  }

  private MobilityAgent createPEV(){
    return new MobilityAgent("PEV", new Glyph[]{PEV, bike}, 2, 15, 12);
  }
  
  private MobilityAgent createCar(){
    return new MobilityAgent("car", new Glyph[]{car}, 3, 20, 5);
  }

  void update(){
    for(int i = 0; i < this.agents.size(); i++){
      MobilityAgent agent = this.agents.get(i);

      if(!agent.isVisible) {
        agent.setPath(this.roadNetwork.getRandomCurve());
      }

      
      for(int j = i + 1; j < this.agents.size(); j++){
        MobilityAgent jAgent = this.agents.get(j);
        if(!jAgent.isVisible) continue;
        PVector iPos = agent.pos;
        PVector jPos = jAgent.pos;
        if(PVector.dist(iPos, jPos) < 40 && agent.velocity < jAgent.velocity) {
          // println(i + "switched State to 2");
          agent.switchState(2);
        } else {
          agent.switchState(1);
        }
      }
      

      agent.update();
    } 
  }

  void draw() {
    for(int i = 0; i< this.agents.size(); i++){
      this.agents.get(i).draw();
    }
  }
}
