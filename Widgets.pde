// WIDGET ---------------------------------------------------
abstract class Widget {
  private PApplet m_context;
  private float   m_x, m_y, m_width, m_height;
  private int     m_clickState = STATE_NOT_CLICKED;
  private float m_left;
  private float m_top;
  private float m_right;
  private float m_bottom;
  
  public Widget(PApplet t_context, float t_x, float t_y, float t_width, float t_height){
    m_context = t_context;
    m_x = t_x;
    m_y = t_y;
    m_width = t_width;
    m_height = t_height;
  }
  public void updateState() {
    if (m_context.mousePressed) {
      if (mouseOver()) {
        if (m_clickState == STATE_NOT_CLICKED) {
          m_clickState = STATE_CLICKED;
        } else if (m_clickState == STATE_CLICKED) {
          m_clickState = STATE_HOLDED;
        }
      }
    } else {
      m_clickState = STATE_NOT_CLICKED;
    }
  }
  
  public Widget x(float t_x){
    m_x = t_x;
    return this;
  }
  public Widget y(float t_y){
    m_y = t_y;
    return this;
  }
  public Widget coords(float t_x, float t_y){
    return x(t_x).y(t_y);
  }
  public Widget width(float t_width){
    m_width = t_width;
    return this;
  }
  public Widget height(float t_height){
    m_height = t_height;
    return this;
  }
  public Widget dimension(float t_width, float t_height){
    return width(t_width).height(t_height);
  }
  public Widget left(float t_left){
    m_left = t_left;
    return this;
  }
  public Widget right(float t_right){
    m_right = t_right;
    return this;
  }
  public Widget top(float t_top){
    m_top = t_top;
    return this;
  }
  public Widget bottom(float t_bottom){
    m_bottom = t_bottom;
    return this;
  }
  public Widget limits(float t_left, float t_right, float t_top, float t_bottom) {
    return left(t_left).right(t_right).top(t_top).bottom(t_bottom);
  }
  
  public float x(){
    return m_x;
  }
  public float y(){
    return m_y;
  }
  public float width(){
    return m_width;
  }
  public float height(){
    return m_height;
  }
  public float left(){
    return m_left;
  }
  public float right(){
    return m_right;
  }
  public float top(){
    return m_top;
  }
  public float bottom(){
    return m_bottom;
  }
  public PApplet context(){
    return m_context;
  }
  public boolean clicked() {
    return m_clickState==STATE_CLICKED;
  }
  public boolean holded() {
    return m_clickState==STATE_HOLDED;
  }
  public boolean mouseOver(){
    return context().mouseX > m_left && 
      context().mouseX < m_right &&
      context().mouseY > m_top &&
      context().mouseY < m_bottom;
  }
  
  
  public abstract void draw();
}

// CARD ---------------------------------------------------
class Card extends Widget {
  private float  m_padding;
  private color  m_colorB=240;
  private color  m_colorF=255;
  private String m_label;
  private int    m_labelWidth=0;
  private PFont  m_font;
  private PImage m_icon;
  private int    m_round = 3;
  private float  m_iconSize;

  public Card(PApplet t_context, float t_x, float t_y, float t_width, float t_height) {
    super(t_context, t_x, t_y, t_width, t_height);
    this.left(t_x+m_padding)
        .top(t_y+m_padding)
        .right(left()+t_width-2.0*m_padding)
        .bottom(top()+t_height-2.0*m_padding);
        
    m_iconSize = t_height/2.0;
    m_font = loadFont(StrResource.fontS);
  }

  @Override public void draw() {
    //Container
    fill(m_colorB);
    noStroke();
    rect(x()+m_padding,        y()+m_padding, 
          width()-2*m_padding, height()-2*m_padding, 
          m_round);

    //Text
    if (m_label!=null) {
      fill(m_colorF);
      textFont(m_font);
      if (m_labelWidth==0){
        m_labelWidth = int(textWidth(m_label));
      }
      text(m_label, (left()+right()-m_labelWidth)/2, bottom()-20);
    }
    updateState();

    //Icon
    if (m_icon != null) {
      tint(m_colorF);
      image(m_icon, 
        left()+(width()-m_iconSize)/2.0, top()+(height()-m_iconSize)/2.0, 
        m_iconSize, m_iconSize);
      noTint();
    }
  }

