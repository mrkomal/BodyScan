class ExcelHandlerForCalibration extends ExcelHandler {
 
  //Input calibration properties
  private final static String PATH_TO_CALIBRATION_NUMBERS = "C:/Users/admin/Desktop/praktyki/calibration_numbers.xlsx";
  private final static int SHEET_NUMBER = 0;
  private final static int ROW_NUMBER = 1;
  private final static int COLUMN_NUMBER = 0;
  private final static int ERROR_ID = 999;
  //Output calibration properties
  private final static String PATH_TO_CALIBRATION = "C:/Users/admin/Desktop/praktyki/calibration.xlsx";
  private final static int OUTPUT_SHEET_NUMBER = 0;
  private final static int OUTPUT_COLUMN_NUMBER = 0;
  private final static int OUTPUT_ROW_NUMBER = 2;
  //Given distances
  private ArrayList<String> distances;
  
  
  public ExcelHandlerForCalibration(ArrayList<String> distances) {
    this.distances = distances;
  }
  
  private void saveDataForCalibration() {
    String measurementID = getMeasurementID();
    String[] measurementIDArr = {measurementID};
    System.out.println("ID obtained. Your ID is: " + measurementID);
    distances.add(0,String.valueOf(measurementID));
    String[] values = distances.toArray(new String[0]);
    
    try {
    updateCellValue(PATH_TO_CALIBRATION,OUTPUT_SHEET_NUMBER,(Integer.parseInt(measurementID)+OUTPUT_ROW_NUMBER-1),OUTPUT_COLUMN_NUMBER,values);
    System.out.println("Values are now in Excel (calibration sheet)!");
    updateCellValue(PATH_TO_CALIBRATION_NUMBERS,SHEET_NUMBER,ROW_NUMBER,COLUMN_NUMBER,measurementIDArr);
    System.out.println("ID for next user is updated.");
    } catch (Exception e) {
      System.out.println("An error occured:" + e);
    }
    System.out.println("");
  }
  
  
  private String getMeasurementID() {
    int measurementID = ERROR_ID;
    try {
      double lastMeasurementIDDouble = Double.parseDouble(getCellValue(PATH_TO_CALIBRATION_NUMBERS,SHEET_NUMBER,ROW_NUMBER,COLUMN_NUMBER));
      int lastMeasurementID = (int) lastMeasurementIDDouble;
      measurementID = incrementCellValue(lastMeasurementID);
    } catch (Exception e) {
      System.out.println("An error occured:" + e);
    }
    return String.valueOf(measurementID);
  }
  
  
  private int incrementCellValue(int cellValue) {
    return cellValue + 1;
  }
  
}
