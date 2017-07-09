
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
  private MainMenu m_mainMenu;

  private int m_current = -1;

  public FloatMenu(PApplet t_context, MainMenu t_mainMenu, float t_x, float t_y, String[] t_content) {
    m_context = t_context;
    m_mainMenu = t_mainMenu;
    m_x = t_x;
    m_y = t_y;
    m_content = t_content;
  }

  public void draw() {
    if (!m_visible) return;

    if (m_biggestItem == -1.0) {
      for (String l : m_content) {
        if (m_biggestItem<textWidth(l)) m_biggestItem = textWidth(l);
      }

      m_x -= m_biggestItem;
    }

    fill(Palette.white);
    rect(m_x, m_y, 
      m_biggestItem+2*m_marginH, m_spacement*m_content.length+m_marginV, 
      2);

    if (m_current != -1) {
      fill(240);
      rect(m_x, m_y +m_current*(16+m_marginV), m_biggestItem+2*m_marginH, 16+m_marginV);
    }
    textAlign(LEFT, TOP);
    textSize(16);
    for (int i=0; i<m_content.length; i++) {
      fill(Palette.accent);
      text(m_content[i], m_x+m_marginH, m_y+m_marginV+i*m_spacement);
    }

    update();
    checkState();
  }

  public FloatMenu show() {
    m_visible = true;
    return this;
  }
  public FloatMenu hide() {
    m_visible = false;
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
        m_mainMenu.aboutEquip();
        break;
      case 1:
        m_mainMenu.aboutProject();
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

    if (MOUSE_X>m_x && MOUSE_X<m_x+m_biggestItem+2*m_marginH) {
      for (int i=0; i<m_content.length; i++) {
        if (MOUSE_Y>TOP_MARGIN +i*(16+m_marginV) && MOUSE_Y<TOP_MARGIN+ (i+1)*(16+m_marginV)) {
          if (VERBOSITY && i!=m_current) println("Opção: ", m_content[i]);
          m_current = i;
          break;
        }
      }
    } else {
      m_current = -1;
    }
  }
}