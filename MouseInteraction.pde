interface MouseInteraction {
  void onStateChange(int oldState, int newState);
  void onClick();
  void onHold();
}