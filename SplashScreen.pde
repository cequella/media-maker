class SplashScreen {
  final String NAME = "MediaMaker";
  final int    LOGO_OFFSET = 48;

  // LOGO
  private PImage m_logo;
  private float m_logoWidth, m_logoHeight;
  private float m_logoX, m_logoY;

  //TIPO
  private PFont m_font;

  SplashScreen(String logoPath, String fontPath, float t_width, float t_height) {
    //LOGO  
    m_logo       = loadImage(logoPath);
    m_font       = loadFont(fontPath);
    m_logoWidth  = t_width;
    m_logoHeight = t_height;
    m_logoX      = (width-m_logoWidth)/2;
    m_logoY      = (height-m_logoHeight)/2;
  }

  public final void show() {
    //LOGO
    image(m_logo, m_logoX, m_logoY, m_logoWidth, m_logoHeight);

    //TIPO  
    float m_typeX = (width-textWidth(NAME))/2;
    float m_typeY = (height+m_logoHeight)/2+LOGO_OFFSET;
    
    textFont(m_font, 32);
    text(NAME, m_typeX, m_typeY);
  }
}