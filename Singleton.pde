final static class Palette {
  final static color main_light     = #3d1b4c;
  final static color main           = #48468C;
  final static color main_dark      = #1F0E26;
  final static color secundary      = #EAF2CE;
  final static color secundary_dark = #D6D9BF;
  final static color accent         = #FF8000;
  final static color accent_dark    = #D66C02;
  final static color white          = #fafafa;
};

final static class StrResource {
  final static String logo    = "assets/Logo_big.png";
  final static String fontS   = "Ubuntu-Light-14.vlw";
  final static String fontM   = "Ubuntu-Light-22.vlw";
  final static String fontB   = "Ubuntu-Light-48.vlw";
  final static String name    = "MediaMaker";
  final static String loading = "Loading...";
}

final static class Credits {
  final static String[] creation = new String[]{"001-network.png", 
    "002-presentation.png", 
    "003-search-engine.png", 
    "004-multimedia.png", 
    "005-power-button.png", 
    "006-more.png", };
  final static String[] author   = new String[]{"Madebyoliver from Flaticon", 
    "Freepik from Flaticon", 
    "Freepik from Flaticon", 
    "Madebyoliver from Flaticon", 
    "Freepik from Flaticon", 
    "Madebyoliver from Flaticon", };
}

// WIDGETS
final int STATE_CLICKED     = 1;
final int STATE_HOLDED      = 2;
final int STATE_NOT_CLICKED = 0;

// LOGO
PImage logo = new PImage();

// SLIDE
static class Content {
  private String[] icon;
  private String[] title;
  private String[] text;

  public Content(String[] icon, String[] title, String[] text) {
    this.icon = icon;
    this.title = title;
    this.text = text;
  }

  public static Content getSlide(int index) {
    String[] icon  = null;
    String[] title = null;
    String[] text  = null;

    if (index == 0) {
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Pesquisa", "Análise", "Resumo"};
      text = new String[]{
        "Esolha uma fonte confiável. Leia e anote informações importantes.", 
        "Comprar informações e orgarnizá-las em formato de tópicos.", 
        "Escrever o básico que será descrito ao longo do trabalho."};
    } else if (index == 1) {
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Capa", "Introdução", "Desenvolvimento", "Conclusão", "Referências"};
      text = new String[]{
        "Onde devem ficar informações básicas como nome de equipe e projeto. Seja minimalista.", 
        "Explicação dos objetivos, materiais e programa utilizados. Importante para embasar o projeto.", 
        "Conteúdo propriamente dito. Apresente o máximo possível de imagens, com texto curtos pontuais.", 
        "Espaço destinado a apresentar o que foi aprendido e os resultados obtidos.", 
        "Alguns trabalhos exigem apresentação das referências. Dedique esse espaço às fontes de pesquisa."};
    } else {
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Paleta", "Imagens", "Gráficos"};
      text = new String[]{
        "Utilize cores agradáveis, elas são muito importante para quem for assistir sua apresentação. Existe sites que montam paletas e até temas para você.", 
        "Priorize imagens com tamanho e resolução altos. Isso minimiza, ou até mesmo evita, perca de qualidade gráfica.", 
        "Cada formato de gráfico tem uma utilidade, certifique-se de usar o que melhor apresente suas informações.",};
    }

    return new Content(icon, title, text);
  }
  
  public static Content getVideo(int index) {
    String[] icon  = null;
    String[] title = null;
    String[] text  = null;
    
    if(index == 0){
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Idéia", "Foco", "Organização"};
      text = new String[]{
        "Elabore brainstorms até surigr uma ideia. Então crie tópicos para lhe guiar.", 
        "Não seja prolixo. Não perca tempo explicando coisas não importantes. Cada segundo vale muito.", 
        "Teste seu roteiro, repasse suas falas, meça o tempo... Não tenha medo de reescrever o roteiro.",};
        
        
    } else if(index == 1){
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Cenário", "Organização", "Harmonia"};
      text = new String[]{
        "Procure um cenário com um bom fundo para gravar. Silencioso, bem iluminado e sem muito movimento.", 
        "Lembre de preparar o cenário antes de gravar. Remover lixo, animais e tudo que não seja útil ao objetivo.", 
        "Menos é mais. Não polua visualmente a cena. Separe cenas com poucos objetos, ao invés de uma com vários.",};
    } else if(index == 2){
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Iluminação Homogênea", "Iluminação Artificial", "Iluminação Ambiente"};
      text = new String[]{
        "Mantenha o padrão de iluminação bom em todo o vídeo. Nada de 'cena clara' e 'cena escura'.", 
        "Em locais fechados, teste posição para luz artificial. Procure sobre 'iluminação de 3 pontos' e 'iluminação difusa'.", 
        "De frente para a janela é um ótimo local para gravar. A luz natural é balanceada, difusa e homogêna.",};
    } else if(index == 3){
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Local barulhento", "Ruído", "Equipamento", "Sincronia", "Celular"};
      text = new String[]{
        "Não grave em ambientes barulhentos. Procure sempre o mais silencioso possível.", 
        "Alguns ruídos só são ouvidos na gravação (ventilador, vento, sopro de fala), tente evitá-los.", 
        "Manter headsets e microfones são essenciais. Mas nada que um bom celular não faça.",
        "Gravar áudio separado ajuda na edição. Uma 'palma' pode ser o suficiente para você sincronizá-los depois.",
        "Use um bom celular para gravar seus áudios. Alguns até mesmo permitem edição via aplicativos."};
    } else if(index == 4){
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Celular", "Estabilidade", "Enquadramento", "Coragem"};
      text = new String[]{
        "Use um bom celular para gravar seus vídeos. Cuidado pois alguns escurecem ou distorcem a imagem.", 
        "Mantenha a câmera estável. Para isso, use um tripé improvisado. Não grave hand-cam, pode sair impraticável.", 
        "Procure enquadrar bem (objeto ou pessoa), centralizado e com 'margens de respiro' para evitar poluição visual.",
        "Não tenha medo de errar na hora de ler o roteiro. E sempre coloque legenda para o caso de problemas na execução do áudio.",};
    } else {
      icon = new String[]{
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png", 
        "assets/icons/001-network.png"};
      title = new String[]{
        "Corte Rápido", "Sincronização", "Edição e Divulgação"};
      text = new String[]{
        "Assista seu vídeo e corte partes ociosas. Mantenha o vídeo mais dinâmico e curto.", 
        "Sincronize o áudio (esse também deve ser cortado). Muito cuidado nessa parte, é onde os erros ficam mais evidentes.", 
        "Busque programas de edição que facilitem seu trabalho. E divulgue o material num meio válido para seu público.",};
    }
    
    return new Content(icon, title, text);
  }
}