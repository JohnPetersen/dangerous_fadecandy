
public class ConstantSpeedStrategy implements SpeedStrategy {
  public void updateSpeeds(InputState input, Point currentSpeeds) {
  }
}

/** When button 3 is pressed slider three is used to set the speed. */
public class InputDrivenSpeedStrategy implements SpeedStrategy {
  private int nextUpdateTime = 0;
  public void updateSpeeds(InputState input, Point currentSpeeds) {
    if (!input.isButton3()) return; // the input is not active for this strategy
    if (nextUpdateTime > millis()) return; // not enough time has ellapsed since the last update.
    if (input.isButton1()) {
      if (currentSpeeds.x > 0) {
        currentSpeeds.x -= 1;
      }
      if (currentSpeeds.y > 0) {
        currentSpeeds.y -= 1;
      }
    }
    // Using slightly different maximum values so we can get out of 
    // patterns which occur when the X & Y speeds are the same.
    if (input.isButton2()) {
      if (currentSpeeds.x < 101.0) {
        currentSpeeds.x += 1;
      }
      if (currentSpeeds.y < 109.0) {
        currentSpeeds.y += 1;
      }
    }
    nextUpdateTime = millis() + MIN_UPDATE_INTERVAL_MS;
  }
}
