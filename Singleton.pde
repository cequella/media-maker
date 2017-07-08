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
    Content  out   = null;
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
        
        out = new Content(icon, title, text);
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
        
        out = new Content(icon, title, text);
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
        
        out = new Content(icon, title, text);
    }

    return out;
  }
}