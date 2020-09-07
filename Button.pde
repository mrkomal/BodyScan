class Button {
  
  //Propoerties of these class are designed for save button
  private final int START_X = 1000;
  private final int START_Y = 520;
  private final int WIDTH = 200;
  private final int HEIGHT = 120;
  private final int TEXT_X = 1060;
  private final int TEXT_Y = 590;
  private int buttonColor = 100;
  private String name;
   
  public Button (String name) {
    this.name = name;
  }
  
  private void displayButton() {
    //properties
    stroke(0);
    fill(buttonColor);
    rect(START_X,START_Y,WIDTH,HEIGHT);
    //text
    fill(0);
    text(name,TEXT_X,TEXT_Y);
  }
  
  private boolean isMouseInsideButton() {
    boolean mouseIsInsideButton = false;
    
    if(mouseX>START_X && mouseX<(START_X+WIDTH)){
      if(mouseY>START_Y && mouseY<(START_Y+HEIGHT)){
        mouseIsInsideButton = true;
      }
    }
    
    return mouseIsInsideButton;
  }
  
}
