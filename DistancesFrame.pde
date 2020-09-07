class DistancesFrame {
  
  //Declaration of unit of measure
  private String unitOfMeasure = "cm";
  //Decleration of output Strings
  private String shoulderText = "Distance between your shoulders: ";
  private String neckText = "Thickness of your neck: ";
  private String waistText = "Thickness of your waistline: ";
  //Input distances
  private String shoulderDistance;
  private String neckDistance;
  private String waistlineDistance;
  //Font properties
  private int textSize = 32;
  
  
  public DistancesFrame (String shoulderDistance, String neckDistance, String waistlineDistance) {
    this.shoulderDistance = shoulderDistance;
    this.neckDistance = neckDistance;
    this.waistlineDistance = waistlineDistance;
  }
  
  
  private void displayFrame() {
      //setting font
      textSize(textSize);
      //neck properties
      fill(0,100,0);
      text(neckText,100,540);
      text(neckDistance,700,540);
      text(unitOfMeasure,850,540);
      //shoulder properties
      fill(200,0,0);
      text(shoulderText,100,590);
      text(shoulderDistance,700,590);
      text(unitOfMeasure,850,590);
      //waistline properties
      fill(0,0,200);
      text(waistText,100,640);
      text(waistlineDistance,700,640);
      text(unitOfMeasure,850,640);
  }
  
}
