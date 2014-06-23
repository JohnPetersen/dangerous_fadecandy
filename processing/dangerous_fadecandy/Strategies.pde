public class Point {
  public float x;
  public float y;
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

public static final int MIN_UPDATE_INTERVAL_MS = 50;

public interface SpeedStrategy {
  /** Given a set of inputs provide the speeds in the x and y directions. */
  public void updateSpeeds(InputState input, Point currentSpeeds);
}

public interface MotionStrategy {
  /** Given a set of inputs and the current speeds provide the next position. */
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition);
}

public interface ColorStrategy {
  /** Given the input and current color provide a new color. */
  public color updateColor(InputState input, color currentColor);
}

public interface ScaleStrategy {
  /** Given the input and current scale factors provide new scale factors. */
  public void updateScaleFactors(InputState input, Point currentScaleFactors);
}
