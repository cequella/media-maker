// CARD ---------------------------------------------------
class Card {
  private PApplet m_context;
  private float   m_x, m_y, m_width, m_height;
  private float   m_padding;
  private color   m_color=255;
  private String  m_label;
  private int     m_labelWidth=0;
  private PFont   m_font;
  private PImage  m_icon;
  private int     m_round = 3;

  //AUX
  final float m_left;
  final float m_top;
  final float m_right;
  final float m_bottom;
  final float m_iconSize;

  int m_clickState = CARD_NOT_CLICKED;

  public Card(PApplet t_context, float t_x, float t_y, float t_width, float t_height) {
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
    rect(m_x+m_padding, m_y+m_padding, m_width-2*m_padding, m_height-2*m_padding, m_round);

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
  public Card paint(color t_color) {
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
  public Card roundness(int round){
    this.m_round = round;
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

// LABEL ---------------------------------------------------
class Label {
  private PFont  m_font;
  private color  m_color=255;
  private String m_label;
  private int    m_x, m_y;

  public static final int SMALL  = 1;
  public static final int MEDIUM = 2;
  public static final int BIG    = 3;

  public Label(String t_label, int t_size, int t_x, int t_y) {
    switch(t_size) {
    case SMALL:
      m_font = loadFont(StrResource.fontS);
      break;
    case MEDIUM:
      m_font = loadFont(StrResource.fontM);
      break;
    case BIG:
      m_font = loadFont(StrResource.fontB);
      break;
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

// TOP BAR ---------------------------------------------------
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
  }
}