
public class ConstantScaleStrategy implements ScaleStrategy {
  public void updateScaleFactors(InputState input, Point currentScaleFactors) {
  }
}

public class ButtonInputScaleStrategy implements ScaleStrategy {
  public void updateScaleFactors(InputState input, Point currentScaleFactors) {
    if (input.isButton3()) return; // button 3 indicates another strategy is using this input.
    // Adjust the image size based on button status.
    if (input.isButton1()) {
      if (currentScaleFactors.x > 0) {
        currentScaleFactors.x -= 0.1;
      }
      if (currentScaleFactors.y > 0) {
        currentScaleFactors.y -= 0.1;
      }
    }
    if (input.isButton2()) {
      if (currentScaleFactors.x < 100.0) {
        currentScaleFactors.x += 0.1;
      }
      if (currentScaleFactors.y < 100.0) {
        currentScaleFactors.y += 0.1;
      }
    }
  }
}
