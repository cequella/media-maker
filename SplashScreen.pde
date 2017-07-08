class SplashScreen extends Screen {
  final int    LOGO_SIZE   = 100;
  final int    TEXT_SIZE   = 32;
  final int    LOGO_OFFSET = int(1.5*TEXT_SIZE);

  // LOGO
  private PImage m_logo;
  private float  m_logoSize;
  private float  m_logoX, m_logoY;

  //TIPO
  private PFont  m_font;

  public SplashScreen(PApplet t_context) {
    super(t_context, "SplashScreen");
    m_logoSize = LOGO_SIZE;
    m_logoX    = (width-m_logoSize)/2;
    m_logoY    = (height-m_logoSize)/2;
  }

  @Override void ready(PApplet context) {
    //LOGO
    image(m_logo, m_logoX, m_logoY, m_logoSize, m_logoSize);

    //TIPO  
    float m_typeX = (width-textWidth(StrResource.name))/2;
    float m_typeY = (height+m_logoSize)/2+LOGO_OFFSET;

    textFont(m_font, TEXT_SIZE);
    text(StrResource.name, m_typeX, m_typeY);
  }

  @Override void notReady(PApplet context) {
    text(StrResource.loading, (width-textWidth(StrResource.loading))/2, height/2);
  }

  @Override void load(PApplet context) {
    m_logo = logo;
    m_font = loadFont(StrResource.fontB);
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