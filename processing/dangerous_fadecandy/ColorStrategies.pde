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
