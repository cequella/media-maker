class MainMenu extends Screen {
  private final int width_3;
  
  private Card m_card[] = new Card[4];
  
  public MainMenu(PApplet t_context) {
    super(t_context, "MainMenu");
    width_3 = t_context.width/3;
    
    m_card[0] = new Card(t_context, 0,         0,   width_3, 150);
    m_card[1] = new Card(t_context, width_3,   0,   width_3, 150);
    m_card[2] = new Card(t_context, 2*width_3, 0,   width_3, 150);
    m_card[3] = new Card(t_context, 0,         150, width_3, 150);
    
    for(Card c : m_card) c.padding(5).setBackground(Palette.main);
  }
  
  @Override
  void ready(PApplet context){
    setBackground(Palette.accent);
    
    for(Card c : m_card){
      c.draw();
    }
  }
  
  @Override
  void notReady(PApplet context){
    
  }
  
  @Override
  void load(PApplet context){
    
  }
  
  @Override
  void events(PApplet context){
    //if(m_card[0].m_clickState!=CARD_NOT_CLICKED) println(m_card[0].m_clickState);
    for(int i=0; i<m_card.length; i++) {
      if(m_card[i].clicked()){
        println("clicou: ", i);
      }
    }
  }
}