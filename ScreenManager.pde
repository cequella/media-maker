class ScreenManager {
  private PApplet m_context;
  private Screen  m_currentScreen;
  
  ScreenManager(PApplet t_context) {
    m_context = t_context;
    
    m_currentScreen = new SplashScreen(m_context,
                                        "assets/Logo_big.png", 
                                        "Ubuntu-Light-48.vlw", 
                                        100);
  }
  
  public void start() {
    if(m_currentScreen.display() == 1){
      exit();
    }
  }
}