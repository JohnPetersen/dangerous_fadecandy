public class ConstantColorStrategy implements ColorStrategy {
  public color updateColor(InputState input, color currentColor) {
    return currentColor;
  }
}

public class RGBSliderColorStrategy implements ColorStrategy {
  public color updateColor(InputState input, color currentColor) {
    return color(map(input.getSlider1(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255),
        map(input.getSlider2(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255),
        map(input.getSlider3(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255));
  }
}

public class RandomColorStrategy implements ColorStrategy {
  private float rCoord = 0.0;
  private float gCoord = 0.0;
  private float bCoord = 0.0;
  private final float rIncrement = 0.07;
  private final float gIncrement = 0.13;
  private final float bIncrement = 0.03;
  private int nextUpdateTime = 0;
  public color updateColor(InputState input, color currentColor) {
    if (nextUpdateTime > millis()) return currentColor; // not enough time has ellapsed since the last update.
    nextUpdateTime = millis() + MIN_UPDATE_INTERVAL_MS;
    float r = 255 * noise(rCoord+=rIncrement);
    float g = 255 * noise(gCoord+=gIncrement);
    float b = 255 * noise(bCoord+=bIncrement);
    return color(r, g, b);
  }
}
