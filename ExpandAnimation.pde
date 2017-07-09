
class ExpandAnimation {
  private PApplet  m_context;
  private PImage[] m_imageList;
  private String[] m_textList;
  private String[] m_titleList;
  private String   m_subtitle;
  private int      m_size = 50;
  private float    m_x, m_y, m_width, m_height;
  private boolean  m_vertical = true;
  
  ExpandAnimation(PApplet context, Content content){
    m_context = context;
    m_imageList = new PImage[content.icon.length];
    for(int i=0; i<content.icon.length; i++){
      m_imageList[i] = new PImage();
      m_imageList[i] = loadImage(content.icon[i]);
    }
    m_textList = content.text;
    m_titleList = content.title;
    m_subtitle = content.subtitle;
  }
  
  ExpandAnimation position(float t_x, float t_y){
    m_x = t_x;
    m_y = t_y;
    return this;
  }
  ExpandAnimation dimension(float t_width, float t_height){
    m_width = t_width;
    m_height = t_height;
    return this;
  }
  ExpandAnimation vertical(){
    m_vertical = true;
    return this;
  }
  ExpandAnimation horizontal(){
    m_vertical = false;
    return this;
  }
  
  void draw(){
    if(m_vertical){
      verticalDraw();
    } else {
      horizontalDraw();
    }
  }
  
  String subtitle(){
    return m_subtitle;
  }
  void verticalDraw(){
    float a = m_width/float(m_imageList.length);
    float b = (a-m_size)/2.0;
    
    for(int i=0; i<m_imageList.length; i++){
      m_context.fill(Palette.white);
      m_context.rect(m_x + i*a + 10, m_y, a-10, 250, 2);
      
      // Content
      PImage current = m_imageList[i];
      m_context.pushStyle();
      m_context.tint(Palette.accent_dark);
      m_context.image(current, m_x+ i*a +b +10, m_y+10, m_size, m_size);
      
      m_context.fill(Palette.accent);
      m_context.textAlign(CENTER);
      m_context.text(m_titleList[i], m_x+ i*a +20, m_y + m_size + 35, a- 20, 20);
      
      m_context.noStroke();
      m_context.fill(Palette.main);
      m_context.textAlign(LEFT);
      m_context.text(m_textList[i], m_x+ i*a +20, m_y + m_size + 80, a- 20, 80);
      m_context.popStyle();
    }
  }
  void horizontalDraw(){
    float a = m_height/float(m_imageList.length);
    float b = (a-m_size)/2.0;
    
    for(int i=0; i<m_imageList.length; i++){
      m_context.fill(Palette.white);
      m_context.rect(m_x + 10, m_y+ i*(a+10), m_width-10, a, 2);
      
      // Content
      PImage current = m_imageList[i];
      m_context.pushStyle();
      m_context.tint(Palette.accent_dark);
      m_context.image(current, m_x +30, m_y+ i*(a+10)+b, m_size, m_size);
      
      m_context.fill(Palette.accent);
      m_context.textAlign(CENTER);
      m_context.text(m_titleList[i], m_x+ m_size+20, m_y+ i*(a+10) + 10, m_width-m_size-60, 80);
      
      m_context.noStroke();
      m_context.fill(Palette.main);
      m_context.textAlign(LEFT);
      m_context.text(m_textList[i], m_x+ m_size+60, m_y+ i*(a+10) + 30, m_width-m_size-60, 80);
      m_context.popStyle();
    }
  }
}