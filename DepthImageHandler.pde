class DepthImageHandler{
  
  //Declaration of needed constants
  private static final int MINIMUM_VALUE = -16777216;
  private static final int THRESHOLD_VALUE = 1000000;
  private static final int ROW_TOLERANCE = 3;
  private static final int MAX_DISTANCE_NECK_SHOULDER = 50;
  //Image properties
  private PImage depthImage;
  private int imageWidth;
  private int imageHeight;
  private int numberOfPixels;
  //Indexes of body parts
  private int depthRightShoulder;
  private int depthLeftShoulder;
  private int depthRightNeck;
  private int depthLeftNeck;
  private int depthRightWaistLine;
  private int depthLeftWaistLine;
  
  
  public DepthImageHandler(PImage depthImage){
    this.depthImage = depthImage;
    this.imageWidth = depthImage.width;
    this.imageHeight = depthImage.height;
    this.numberOfPixels = imageWidth*imageHeight;
  }
  
  
  private void removeBackground(){
    int maxValue = MINIMUM_VALUE;
  
    for(int i=0; i<numberOfPixels; i++){
      if(depthImage.pixels[i]>maxValue){
        maxValue = depthImage.pixels[i];
      }
    }
  
    for(int i=0; i<numberOfPixels; i++){
      if(depthImage.pixels[i]<=(maxValue-THRESHOLD_VALUE)){
        depthImage.pixels[i]=MINIMUM_VALUE;
      }
    } 
  }
  
  
  private void findBodyParts() {
    findShoulders();
    findNeck();
    findWaistline();
  }
  
  
  private void findNeck() {
    int finalPixel = depthRightShoulder;
    int numberOfRowsToCheck = finalPixel/imageWidth;
    int firstWhitePixelOnTheRight=0;
    int firstWhitePixelOnTheLeft=0;
    int maximalDifferenceOnTheRight=0;
    
    for(int i=0; i<numberOfRowsToCheck*imageWidth; i=(i+imageWidth)) {
      boolean rightPixelIsFound = false;
      for(int indeks=i; indeks<(i+imageWidth); indeks++){
        if(rightPixelIsFound==false){
          if(depthImage.pixels[indeks]!=MINIMUM_VALUE){
            if(indeks-i>maximalDifferenceOnTheRight && finalPixel-indeks<imageWidth*MAX_DISTANCE_NECK_SHOULDER){ 
              firstWhitePixelOnTheRight=indeks;
              maximalDifferenceOnTheRight=indeks-i;
            }
            rightPixelIsFound=true;
          }
        } else {
          if(depthImage.pixels[indeks-1]!=MINIMUM_VALUE && depthImage.pixels[indeks]==MINIMUM_VALUE){
            if(indeks-firstWhitePixelOnTheRight<640*ROW_TOLERANCE){
              int foundLeftPixel = indeks;
              int matchedLeftPixel = subtractUntilNumberIsLowerThan640(foundLeftPixel, firstWhitePixelOnTheRight);
              firstWhitePixelOnTheLeft = matchedLeftPixel;
            }
          }
        }
      }
    }
    this.depthRightNeck = firstWhitePixelOnTheRight;
    this.depthLeftNeck = firstWhitePixelOnTheLeft;
  }
  
  
  private void findWaistline() {
    int finalPixel = depthLeftShoulder;
    int startPixel = ((finalPixel/imageWidth)+1)*imageWidth;
    int firstWhitePixelOnTheRight=0;
    int firstWhitePixelOnTheLeft=0;
    int maximalDifferenceOnTheRight=0;
    
    for(int i=startPixel; i<numberOfPixels; i=(i+imageWidth)) {
      boolean rightPixelIsFound = false;
      for(int indeks=i; indeks<(i+imageWidth); indeks++){
        if(rightPixelIsFound==false){
          if(depthImage.pixels[indeks]!=MINIMUM_VALUE){
            if(indeks-i>maximalDifferenceOnTheRight){ 
              firstWhitePixelOnTheRight=indeks;
              maximalDifferenceOnTheRight=indeks-i;
            }
            rightPixelIsFound=true;
          }
        } else {
          if(depthImage.pixels[indeks-1]!=MINIMUM_VALUE && depthImage.pixels[indeks]==MINIMUM_VALUE){
            if(indeks-firstWhitePixelOnTheRight<640*ROW_TOLERANCE){
              int foundLeftPixel = indeks;
              int matchedLeftPixel = subtractUntilNumberIsLowerThan640(foundLeftPixel, firstWhitePixelOnTheRight);
              firstWhitePixelOnTheLeft = matchedLeftPixel;
            }
          }
        }
      }
    }
    this.depthRightWaistLine = firstWhitePixelOnTheRight;
    this.depthLeftWaistLine = firstWhitePixelOnTheLeft;
  }
  
  
  private void findShoulders() {
    int firstWhitePixelOnTheRight=0;
    int firstWhitePixelOnTheLeft=0;
    int minimalDifferenceOnTheRight=imageWidth;
    
    for(int i=0; i<numberOfPixels; i=(i+imageWidth)) {
      boolean rightPixelIsFound = false;
      //boolean leftPixelIsFound = false;
      for(int indeks=i; indeks<(i+imageWidth); indeks++){
        if(rightPixelIsFound==false){
          if(depthImage.pixels[indeks]!=MINIMUM_VALUE){
            if(indeks-i<minimalDifferenceOnTheRight){ 
              firstWhitePixelOnTheRight=indeks;
              minimalDifferenceOnTheRight=indeks-i;
            }
            rightPixelIsFound=true;
          }
        } else {
          if(depthImage.pixels[indeks-1]!=MINIMUM_VALUE && depthImage.pixels[indeks]==MINIMUM_VALUE){
            if(indeks-firstWhitePixelOnTheRight<640*ROW_TOLERANCE){
              int foundLeftPixel = indeks;
              int matchedLeftPixel = subtractUntilNumberIsLowerThan640(foundLeftPixel, firstWhitePixelOnTheRight);
              firstWhitePixelOnTheLeft = matchedLeftPixel;
            }
          }
        }
      }
    }
    this.depthRightShoulder = firstWhitePixelOnTheRight;
    this.depthLeftShoulder = firstWhitePixelOnTheLeft;
  }
  
  private int subtractUntilNumberIsLowerThan640 (int number, int start) {
    while((number-start) > 640) {
      number = number - 640;
    }
    return number;
  }
    
}
