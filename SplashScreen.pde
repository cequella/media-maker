class SplashScreen extends Screen {
  final String NAME        = "MediaMaker";
  final String LOGO_PATH   = "assets/Logo_big.png";
  final int    LOGO_SIZE   = 100;
  final String FONT_PATH   ="Ubuntu-Light-48.vlw";
  final int    TEXT_SIZE   = 32;
  final int    LOGO_OFFSET = int(1.5*TEXT_SIZE);

  // LOGO
  private PImage m_logo;
  private String m_logoPath;
  private float  m_logoSize;
  private float  m_logoX, m_logoY;

  //TIPO
  private PFont  m_font;
  private String m_fontPath;

  public SplashScreen(PApplet t_context) {
      
    super(t_context, "SplashScreen");
    m_logoPath = LOGO_PATH;
    m_fontPath = FONT_PATH;
    m_logoSize = LOGO_SIZE;
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
        changeScreen(null);
        break;
      }
    }
    
    if(frameCount() >= 90) changeScreen(new MainMenu(context));
  }
}