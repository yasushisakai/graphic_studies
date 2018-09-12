import ai.pathfinder.*;

class RoadNetwork {

  Pathfinder astar;
  ArrayList<Node> nodes; // redundant!

  RoadNetwork (int row) {
    this.astar = new Pathfinder();
    this.nodes = new ArrayList<Node>();
    
    for(int i = 0; i < pow(row, 2); i++){
      this.nodes.add(new Node(i % row * (width / row), i/row * (width / row)));
    }

    for (int i = 0; i < pow(row, 2); i++){
      int x = i % row;
      int y = i / row;
      
      if(x < row - 1) {
        int leftNode = x + 1 + y * row;
        this.nodes.get(i).connectBoth(this.nodes.get(leftNode));
      } 

      if(y < row - 1) {
        int lowerNode = x + (y + 1) * row;
        this.nodes.get(i).connectBoth(this.nodes.get(lowerNode));
      }
    }

    this.astar.addNodes(this.nodes);
  }

  void drawNodes(){
    for(Node n: (ArrayList<Node>)this.astar.nodes) {
      pushStyle();
      noFill();
      point(n.x, n.y);
      ellipse(n.x, n.y, 9, 9);  
      popStyle();
    } 
  }

  void showPath(int start, int end) {
    ArrayList<Node> path = this.astar.aStar(
      (Node) this.nodes.get(start),
      (Node) this.nodes.get(end)
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
        (Node)this.nodes.get(start),
        (Node)this.nodes.get(end)
        ); 

   return new PolyCurve(vertices); 
  }

}
