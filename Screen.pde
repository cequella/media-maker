class Screen {
  private boolean m_ready = false;
  private String  m_title;
  private int m_out;
  
  public Screen(String t_title) {
    m_title = t_title;
    m_out   = 0;
    Loader loader = new Loader();
    loader.start();
  }
  
  protected void notReady(){}
  protected void ready(){}
  protected void load(){}
  
  public final int display() {
    if(m_ready) {
      ready();
    } else {
      notReady();
    }
    return m_out;
  }
  protected final void quit(int value){
    m_out = value;
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