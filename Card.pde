final int CARD_CLICKED     = 1;
final int CARD_HOLDED      = 2;
final int CARD_NOT_CLICKED = 0;

class Card {
  private PApplet m_context;
  private int     m_x, m_y, m_width, m_height;
  private int     m_padding;
  private color   m_color=255;
  private String  m_label;
  private int     m_labelWidth=0;
  private PFont   m_font;
  private PImage  m_icon;

  //AUX
  final int   m_left;
  final int   m_top;
  final int   m_right;
  final int   m_bottom;
  final float m_iconSize;

  int m_clickState = CARD_NOT_CLICKED;

  public Card(PApplet t_context, int t_x, int t_y, int t_width, int t_height) {
    m_context = t_context;
    m_x = t_x;
    m_y = t_y;
    m_width = t_width;
    m_height = t_height;

    m_left     = m_x+m_padding;
    m_top      = m_y+m_padding;
    m_right    = m_left+m_width-2*m_padding;
    m_bottom   = m_top+m_height-2*m_padding;
    m_iconSize = m_height/2.0;

    m_font = loadFont(StrResource.fontS);
  }

  // State machine
  private void updateState() {
    if (m_context.mousePressed) {
      if (mouseOver()) {
        if (m_clickState == CARD_NOT_CLICKED) {
          m_clickState = CARD_CLICKED;
        } else if (m_clickState == CARD_CLICKED) {
          m_clickState = CARD_HOLDED;
        }
      }
    } else {
      m_clickState = CARD_NOT_CLICKED;
    }
  }

  public void draw() {
    //Container
    fill(m_color);
    noStroke();
    rect(m_x+m_padding, m_y+m_padding, m_width-2*m_padding, m_height-2*m_padding, 3);

    //Text
    if (m_label!=null) {
      fill(240);
      textFont(m_font);
      if (m_labelWidth==0) m_labelWidth = int(textWidth(m_label));
      text(m_label, (m_left+m_right-m_labelWidth)/2, m_bottom-20);
    }
    updateState();
    
    //Icon
    if(m_icon != null){
      image(m_icon, m_left+(m_width-m_iconSize)/2.0, m_top+25.0, m_iconSize, m_iconSize);
    }
  }

  public Card padding(int t_padding) {
    m_padding = t_padding;
    return this;
  }
  public Card setBackground(color t_color) {
    m_color = t_color;
    return this;
  }
  public Card label(String t_label) {
    m_label = t_label;
    return this;
  }
  public Card icon(String iconPath) {
    if(iconPath.isEmpty()){
      m_icon = null;
    } else {
      m_icon = loadImage(iconPath);
    }
    return this;
  }

  public boolean clicked() {
    return m_clickState==CARD_CLICKED;
  }
  public boolean holded() {
    return m_clickState==CARD_HOLDED;
  }
  public boolean mouseOver() {
    if(VERBOSITY){
      
    }
    
    return m_context.mouseX > m_left && 
      m_context.mouseX < m_right &&
      m_context.mouseY > m_top &&
      m_context.mouseY < m_bottom;
  }
}