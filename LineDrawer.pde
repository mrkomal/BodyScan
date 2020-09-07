class LineDrawer {
  
  //Declaration of needed constants
  private static final int RIGHT_SIDE_ERROR = 5;
  private static final int LEFT_SIDE_ERROR = -5;
  //Input indexes
  private int point1;
  private int point2;
  //Section properties
  private int rColor;
  private int gColor;
  private int bColor;
  //Points required for computations
  private int startY; 
  private int startX; 
  private int stopY; 
  private int stopX; 
  
  public LineDrawer(int point1, int point2, int rColor, int gColor, int bColor){
    this.point1 = point1+RIGHT_SIDE_ERROR;
    this.point2 = point2+LEFT_SIDE_ERROR;
    this.rColor = rColor;
    this.gColor = gColor;
    this.bColor = bColor;
    calculatePoints();
  }
  
  
  private void calculatePoints() {
    this.startY = point1/640;
    this.startX = point1 - startY*640;
    this.stopY = point2/640;
    this.stopX = point2 - stopY*640;
  }
  
  private void displaySection() {
    createDots();
    drawALine();
  }
  
  
  private void createDots() {
    stroke(rColor,gColor,bColor);
    strokeWeight(20);
    line(startX,startY,startX,startY);
    line(stopX,stopY,stopX,stopY);
  }
  
  
  private void drawALine() {
    stroke(rColor,gColor,bColor);
    strokeWeight(10);
    line(startX,startY,stopX,stopY);
  }
  
}
