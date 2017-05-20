class Label {
  private PFont  m_font;
  private color  m_color=255;
  private String m_label;
  private int m_x, m_y;

  private final int m_spacement;

  public static final int SMALL  = 1;
  public static final int MEDIUM = 2;
  public static final int BIG    = 3;

  public Label(String t_label, int t_size, int t_x, int t_y) {
    switch(t_size) {
    case SMALL:
      m_font = loadFont(StrResource.fontS);
      m_spacement = 7;
      break;
    case MEDIUM:
      m_font = loadFont(StrResource.fontM);
      m_spacement = 11;
      break;
    case BIG:
      m_font = loadFont(StrResource.fontB);
      m_spacement = 24;
      break;
    default:
      m_spacement = 5;
    }

    label(t_label);
    m_x = t_x;
    m_y = t_y;
  }

  public void draw() {
    textFont(m_font);
    fill(m_color);
    textAlign(LEFT, TOP);
    text(m_label, m_x, m_y);
    translate(0, m_y+m_spacement);
  }

  public Label label(String t_label) {
    m_label = t_label;
    return this;
  }
  public Label setColor(color t_color) {
    m_color = t_color;
    return this;
  }
}