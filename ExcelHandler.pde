abstract class ExcelHandler {
  
  private final static int DISTANCE_BETWEEN_CELLS = 1;
  
  protected String getCellValue(String pathToFile, int sheetNum, int rowNum, int columnNum) throws Exception {
    FileInputStream fileIn = new FileInputStream(pathToFile);
    XSSFWorkbook workbook = new XSSFWorkbook(fileIn);
    org.apache.poi.ss.usermodel.Sheet sheet = workbook.getSheetAt(sheetNum);
    String value = sheet.getRow(rowNum).getCell(columnNum).toString();
    fileIn.close();
    return value.toString();
  }
  
  protected void updateCellValue(String pathToFile, int sheetNum, int rowNum, int columnNum, String[] values) throws Exception {
    FileInputStream fileIn = new FileInputStream(pathToFile);
    XSSFWorkbook workbook = new XSSFWorkbook(fileIn);
    org.apache.poi.ss.usermodel.Sheet sheet = workbook.getSheetAt(sheetNum);
    Row row = sheet.createRow(rowNum);
    
    int currentValuesIndex = 0;
    for(int index = columnNum; index < values.length; index = index + DISTANCE_BETWEEN_CELLS) {
      Cell cell = row.createCell(index);
      cell.setCellValue(Double.parseDouble(values[currentValuesIndex]));
      currentValuesIndex++;
    }
   
    FileOutputStream fileOut = new FileOutputStream(pathToFile);
    workbook.write(fileOut);
    fileOut.flush();
    fileOut.close();
  }
  
}
