class ScreenManager {
  public final static int HOME = 1;
  
  private PApplet m_context;
  private Screen  m_current;
  
  private boolean m_loaded = true;
  private int     m_state  = 0;
  
  ScreenManager(PApplet t_context) {
    m_context = t_context;
    
    m_current = new SplashScreen(m_context);
  }
  
  public void start() {
    m_current = m_current.display();
    
    if(!m_loaded) updateCurrentScreen();
  }
  public void changeState(int state){
    m_state = state;
    m_loaded = false;
  }
  
  private void updateCurrentScreen(){
    switch(m_state){
      case HOME:
      m_current = new MainMenu(m_context);
      break;
    }
    
    m_loaded = true;
  }
}