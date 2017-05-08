class Screen {
  private PApplet m_context;
  
  private boolean m_ready = false;
  private String  m_title;
  private int m_out;
  
  public Screen(PApplet t_context, String t_title) {
    m_context = t_context;
    m_title   = t_title;
    m_out     = 0;
    
    Loader loader = new Loader();
    loader.start();
  }
  
  protected void notReady(PApplet context){}
  protected void ready(PApplet context){}
  protected void load(PApplet context){}
  protected void events(PApplet context){}
  
  public final int display() {
    if(m_ready) {
      ready(m_context);
    } else {
      notReady(m_context);
    }
    
    events(m_context);
    
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
      load(m_context);
      m_ready=true;
      println("Finish!");
    }
  }
}