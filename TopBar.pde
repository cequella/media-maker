class TopBar {
  private PApplet m_context;
  private PImage  m_logo;
  private PFont   m_font;
  private String  m_title[];
  
  private final static int BAR_HEIGHT      = 50;
  private final static int LOGO_PADDING    = 10;
  private final static int LOGO_SIZE       = BAR_HEIGHT-2*LOGO_PADDING;
  private final static int BAR_HALF_HEIGHT = BAR_HEIGHT/2;
  private final static int BAR_TITLE_LEFT  = BAR_HEIGHT+10;
  
  public TopBar(PApplet t_context, String t_title[]){
    m_context = t_context;
    m_title = t_title;
    
    m_logo = loadImage(StrResource.logo);
    m_font = loadFont(StrResource.fontM);
  }
  public TopBar(PApplet t_context, String t_title){
    m_context = t_context;
    m_title = new String[1];
    m_title[0] = t_title;
    
    m_logo = loadImage(StrResource.logo);
    m_font = loadFont(StrResource.fontM);
  }
  
  void draw(){
    // Draw Bar
    fill(Palette.main);
    rect(0,0, m_context.width, BAR_HEIGHT);
    
    // Draw Logo
    image(m_logo, LOGO_PADDING, LOGO_PADDING, LOGO_SIZE, LOGO_SIZE);
    
    // Draw Path
    fill(255);
    textFont(m_font);
    textAlign(LEFT, CENTER);
    for(String s : m_title){
      text(s+">", BAR_TITLE_LEFT, BAR_HALF_HEIGHT);
    }
    
    translate(0, BAR_HEIGHT);
  }
}