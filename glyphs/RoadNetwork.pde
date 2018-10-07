import ai.pathfinder.*;

class RoadNetwork {

  Pathfinder astar;
  RoadNetwork (int row, int majorEvery) {
    this.astar = new Pathfinder();
    ArrayList<Node> nodes = new ArrayList<Node>();
    
    for(int i = 0; i < pow(row, 2); i++){
      nodes.add(new Node(i % row * (width / row), i/row * (width / row)));
    }

    for (int i = 0; i < pow(row, 2); i++){
      int x = i % row;
      int y = i / row;

      // connecting right
      if((y % majorEvery == 0 || y == row - 1) && x < row - 1) {
        int leftNode = x + 1 + y * row;
        nodes.get(i).connectBoth(nodes.get(leftNode));
      } 
      // connecting below
      if((x % majorEvery == 0 || x == row - 1) && y < row - 1) {
        int lowerNode = x + (y + 1) * row;
        nodes.get(i).connectBoth(nodes.get(lowerNode));
      }
    }

    for(int i = 0; i < nodes.size(); i++){
      Node n = (Node) nodes.get(i);
      if(n.links.size() == 0){
        nodes.remove(i);
        i--;
      }
    }

    this.astar.addNodes(nodes);
  }

  void drawNodes(){
    for(Node n: (ArrayList<Node>)this.astar.nodes) {
      pushStyle();
      noFill();
      // point(n.x, n.y);
      ellipse(n.x, n.y, 3, 3);  
      popStyle();
    } 
  }

  void drawConnections(){
    for(int i=0; i<this.astar.nodes.size(); i++){
      Node n = (Node)this.astar.nodes.get(i);
      for(int j = 0; j < n.links.size(); j++){
        Connector c = (Connector) n.links.get(j); 
        line(n.x, n.y, c.n.x, c.n.y);
      }
    }
  }

  void showPath(int start, int end) {
    ArrayList<Node> path = this.astar.aStar(
      (Node) this.astar.nodes.get(start),
      (Node) this.astar.nodes.get(end)
    );

    for(int i=0;i<path.size()-1;i++){
      Node n = path.get(i);
      Node m = path.get(i + 1);

      line(n.x, n.y, m.x, m.y);
    }
    
  }

  PolyCurve getRandomCurve(){
    int start = int(random(this.astar.nodes.size()));
    int end = (start + 1 + int(random(this.astar.nodes.size() - 1))) % this.astar.nodes.size();
    return this.getCurve(start, end);
  }

  PolyCurve getCurve(int start, int end){
    ArrayList<Node> vertices = this.astar.aStar(
        (Node)this.astar.nodes.get(start),
        (Node)this.astar.nodes.get(end)
        ); 

    ArrayList<Node> cleanNodes = new ArrayList<Node>();
    cleanNodes.add(vertices.get(0));

    PVector s = nodeToPVec(vertices.get(0));
    PVector m = nodeToPVec(vertices.get(1));
    PVector e;

    for(int i = 2; i<vertices.size(); i++){
      e = nodeToPVec(vertices.get(i));

      PVector dir0 = PVector.sub(m, s);
      PVector dir1 = PVector.sub(e, m);
      float angle = PVector.angleBetween(dir0, dir1);

      if (angle != 0.0) {
        cleanNodes.add(vertices.get(i - 1));
      }

      s = m;
      m = e;
    }

    cleanNodes.add(vertices.get(vertices.size() - 1));

   return new PolyCurve(cleanNodes); 
  }

}
