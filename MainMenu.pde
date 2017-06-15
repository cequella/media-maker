class MainMenu extends Screen {
  final int LOGO_SIZE   = 100;
  final int LOGO_SPEED  = 5;

  private PImage m_logo;
  private Card[] m_card;
  private TopBar m_topBar;
  private Card   m_currentCard = null;

  private float  m_logoSize;
  private float  m_logoX, m_logoY;

  public MainMenu(PApplet t_context) {
    super(t_context, "Home");
    m_logoSize = LOGO_SIZE;
    m_logoX    = (width-m_logoSize)/2;
    m_logoY    = (height-m_logoSize)/2;
  }

  @Override protected void notReady(PApplet context) {
  }
  @Override protected void ready(PApplet context) {
    // Draw Logo
    image(m_logo, m_logoX, m_logoY, m_logoSize, m_logoSize);
    if (m_logoX < (4.0*width-3.0*LOGO_SIZE)/6.0) {
      m_logoX += LOGO_SPEED;
      return;
    }

    // Draw Icons
    for (int i=0; i<m_card.length; i++) {
      m_card[i].draw();
    }
    
    //Draw Top bar
    m_topBar.draw();
  }
  @Override protected void load(PApplet context) {
    m_logo = loadImage(StrResource.logo);
    m_card = new Card[4];

    // Create menu options
    final String[] label = new String[]{"Vídeo", "Apresentação", "Site/Blog", "RedeSocial"};
    final String[] path  = new String[]{"004-multimedia.png", "002-presentation.png", "003-search-engine.png", "001-network.png"};
    
    final float cardHeight = (height-TopBar.BAR_HEIGHT)/m_card.length;
    for (int i=0; i<m_card.length; i++) {
      m_card[i] = new Card(context, 
                            0,         i*cardHeight+TopBar.BAR_HEIGHT, 
                            width/3.0, cardHeight);

      m_card[i].setBackground(Palette.main_dark)
        .setForeground(150)
        .label(label[i])
        .icon("assets/"+path[i])
        .iconSize(50.0)
        .roundness(0);
    }
    
    //Top bar
    m_topBar = new TopBar(context, title());
  }
  @Override protected void events(PApplet context) {
    //TopBar event
    if(m_topBar != null){
      if(m_topBar.clicked() && m_topBar.child("option")) println("Ola mundo");
    }
    cardEvents();
  }
  
  //-------------------------------------------------
  private void activeCard(Card card){
    card.setForeground(255).iconSize(55.0);
  }
  private void deactiveCard(Card card){
    card.setForeground(150).setBackground(Palette.main_dark).iconSize(50.0);
  }
  private void selectCard(Card card){
    m_currentCard = card;
    card.setForeground(255).setBackground(Palette.main).iconSize(55.0);
  }
  
  private void cardEvents(){
    if(m_card == null) return;
    
    for(int i=0; i<m_card.length; i++){
      Card card = m_card[i];
      if(card==null || card==m_currentCard) continue;
      
      if(card.mouseOver()){
        activeCard(card);
      } else {
        deactiveCard(card);
      }
      
      if(card.clicked()){
        if(VERBOSITY) println("Card \'"+card.label()+"\' clicked");
        selectCard(card);
      }
    }
  }
}