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

public class SingleSliderColorStrategy implements ColorStrategy {
  private final int sliderNumber;
  public SingleSliderColorStrategy(int sliderNumber) {
    this.sliderNumber = sliderNumber;
  }
  public color updateColor(InputState input, color currentColor) {
    int sliderVal = 0;
    if (this.sliderNumber == 2) {
      sliderVal = input.getSlider2();
    } else if (this.sliderNumber == 3) {
      sliderVal = input.getSlider3();
    } else {
      sliderVal = input.getSlider1();
    }
    return 0xff000000 | (int)(map(sliderVal, InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 16777215));
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
  private final float rFixed;
  private final float gFixed;
  private final float bFixed;
  public RandomColorStrategy() {
    this(-1.0, -1.0, -1.0);
  }
  public RandomColorStrategy(float rFixed, float gFixed, float bFixed) {
    this.rFixed = rFixed;
    this.gFixed = gFixed;
    this.bFixed = bFixed;
  }
  public color updateColor(InputState input, color currentColor) {
    if (nextUpdateTime > millis()) return currentColor; // not enough time has ellapsed since the last update.
    nextUpdateTime = millis() + MIN_UPDATE_INTERVAL_MS;
    float r = rFixed >= 0 ? rFixed : 255 * noise(rCoord+=rIncrement);
    float g = gFixed >= 0 ? gFixed : 255 * noise(gCoord+=gIncrement);
    float b = bFixed >= 0 ? bFixed : 255 * noise(bCoord+=bIncrement);
    return color(r, g, b);
  }
}
