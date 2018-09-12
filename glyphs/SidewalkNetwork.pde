import ai.pathfinder.*;

class SidewalkNetwork extends RoadNetwork{

  SidewalkNetwork(int row, int majorEvery){
    super(row, majorEvery);
    this.astar = new Pathfinder();
    int offset = 20;
    ArrayList<Line> lines = new ArrayList<Line>();
    int majorRow = (row - 1) / majorEvery;
    for(int i =0; i <= majorRow; i++){
      float x = i * ((width / row) * 6); // FIXME: hardcoded!!
      lines.add(new Line(x - offset, 0, x - offset, (row - 1) * (height / row)));
      lines.add(new Line(x + offset, 0, x + offset, (row - 1) * (height / row)));

      float y = i * ((height / row) * 6); // FIXME: this too
      lines.add(new Line(0, y - offset, (row - 1) * (width / row), y - offset));
      lines.add(new Line(0, y + offset, (row - 1) * (width / row), y + offset));
    }

    for(int i = 0; i < lines.size(); i++){
      ArrayList<PVector> points = lines.get(i).divide(30);   
      ArrayList<Node> nodes = new ArrayList<Node>();
      for(int j = 0;j < points.size(); j++){
        PVector p = (PVector) points.get(j);
        nodes.add(new Node(p.x, p.y));   
      }
      for(int j = 1; j < nodes.size(); j++){
        Node n = (Node)nodes.get(j-1);
        Node m = (Node)nodes.get(j);
        n.connectBoth(m);
      }
      this.astar.addNodes(nodes);
    }

    for(int i = 0; i < this.astar.nodes.size(); i++){
      Node n = (Node) this.astar.nodes.get(i);
      for(int j = i; j < this.astar.nodes.size(); j++){
        Node m = (Node) this.astar.nodes.get(j);
        float distance = dist(n.x, n.y, m.x, m.y);
        if (distance < offset* 1.5){
          n.connectBoth(m);
        }
      }
    }
  }

  // void drawLines() {
  //   for(int i=0;i<lines.size();i++){
  //     lines.get(i).draw();
  //   }  
  // }

}
