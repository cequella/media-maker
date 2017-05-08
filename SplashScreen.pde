class SplashScreen extends Screen {
  final String NAME        = "MediaMaker";
  final int    LOGO_OFFSET = 48;
  final int    TEXT_SIZE   = 32;

  // LOGO
  private PImage m_logo;
  private String m_logoPath;
  private float m_logoWidth, m_logoHeight;
  private float m_logoX, m_logoY;

  //TIPO
  private PFont m_font;
  private String m_fontPath;

  public SplashScreen(String t_logoPath, String t_fontPath, float t_width, float t_height) {
    super("SplashScreen");
    m_logoPath   = t_logoPath;
    m_fontPath   = t_fontPath;
    m_logoWidth  = t_width;
    m_logoHeight = t_height;
    m_logoX      = (width-m_logoWidth)/2;
    m_logoY      = (height-m_logoHeight)/2;
  }

  void ready() {
    //LOGO
    image(m_logo, m_logoX, m_logoY, m_logoWidth, m_logoHeight);

    //TIPO  
    float m_typeX = (width-textWidth(NAME))/2;
    float m_typeY = (height+m_logoHeight)/2+LOGO_OFFSET;

    textFont(m_font, TEXT_SIZE);
    text(NAME, m_typeX, m_typeY);
  }
  void notReady() {
    text("Loading...", (width-textWidth("Loading..."))/2, height/2);
  }
  void load() {
    m_logo = loadImage(m_logoPath);
    m_font = loadFont(m_fontPath);
  }
}