class SplashScreen extends Screen {
  final String NAME        = "MediaMaker";
  final int    LOGO_OFFSET = 48;
  final int    TEXT_SIZE   = 32;

  // LOGO
  private PImage m_logo;
  private String m_logoPath;
  private float m_logoSize;
  private float m_logoX, m_logoY;

  //TIPO
  private PFont m_font;
  private String m_fontPath;

  public SplashScreen(PApplet t_context, 
    String t_logoPath, 
    String t_fontPath, 
    float t_size) {
    super(t_context, "SplashScreen");
    m_logoPath = t_logoPath;
    m_fontPath = t_fontPath;
    m_logoSize = t_size;
    m_logoX    = (width-m_logoSize)/2;
    m_logoY    = (height-m_logoSize)/2;
  }

  @Override void ready(PApplet context) {
    //LOGO
    image(m_logo, m_logoX, m_logoY, m_logoSize, m_logoSize);

    //TIPO  
    float m_typeX = (width-textWidth(NAME))/2;
    float m_typeY = (height+m_logoSize)/2+LOGO_OFFSET;

    textFont(m_font, TEXT_SIZE);
    text(NAME, m_typeX, m_typeY);
  }

  @Override void notReady(PApplet context) {
    text("Loading...", (width-textWidth("Loading..."))/2, height/2);
  }

  @Override void load(PApplet context) {
    m_logo = loadImage(m_logoPath);
    m_font = loadFont(m_fontPath);
  }

  @Override void events(PApplet context) {
    if (context.keyPressed) {
      switch(context.key) {
      case ESC:
        quit(1);
        break;
      }
    }
  }
}