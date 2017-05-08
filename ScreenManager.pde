class ScreenManager {
  Screen currentScreen, nextScreen;
  
  ScreenManager() {
    currentScreen = new SplashScreen("assets/Logo_big.png", "Ubuntu-Light-48.vlw", 100, 100);
  }
  
  public void start() {
    if(currentScreen.display() == 1){
      exit();
    }
  }
}