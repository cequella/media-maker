final int CARD_CLICKED       = 1;
final int CARD_STILL_CLICKED = 2;
final int CARD_NOT_CLICKED   = 0;

class Card {
  private PApplet m_context;
  private int m_x, m_y, m_width, m_height;
  private int m_padding;
  private color m_color=255;

  //AUX
  final int m_left;
  final int m_top;
  final int m_right;
  final int m_bottom;

  int m_clickState = CARD_NOT_CLICKED;

  public Card(PApplet t_context, int t_x, int t_y, int t_width, int t_height) {
    m_context = t_context;
    m_x = t_x;
    m_y = t_y;
    m_width = t_width;
    m_height = t_height;

    m_left   = m_x+m_padding;
    m_top    = m_y+m_padding;
    m_right  = m_left+m_width-2*m_padding;
    m_bottom = m_top+m_height-2*m_padding;
  }

  // State machine
  private void updateState() {
    if (m_context.mousePressed) {
      if (mouseOver()) {
        if (m_clickState == CARD_NOT_CLICKED) {
          m_clickState = CARD_CLICKED;
        } else {
          if (m_clickState == CARD_CLICKED) m_clickState = CARD_STILL_CLICKED;
        }
      }
    } else {
      m_clickState = CARD_NOT_CLICKED;
    }
  }

  public void draw() {
    fill(m_color);
    noStroke();
    rect(m_x+m_padding, m_y+m_padding, m_width-2*m_padding, m_height-2*m_padding, 3);
    updateState();
  }

  public Card padding(int t_padding) {
    m_padding = t_padding;
    return this;
  }
  public Card setBackground(color t_color) {
    m_color = t_color;
    return this;
  }

  public boolean clicked() {
    return m_clickState==CARD_CLICKED;
  }
  public boolean stillClicked() {
    return m_clickState==CARD_STILL_CLICKED;
  }
  public boolean mouseOver() {
    return m_context.mouseX > m_left && 
      m_context.mouseX < m_right &&
      m_context.mouseY > m_top &&
      m_context.mouseY < m_bottom;
  }
}

/*
if (m_context.mouseX > m_left && 
 m_context.mouseX < m_right &&
 m_context.mouseY > m_top &&
 m_context.mouseY < m_bottom)
 */