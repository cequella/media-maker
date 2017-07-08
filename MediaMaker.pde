final String  DISPOSITIVE_SIZE = "MEDIUM";
final boolean VERBOSITY = true;

ScreenManager screenManager;

void settings() {
  if (DISPOSITIVE_SIZE.equals("SMALL")) {
    size(600, 400);
  } else if (DISPOSITIVE_SIZE.equals("BIG")) {
    size(1366, 768);
  } else { // DEFAULT
    size(800, 600);
  }
  //fullScreen();

  logo = loadImage(StrResource.logo);
  screenManager = new ScreenManager(this);
}

void draw() {
  background(Palette.main);
  screenManager.start();
}