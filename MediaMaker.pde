final String DISPOSITIVE_SIZE = "SMALL";

ScreenManager screenManager;

void settings() {
  if (DISPOSITIVE_SIZE.equals("SMALL")){
    size(600, 400);
  } else if (DISPOSITIVE_SIZE.equals("BIG")) {
    size(1366, 768);
  } else { // DEFAULT
    size(800, 600);
  }
  
  screenManager = new ScreenManager();
}

void draw() {
  background(Palette.main);
  screenManager.start();
}