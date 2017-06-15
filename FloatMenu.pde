
class FloatMenu {
  private PApplet  m_context;
  private float    m_x;
  private float    m_y;
  private float    m_marginH = 10;
  private float    m_marginV = 10;
  private float    m_spacement = 25;
  private String[] m_content;
  private float    m_biggestItem = -1.0;
  private boolean  m_visible = false;
  
  public FloatMenu(PApplet t_context, float t_x, float t_y, String[] t_content) {
    m_context = t_context;
    m_x = t_x;
    m_y = t_y;
    m_content = t_content;
  }
  
  public void draw(){
    if(!m_visible) return;
    
    if(m_biggestItem == -1.0){
      for(String l : m_content){
        if(m_biggestItem<textWidth(l)) m_biggestItem = textWidth(l);
      }
      
      m_x -= m_biggestItem;
    }
    
    fill(Palette.white);
    rect(m_x, m_y, 
      m_biggestItem+2*m_marginH, m_spacement*m_content.length+m_marginV, 
      3);
    fill(Palette.accent);
    textAlign(LEFT, TOP);
    textSize(16);
    for(int i=0; i<m_content.length; i++){
      text(m_content[i], m_x+m_marginH, m_y+m_marginV+i*m_spacement);
    }
  }
  
  public FloatMenu show(){
    m_visible = true;
    return this;
  }
  public FloatMenu hide(){
    m_visible = false;
    return this;
  }
  
  public boolean isVisible(){
    return m_visible;
  }
}