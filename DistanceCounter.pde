class DistanceCounter {
  
  //linear funtion to change pixels to cm (y = Ax + B)
  private final static float A = 0.2432f;
  private final static float B = 0;
  //points
  private int point1;
  private int point2;
  
  public DistanceCounter(int point1, int point2){
    this.point1 = point1;
    this.point2 = point2;
  }
  
  private String distanceTo1stDecimalPoint() {
    String distance = String.valueOf(calculateDistanceInCm());
    String[] valuesArray = distance.split("\\.");
    String[] decimalValues = valuesArray[1].split("");
    String beforeDecimal = valuesArray[0];
    String afterDecimal = decimalValues[0];
    return beforeDecimal+"."+afterDecimal;
  }
  
  private float calculateDistanceInCm(){
    float distanceInPixels = calculateDistanceinPixels();
    return distanceInPixels*A+B;
  }
  
  private int calculateDistanceinPixels(){
    return point2-point1;
  }
  
}
