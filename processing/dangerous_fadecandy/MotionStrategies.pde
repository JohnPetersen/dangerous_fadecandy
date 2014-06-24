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

public class FollowerMotionStrategy implements MotionStrategy {
  private final Img leader;
  public FollowerMotionStrategy(Img leader) {
    this.leader = leader;
  }
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition) {
    float followDistance = leader.w * leader.currentScale.x / 2.0;
    float dx = leader.currentPosition.x - currentPosition.x;
    float dy = leader.currentPosition.y - currentPosition.y;
    float distanceToLeader = sqrt(sq(dx) + sq(dy));
    float heading = atan2(dy, dx);
    currentPosition.x += (distanceToLeader - followDistance) * cos(heading);
    currentPosition.y += (distanceToLeader - followDistance) * sin(heading);
  }
}

public class OrbitalMotionStrategy implements MotionStrategy {
  private float theta;
  private final float thetaStep;
  private final Img leader;
  public OrbitalMotionStrategy(Img leader, float thetaStep, float initialTheta) {
    this.leader = leader;
    this.thetaStep = thetaStep;
    this.theta = initialTheta;
  }
  public OrbitalMotionStrategy(Img leader, float thetaStep) {
    this(leader, thetaStep, 0.0);
  }
  public OrbitalMotionStrategy(Img leader) {
    this(leader, 0.1);
  }
  public void updatePosition(InputState input, BBox bounds, Point currentSpeeds, Point currentPosition) {
    float radius = leader.w * leader.currentScale.x / 2.0;
    theta = (theta + thetaStep) % TWO_PI;
    currentPosition.x = leader.currentPosition.x + cos(theta) * radius;
    currentPosition.y = leader.currentPosition.y + sin(theta) * radius;
  }
}

