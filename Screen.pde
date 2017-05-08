class Screen {
  private boolean m_ready = false;
  private String  m_title;
  
  public Screen(String t_title) {
    m_title = t_title;
    Loader loader = new Loader();
    loader.start();
  }
  
  protected void notReady(){}
  protected void ready(){}
  protected void load(){}
  
  public void start() {
    if(m_ready) {
      ready();
    } else {
      notReady();
    }
  }
  
  private final class Loader extends Thread {
    @Override
      public void start() {
      print("Loading '"+m_title+"'...");
      super.start();
    }
    @Override
      public void run() {
      load();
      m_ready=true;
      println("Finish!");
    }
  }
}