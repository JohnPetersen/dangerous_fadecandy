public class StationaryMotionStrategy implements MotionStrategy {
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition) {
  }
}

public class MouseMotionStrategy implements MotionStrategy {
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition) {
    currentPosition.x = mouseX;
    currentPosition.y = mouseY;
  }
}

public class BouncingMotionStrategy implements MotionStrategy {
  private int xDirection = 1;
  private int yDirection = 1;
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition) {
    // Wierd things will happen if the image speed is greater than the dimention it is for.
    float newX = currentPosition.x + (currentSpeeds.x * xDirection);
    float newY = currentPosition.y + (currentSpeeds.y * yDirection);
    if (newX > bounds.getRight()) {
      newX = bounds.getRight() - ( newX - bounds.getRight() );
      xDirection *= -1;
    }
    if (newX < bounds.getLeft()) {
      newX = bounds.getLeft() + ( bounds.getLeft() - newX );
      xDirection *= -1;
    }
    if (newY > bounds.getBottom()) {
      newY = bounds.getBottom() - ( newY - bounds.getBottom() );
      yDirection *= -1;
    }
    if (newY < bounds.getTop()) {
      newY = bounds.getTop() + ( bounds.getTop() - newY );
      yDirection *= -1;
    }
    currentPosition.x = newX;
    currentPosition.y = newY;
  }
}
