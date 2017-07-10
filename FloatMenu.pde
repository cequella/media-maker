
class FloatMenu {
  final int FONT_SIZE = 16;
  final int BACKGROUND = 0;
  
  private PApplet  m_context;
  private float    m_x;
  private float    m_y;
  private float    m_marginH = 10;
  private float    m_marginV = 10;
  private float    m_spacement = 25;
  private String[] m_content;
  private float    m_biggestItem = -1.0;
  private boolean  m_visible = false;
  private MainMenu m_mainMenu;
  
  private Animator[] m_animator;

  private int m_current = -1;

  public FloatMenu(PApplet t_context, MainMenu t_mainMenu, float t_x, float t_y, String[] t_content) {
    m_context = t_context;
    m_mainMenu = t_mainMenu;
    m_x = t_x;
    m_y = t_y;
    m_content = t_content;
    
    //Animation
    m_animator = new Animator[t_content.length +1];
    
    m_animator[BACKGROUND] = new Animator(0.2);
    for(int i=1; i<m_animator.length; i++){
      m_animator[i] = new Animator(0.1);
    }
  }

  public void draw() {
    if (!m_visible) return;

    if (m_biggestItem == -1.0) {
      for (String l : m_content) {
        if (m_biggestItem<textWidth(l)) m_biggestItem = textWidth(l);
      }

      m_x -= m_biggestItem;
    }

    // Set values;
    final float W = m_biggestItem+2.0*m_marginH;
    final float H = m_spacement*m_content.length+m_marginV;
    final float SELECTOR_H = FONT_SIZE+m_marginV;

    drawSquare(W, H);
    
    if(m_animator[BACKGROUND].finished()){
      drawSelector(W, SELECTOR_H);
      writeOptions();
    }

    update();
    checkState();
  }
  private void drawSquare(float w, float h){
    float current = m_animator[BACKGROUND].current();
    float remaining = m_animator[BACKGROUND].remaining();
    
    fill(Palette.white);
    rect(m_x+w*remaining, m_y, w*current, h*current, 2);
  }
  private void drawSelector(float w, float h){
    if (m_current != -1) {
      fill(240);
      rect(m_x, m_y +m_current*h, w, h);
    }
  }
  private void writeOptions(){
    textAlign(LEFT, TOP);
    textSize(FONT_SIZE);
    for (int i=0; i<m_content.length; i++) {
      final Animator currentAnimator = m_animator[i+1];
      
      fill(currentAnimator.fadeColor(Palette.white, Palette.accent));
      text(m_content[i], m_x+m_marginH, m_y+m_marginV+i*m_spacement);
    }
  }

  public FloatMenu show() {
    m_visible = true;
    return this;
  }
  public FloatMenu hide() {
    m_visible = false;
    for(int i=0; i<m_animator.length; i++){
      m_animator[i].reset();
    }
    return this;
  }
  public boolean isVisible() {
    return m_visible;
  }

  public void checkState(){
    if (m_current < 0) return;

    if (m_context.mousePressed) {
      switch(m_current) {
      case 0:
        m_mainMenu.aboutProject();
        break;
      case 1:
        m_mainMenu.aboutEquip();
        break;
      case 2:
        break;
      case 3:
        exit();
        break;
      }
      
      this.hide();
    }
  }
  private void update() {
    final int   MOUSE_X = m_context.mouseX;
    final int   MOUSE_Y = m_context.mouseY;
    final float TOP_MARGIN = m_y+m_marginV;

    animatorsUpdate();

    if (MOUSE_X>m_x && MOUSE_X<m_x+m_biggestItem+2*m_marginH) {
      for (int i=0; i<m_content.length; i++) {
        if (MOUSE_Y>TOP_MARGIN +i*(FONT_SIZE+m_marginV) && MOUSE_Y<TOP_MARGIN+ (i+1)*(FONT_SIZE+m_marginV)) {
          if (VERBOSITY && i!=m_current) println("Opção: ", m_content[i]);
          m_current = i;
          break;
        }
      }
    } else {
      m_current = -1;
    }
  }
  private Animator getCurrentOptionToAnimate(){
    Animator out = null;
      
    for(int i=1; i<m_animator.length; i++){
      if(!m_animator[i].finished()){
        out = m_animator[i];
        return out;
      }
    }
    
    return null;
  }
  private void animatorsUpdate(){
    Animator backgroundAnimator = m_animator[BACKGROUND];
    
    backgroundAnimator.update();
    
    // Animate options
    if(backgroundAnimator.finished()){
      Animator current = getCurrentOptionToAnimate();
      if(current!=null) current.update();
    }
    
  }
}