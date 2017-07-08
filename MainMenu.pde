class MainMenu extends Screen {
  final int LOGO_SIZE  = 100;
  final int LOGO_SPEED = 5;

  private PImage     m_logo;
  private Card[]     m_card;
  private TopBar     m_topBar;
  private PageViewer m_slide, m_video, m_current;
  private Card       m_currentCard = null;

  private float m_logoSize;
  private float m_logoX, m_logoY;

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
    if(m_current==null){
      image(m_logo, m_logoX, m_logoY, m_logoSize, m_logoSize);
      if (m_logoX < (4.0*width-3.0*LOGO_SIZE)/6.0) {
        m_logoX += LOGO_SPEED;
        return;
      }
    }

    // Draw Icons
    for (int i=0; i<m_card.length; i++) {
      m_card[i].draw();
    }

    //Draw page viewer
    if (m_current!=null) m_current.draw();

    //Draw Top bar
    m_topBar.draw();
  }
  @Override protected void load(PApplet context) {
    m_logo = logo;
    m_card = new Card[4];

    // Create menu options
    final String[] label = new String[]{"Vídeo", "Apresentação", "Site/Blog", "RedeSocial"};
    final String[] path  = new String[]{"004-multimedia.png", "002-presentation.png", "003-search-engine.png", "001-network.png"};

    final float cardHeight = (height-TopBar.BAR_HEIGHT)/m_card.length;
    for (int i=0; i<m_card.length; i++) {
      m_card[i] = new Card(context, 
        0, i*cardHeight+TopBar.BAR_HEIGHT, 
        width/3.0, cardHeight);

      m_card[i].setBackground(Palette.main_dark)
        .setForeground(150)
        .label(label[i])
        .icon("assets/icons/"+path[i])
        .iconSize(50.0)
        .roundness(0);
    }

    //Top bar
    m_topBar = new TopBar(context, Palette.main_light, "MediaMaker");

    //Page Viewer
    m_slide = new PageViewer(context, 
      width/3.0+10, TopBar.BAR_HEIGHT+10, 
      0.66*width-20.0, height-TopBar.BAR_HEIGHT-10.0-20.0, 
      this.createSlideList(context));
      
    m_video = new PageViewer(context, 
      width/3.0+10, TopBar.BAR_HEIGHT+10, 
      0.66*width-20.0, height-TopBar.BAR_HEIGHT-10.0-20.0, 
      this.createVideoList(context));
  }
  ExpandAnimation[] createSlideList(PApplet context){
    final ExpandAnimation[] slideList = new ExpandAnimation[3];
    for (int i=0; i<slideList.length; i++){
      slideList[i] = new ExpandAnimation(context, Content.getSlide(i));
      if(i==1) slideList[i].horizontal();
    }
    
    return slideList;
  }
  ExpandAnimation[] createVideoList(PApplet context){
    final ExpandAnimation[] videoList = new ExpandAnimation[6];
    for (int i=0; i<videoList.length; i++){
      videoList[i] = new ExpandAnimation(context, Content.getVideo(i));
      
      if(i == 3 || i == 4) videoList[i].horizontal();
    }
    
    return videoList;
  }
  @Override protected void events(PApplet context) {
    cardEvents();
  }

  //-------------------------------------------------
  private void activeCard(Card card) {
    card.setForeground(255).iconSize(55.0);
  }
  private void deactiveCard(Card card) {
    card.setForeground(150).setBackground(Palette.main_dark).iconSize(50.0);
  }
  private void selectCard(Card card) {
    m_currentCard = card;
    card.setForeground(255).setBackground(Palette.main).iconSize(55.0);
  }

  private void cardEvents() {
    if (m_card == null) return;

    for (int i=0; i<m_card.length; i++) {
      Card card = m_card[i];
      if (card==null || card==m_currentCard) continue;

      if (card.mouseOver()) {
        activeCard(card);
      } else {
        deactiveCard(card);
      }

      if (card.clicked()) {
        if (VERBOSITY) println("Card \'"+card.label()+"\' clicked");
        selectCard(card);

        switch(i) {
        case 0:
          m_current = m_video;
          break;
        case 1:
          m_current = m_slide;
          break;
        default:
          m_current = null;
        }
      }
    }
  }
}