SplashScreen splashScreen;

void settings() {
  //size(600, 400);
  //size(1366, 768);
  size(800, 600);  
  
  splashScreen = new SplashScreen("assets/Logo_big.png", "Ubuntu-Light-48.vlw", 100, 100);
}

void draw() {
  background(Palette.main);
  splashScreen.show();
}