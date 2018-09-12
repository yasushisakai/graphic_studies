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
    PolyCurve newCurve = this.roadNetwork.getRandomCurve();
    return new MobilityAgent(newCurve, 0.1);
  }

  private MobilityAgent createAgent(int from, int to){
    PolyCurve newCurve = this.roadNetwork.getCurve(from, to);
    return new MobilityAgent(newCurve, 0.1);
  }

  void update(){
    for(int i = 0; i < this.agents.size(); i++){
      MobilityAgent agent = this.agents.get(i);
      if(!agent.isVisible) {
        agent = this.createRandomAgent();
        this.agents.set(i, agent);
      }

      for(int j = i + 1; j < this.agents.size(); j++){
        MobilityAgent jAgent = this.agents.get(j);
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
