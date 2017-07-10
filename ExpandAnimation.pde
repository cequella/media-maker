
class ExpandAnimation {
  private PApplet  m_context;
  private PImage[] m_imageList;
  private String[] m_textList;
  private String[] m_titleList;
  private String   m_subtitle;
  private int      m_size = 50;
  private float    m_x, m_y, m_width, m_height;
  private boolean  m_vertical = true;
  private color    m_tint = Palette.accent_dark;

  private Animator[] m_imageAnimator;
  private Animator[] m_boxAnimator;
  private Animator[] m_textAnimator;

  ExpandAnimation(PApplet context, Content content) {
    m_context = context;

    int contentSize = content.length();

    m_imageList = new PImage[contentSize];
    m_imageAnimator = new Animator[contentSize];
    m_boxAnimator   = new Animator[contentSize];
    m_textAnimator   = new Animator[contentSize];

    for (int i=0; i<contentSize; i++) {
      m_imageList[i] = new PImage();
      m_imageList[i] = loadImage(content.icon[i]);

      m_imageAnimator[i] = new Animator(0.3);
      m_boxAnimator[i]   = new Animator(0.3);
      m_textAnimator[i]   = new Animator(0.3);
      
      m_boxAnimator[i].offset(0.2*i);
      m_imageAnimator[i].offset(0.2*(contentSize -1 + i));
      m_textAnimator[i].offset(0.2*(contentSize -1 + i +i));
    }
    m_textList = content.text;
    m_titleList = content.title;
    m_subtitle = content.subtitle;
  }

  ExpandAnimation position(float t_x, float t_y) {
    m_x = t_x;
    m_y = t_y;
    return this;
  }
  ExpandAnimation dimension(float t_width, float t_height) {
    m_width = t_width;
    m_height = t_height;
    return this;
  }
  ExpandAnimation vertical() {
    m_vertical = true;
    return this;
  }
  ExpandAnimation horizontal() {
    m_vertical = false;
    return this;
  }
  ExpandAnimation tint(color t_tint) {
    m_tint = t_tint;
    return this;
  }

  void draw() {
    if (m_vertical) {
      verticalDraw();
    } else {
      horizontalDraw();
    }
    
    updateAnimators();
  }

  String subtitle() {
    return m_subtitle;
  }
  PApplet context() {
    return m_context;
  }
  void updateAnimators(){
    final int contentSize = m_imageAnimator.length;
    
    for(int i=0; i<contentSize; i++){
      m_boxAnimator[i].update();
      m_imageAnimator[i].update();
      m_textAnimator[i].update();
    }
  }
  void verticalDraw() {
    final float collumnWidth = m_width/float(m_imageList.length);
    final float collumnCenter = (collumnWidth-m_size)/2.0;

    for (int i=0; i<m_imageList.length; i++) {
      drawCollumn(i, collumnWidth, collumnCenter);
    }
  }
  void horizontalDraw() {
    float lineHeight = m_height/float(m_imageList.length);
    float lineCenter = (lineHeight-m_size)/2.0;

    for (int i=0; i<m_imageList.length; i++) {
      drawLine(i, lineHeight, lineCenter);
    }
  }
  public void reset(){
    final int contentSize = m_imageAnimator.length;
    
    for(int i=0; i<contentSize; i++){
      m_boxAnimator[i].reset();
      m_imageAnimator[i].reset();
      m_textAnimator[i].reset();
    }
  }

  private void drawCollumn(int index, float collumnWidth, float collumnCenter) {
    Animator animator = m_boxAnimator[index];
    
    final float deltaX = index*collumnWidth;
    
    m_context.fill(Palette.white);
    m_context.rect(m_x+deltaX+10,   m_y, 
                   collumnWidth-10, 250*animator.current(), 
                   2);

    // Content
    animator = m_imageAnimator[index];
    PImage current = m_imageList[index];
    
    m_context.pushStyle();
    if (m_tint!=0) m_context.tint(m_tint);
    m_context.image(animator.blendImage(current), 
                    m_x+deltaX+collumnCenter+10, m_y+10, 
                    m_size,                      m_size);

    animator = m_textAnimator[index];
    m_context.fill(animator.alphaBlend(Palette.accent));
    m_context.textAlign(CENTER);
    m_context.text(m_titleList[index], 
                  m_x+deltaX+20,    m_y+m_size+35, 
                  collumnWidth-20,  20);

    m_context.noStroke();
    m_context.fill(animator.alphaBlend(Palette.main));
    m_context.textAlign(LEFT);
    m_context.text(m_textList[index], 
                  m_x+deltaX+20,   m_y+m_size+80, 
                  collumnWidth-20, 80);
    m_context.popStyle();
  }
  private void drawLine(int index, float lineHeight, float lineCenter) {
    Animator animator = m_boxAnimator[index];
    
    final float WIDTH = m_width-10;
    m_context.fill(Palette.white);
    m_context.rect(m_x+10,                   m_y+index*(lineHeight+10), 
                  WIDTH*animator.current(), lineHeight,
                  2);
    
    animator = m_imageAnimator[index];
    PImage current = m_imageList[index];

    // Content
    m_context.pushStyle();
    
    if (m_tint!=0) m_context.tint(m_tint);
    m_context.image(animator.blendImage(current), 
                    m_x +30, m_y+index*(lineHeight+10)+lineCenter,
                    m_size,  m_size);

    animator = m_textAnimator[index];
    m_context.fill(animator.alphaBlend(Palette.accent));
    m_context.textAlign(CENTER);
    m_context.text(m_titleList[index], 
                  m_x+ m_size+20,    m_y+ index*(lineHeight+10)+10, 
                  m_width-m_size-60, 80);

    m_context.noStroke();
    m_context.fill(animator.alphaBlend(Palette.main));
    m_context.textAlign(LEFT);
    m_context.text(m_textList[index], 
                  m_x+m_size+50,    m_y+index*(lineHeight+10)+30, 
                  m_width-m_size-50, m_textList[index].length());
                  //m_width-m_size-60, 80);
    m_context.popStyle();
  }
}