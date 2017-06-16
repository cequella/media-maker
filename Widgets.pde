// WIDGET ---------------------------------------------------
abstract class Widget {
  private PApplet m_context;
  private float   m_x, m_y, m_width, m_height;
  private int     m_clickState = STATE_NOT_CLICKED;
  private float   m_left;
  private float   m_top;
  private float   m_right;
  private float   m_bottom;
  private String  m_clickedChild;
  
  public Widget(PApplet t_context, float t_x, float t_y, float t_width, float t_height){
    m_context = t_context;
    m_x = t_x;
    m_y = t_y;
    m_width = t_width;
    m_height = t_height;
    
    m_left = t_x;
    m_right = t_x+t_width;
    m_top = t_y;
    m_bottom = t_y+t_height;
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
  public Widget clickedChild(String t_child){
    m_clickedChild = t_child;
    return this;
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
  public boolean child(String t_child){
    if(m_clickedChild == null) return false;
    return m_clickedChild.equals(t_child);
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
      textAlign(LEFT, TOP);
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
  private PImage    m_logo;
  private PImage    m_option;
  private PFont     m_font;
  private String    m_title[];
  private color     m_color;
  private FloatMenu m_floatMenu;

  private final static float BAR_HEIGHT      = 50.0;
  private final static float LOGO_PADDING    = 10.0;
  private final static float LOGO_SIZE       = BAR_HEIGHT-2.0*LOGO_PADDING;
  private final static float OPTION_SIZE     = BAR_HEIGHT-2.0*LOGO_PADDING;
  private final static float BAR_HALF_HEIGHT = BAR_HEIGHT/2.0;
  private final static float BAR_TITLE_LEFT  = BAR_HEIGHT+10.0;

  public TopBar(PApplet t_context, color t_color, String t_title[]) {
    super(t_context, 0, 0, width, BAR_HEIGHT);
    m_color = t_color;
    m_title = new String[t_title.length];
    for (int i=0; i<t_title.length; i++) m_title[i] = t_title[i]+">";

    m_logo   = loadImage(StrResource.logo);
    m_option = loadImage("assets/icons/006-more.png");
    m_font   = loadFont(StrResource.fontM);
    
    m_floatMenu = new FloatMenu(t_context, 
      width-1.5*OPTION_SIZE-LOGO_PADDING, OPTION_SIZE,
      new String[]{"Sobre o Projeto", "Sobre a Equipe", "Créditos", "Sair"});
  }
  public TopBar(PApplet t_context, color t_color, String t_title) {
    this(t_context, t_color, new String[]{t_title});
  }

  void draw() {
    // Draw Bar
    fill(m_color);
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
    
    clickedChild(null);
    mouseOverOption();
    updateState();
    
    //Float menu
    m_floatMenu.draw();
  }

  //Option events
  private void mouseOverOption() {
    if (mouseX < width-OPTION_SIZE-LOGO_PADDING){
      m_floatMenu.hide();
      return;
    }
    if (mouseX > width-LOGO_PADDING){
      m_floatMenu.hide();
      return;
    }
    if (mouseY < LOGO_PADDING){
      m_floatMenu.hide();
      return;
    }
    if (mouseY > LOGO_PADDING+OPTION_SIZE){
      m_floatMenu.hide();
      return;
    }
    
    m_floatMenu.show();
  }
}

// PageViewer ---------------------------------------------------
class PageViewer extends Widget {
  private PImage[] m_content;
  private PImage   m_previous, m_next;
  private float[]  m_buttonCoord = new float[4];
  private float    m_buttonSize = 30.0;
  private float    m_buttonTopMargin = 20.0;
  private int      m_current = 0;
  
  public PageViewer(PApplet t_context, float t_x, float t_y, float t_width, float t_height, String[] path){
    super(t_context, t_x, t_y, t_width, t_height);
    
    m_previous = loadImage("assets/icons/008-back.png");
    m_next = loadImage("assets/icons/007-next.png");
    
    m_content = new PImage[path.length];
    for(int i=0; i<path.length; i++){
      m_content[i] = loadImage(path[i]);
    }
    
     m_buttonCoord[0] = x();
     m_buttonCoord[1] = y()+height()+m_buttonTopMargin;
     m_buttonCoord[2] = x()+width()-m_buttonSize;
     m_buttonCoord[3] = y()+height()+m_buttonTopMargin;
     
     bottom(bottom()+m_buttonTopMargin+m_buttonSize);
  }   
 
  @Override public void draw(){
    image(m_content[m_current],
          x(), y(),
          width(), height());
    image(m_previous,
          m_buttonCoord[0], m_buttonCoord[1], 
          m_buttonSize, m_buttonSize);
    image(m_next, 
          m_buttonCoord[2], m_buttonCoord[3], 
          m_buttonSize, m_buttonSize);
    
    checkClick();
    updateState();
  }
  private void checkClick(){
    if(clicked()){
      if(clickPrevious() && m_current > 0){
        m_current--;
      } else if(clickNext() && m_current < m_content.length-1){
        m_current++;
      }
    }
  }
  private boolean clickPrevious(){
    if(context().mouseX < m_buttonCoord[0]) return false;
    if(context().mouseX > m_buttonCoord[0]+m_buttonSize) return false;
    if(context().mouseY < m_buttonCoord[1]) return false;
    if(context().mouseY > m_buttonCoord[1]+m_buttonSize) return false;
    
    return true;
  }
  private boolean clickNext(){
    if(context().mouseX < m_buttonCoord[2]) return false;
    if(context().mouseX > m_buttonCoord[2]+m_buttonSize) return false;
    if(context().mouseY < m_buttonCoord[3]) return false;
    if(context().mouseY > m_buttonCoord[3]+m_buttonSize) return false;
    
    return true;
  }
}