  public Card padding(int t_padding) {
    m_padding = t_padding;
    return this;
  }
  public Card setBackground(color t_color) {
    m_colorB = t_color;
    return this;
  }
  public Card setForeground(color t_color) {
    m_colorF = t_color;
    return this;
  }
  public Card label(String t_label) {
    m_label = t_label;
    return this;
  }
  public Card icon(String iconPath) {
    if (iconPath.isEmpty()) {
      m_icon = null;
    } else {
      m_icon = loadImage(iconPath);
    }
    return this;
  }
  public Card roundness(int round) {
    this.m_round = round;
    return this;
  }
  public Card iconSize(float iconSize) {
    this.m_iconSize = iconSize;
    return this;
  }
  
  public String label(){
    return m_label;
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
class TopBar extends Widget {
  private PImage  m_logo;
  private PImage  m_option;
  private PFont   m_font;
  private String  m_title[];
  private int     m_clickState = STATE_NOT_CLICKED;

  private final static float BAR_HEIGHT      = 50.0;
  private final static float LOGO_PADDING    = 10.0;
  private final static float LOGO_SIZE       = BAR_HEIGHT-2.0*LOGO_PADDING;
  private final static float OPTION_SIZE     = BAR_HEIGHT-2.0*LOGO_PADDING;
  private final static float BAR_HALF_HEIGHT = BAR_HEIGHT/2.0;
  private final static float BAR_TITLE_LEFT  = BAR_HEIGHT+10.0;

  public TopBar(PApplet t_context, String t_title[]) {
    super(t_context, 0, 0, 0, 0);
    m_title = new String[t_title.length];
    for (int i=0; i<t_title.length; i++) m_title[i] = t_title[i]+">";

    m_logo = loadImage(StrResource.logo);
    m_font = loadFont(StrResource.fontM);
  }
  public TopBar(PApplet t_context, String t_title) {
    super(t_context, 0, 0, 0, 0);
    m_title = new String[1];
    m_title[0] = t_title+">";

    m_logo = loadImage(StrResource.logo);
    m_option = loadImage("assets/006-more.png");
    m_font = loadFont(StrResource.fontM);
  }

  void draw() {
    // Draw Bar
    fill(Palette.main);
    rect(0, 0, context().width, BAR_HEIGHT);

    // Draw Logo
    image(m_logo, 
      LOGO_PADDING, LOGO_PADDING, 
      LOGO_SIZE, LOGO_SIZE);

    // Draw Path
    fill(255);
    textFont(m_font);
    textAlign(LEFT, CENTER);
    for (int i=0; i<m_title.length; i++) {
      final String s = m_title[i];
      text(s, BAR_TITLE_LEFT, BAR_HALF_HEIGHT);
    }

    //Draw quit button
    image(m_option, 
      width-OPTION_SIZE-LOGO_PADDING, LOGO_PADDING, 
      OPTION_SIZE, OPTION_SIZE);
      
    updateState();
  }

  //Option events
  /*public boolean mouseOverOption() {
    if (mouseX < width-OPTION_SIZE-LOGO_PADDING) return false;
    if (mouseX > width-LOGO_PADDING) return false;
    if (mouseY < LOGO_PADDING) return false;
    if (mouseY > LOGO_PADDING+OPTION_SIZE) return false;
    return true;
  }
  public boolean clicked() {
    return m_clickState==STATE_CLICKED;
  }
  public boolean holded() {
    return m_clickState==STATE_HOLDED;
  }
  
  // State machine
  private void updateState() {
    if (m_context.mousePressed) {
      if (mouseOverOption()) {
        if (m_clickState == STATE_NOT_CLICKED) {
          m_clickState = STATE_CLICKED;
        } else if (m_clickState == STATE_CLICKED) {
          m_clickState = STATE_HOLDED;
        }
      }
    } else {
      m_clickState = STATE_NOT_CLICKED;
    }
  }*/
}