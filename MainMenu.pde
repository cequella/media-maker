class MainMenu extends Screen {
  private final int width_3;
  
  //FORCE ALIGN
  private final int subLabelTopMargin = 35;
  private final int cardsTopMargin = 70;
  
  private TopBar m_bar;
  private Label  m_label, m_subLabel;
  private Card   m_card[] = new Card[4];
  
  public MainMenu(PApplet t_context) {
    super(t_context, "Home");
    width_3 = t_context.width/3;
    
    m_bar      = new TopBar(t_context, title());
    m_label    = new Label(title(), Label.MEDIUM, 10, 15);
    m_subLabel = new Label("Selecione que tipo de material você precisa produzir:", Label.SMALL, 10, 15+subLabelTopMargin);
    
    m_card[0] = new Card(t_context, 0,         0+cardsTopMargin,   width_3, 150);
    m_card[1] = new Card(t_context, width_3,   0+cardsTopMargin,   width_3, 150);
    m_card[2] = new Card(t_context, 2*width_3, 0+cardsTopMargin,   width_3, 150);
    m_card[3] = new Card(t_context, 0,         150+cardsTopMargin, width_3, 150);
    
    final String[] temp_label = {"Vídeo", "Slide", "Site/Blog", "Redes Sociais"};
    final String[] temp_icon = {"assets/icon-video.png", "assets/icon-presentation.png", "assets/icon-web.png", "assets/icon-wifi.png"};
    
    for(int i=0; i<m_card.length; i++){
      Card temp = m_card[i];
      temp.padding(5)
          .setBackground(Palette.main)
          .label(temp_label[i])
          .icon(temp_icon[i]);
    }
  }
  
  @Override
  void ready(PApplet context){
    setBackground(Palette.accent);
    
    m_bar.draw();
    
    //space(20);
    m_label.draw();
    m_subLabel.draw();
    
    //space(15);
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
        changeScreen(new VideoMenu(context));
      }
    }
  }
}