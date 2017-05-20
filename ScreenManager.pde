class ScreenManager {
  private PApplet m_context;
  private Screen  m_current;
  
  ScreenManager(PApplet t_context) {
    m_context = t_context;
    
    m_current = new MainMenu(m_context);//new SplashScreen(m_context);
  }
  
  public void start() {
    m_current = m_current.display();
  }
}