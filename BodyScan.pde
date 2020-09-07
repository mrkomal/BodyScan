import kinect4WinSDK.Kinect;

import java.io.FileInputStream;
import java.io.FileOutputStream;

private Kinect kinect;

private DepthImageHandler depthImageHandler;
private LineDrawer shoulderLineDrawer;
private LineDrawer neckLineDrawer;
private LineDrawer waistlineLineDrawer;
private DistanceCounter shoulderDistanceCounter;
private DistanceCounter neckDistanceCounter;
private DistanceCounter waistlineDistanceCounter;

private DistancesFrame distancesFrame;
private Button saveButton;

void setup()
{
  //Setting the size of displaying window
  size(1280, 700);
  
  //Creating new Kinect object
  kinect = new Kinect(this);
  
  //Save button
  saveButton = new Button("SAVE");
}

void draw()
{
  //Setting the colour of background
  background(180);
  
  //Camera image
  PImage cameraImage = kinect.GetImage();
  image(cameraImage,0,0);
  
  //Depth image
  PImage depthImage = kinect.GetDepth(); 
  depthImageHandler = new DepthImageHandler(depthImage);
  //Focusing on scanned person
  depthImageHandler.removeBackground();
  image(depthImage,640,0);
  
  //Defining position of desirable body parts
  depthImageHandler.findBodyParts();
  //Shoulders
  int rightShoulder = depthImageHandler.depthRightShoulder;
  int leftShoulder = depthImageHandler.depthLeftShoulder;
  //Neck
  int rightNeck = depthImageHandler.depthRightNeck;
  int leftNeck = depthImageHandler.depthLeftNeck;
  //Waistline
  int rightWaistline = depthImageHandler.depthRightWaistLine;
  int lefttWaistline = depthImageHandler.depthLeftWaistLine;
  
  //Creating sections that connect given points
  //Shoulders
  shoulderLineDrawer = new LineDrawer(rightShoulder, leftShoulder, 200, 0, 0);
  shoulderLineDrawer.displaySection();
  //Neck
  neckLineDrawer = new LineDrawer(rightNeck, leftNeck, 0, 100, 0);
  neckLineDrawer.displaySection();
  //Waist  
  waistlineLineDrawer = new LineDrawer(rightWaistline, lefttWaistline, 0, 0, 200);
  waistlineLineDrawer.displaySection();
  
  /*
  //Distances for calibration (does not required later)
  shoulderDistanceCounter = new DistanceCounter(rightShoulder, leftShoulder);
  String shoulderDistance = String.valueOf(shoulderDistanceCounter.calculateDistanceinPixels());
  //Neck
  neckDistanceCounter = new DistanceCounter(rightNeck, leftNeck);
  String neckDistance = String.valueOf(neckDistanceCounter.calculateDistanceinPixels());
  //Waist
  waistlineDistanceCounter = new DistanceCounter(rightWaistline, lefttWaistline);
  String waistlineDistance = String.valueOf(waistlineDistanceCounter.calculateDistanceinPixels());
  */
  
  //Calculating distances in cm
  //Shoulders
  shoulderDistanceCounter = new DistanceCounter(rightShoulder, leftShoulder);
  String shoulderDistance = shoulderDistanceCounter.distanceTo1stDecimalPoint();
  //Neck
  neckDistanceCounter = new DistanceCounter(rightNeck, leftNeck);
  String neckDistance = neckDistanceCounter.distanceTo1stDecimalPoint();
  //Waist
  waistlineDistanceCounter = new DistanceCounter(rightWaistline, lefttWaistline);
  String waistlineDistance = waistlineDistanceCounter.distanceTo1stDecimalPoint();
  
  //Frame for displaying distances
  distancesFrame = new DistancesFrame(shoulderDistance, neckDistance, waistlineDistance);
  distancesFrame.displayFrame();
  
  //Save button
  saveButton.displayButton();
 
  //Saving
  if (mousePressed && saveButton.isMouseInsideButton()) {
    String[] distancesArray = {neckDistance, shoulderDistance, waistlineDistance};
    ArrayList<String> distances = new ArrayList();
    for(int i=0; i<distancesArray.length; i++) {
      distances.add(distancesArray[i]);
    }
    /*
    //saving values for calibration
    ExcelHandlerForCalibration excelCalHandler = new ExcelHandlerForCalibration(distances); 
    excelCalHandler.saveDataForCalibration();
    */
    ExcelHandlerForMeasurements excelMsureHandler = new ExcelHandlerForMeasurements(distances); 
    excelMsureHandler.saveData();
  }
}
