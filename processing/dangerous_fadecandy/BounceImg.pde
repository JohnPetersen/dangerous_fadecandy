/**
 * This class displays an image at the mouse location
 */
public class BounceImg extends Img {
  private static final int MAX_SPEED = 100;
  private static final int MIN_SPEED = 0;
  
  // Speeds must never exceed the dimentions of the bounding area.
  private int speed = 50;
  private int speedX = 13;
  private int speedY = 19;
  
  private final BBox bounds;
  
  public BounceImg(String imagePath, int w, int h, BBox bounds) {
    super(imagePath, mouseX, mouseY, w, h);
    this.bounds = bounds;
  }

  public void increaseSpeed() {
    if (this.speed < MAX_SPEED) {
      this.speed += 10;
    }
  }
  public void decreaseSpeed() {
    if (this.speed > MIN_SPEED) {
      this.speed -= 10;
    }
  }
  
  protected void updatePosition() {
    // Wierd things will happen if the image speed is greater than the dimention it is for.
    int newX = super.x + this.speedX;
    int newY = super.y + this.speedY;
    if (newX > bounds.getRight()) {
      newX = bounds.getRight() - ( newX - bounds.getRight() );
      speedX *= -1;
    }
    if (newX < bounds.getLeft()) {
      newX = bounds.getLeft() + ( bounds.getLeft() - newX );
      speedX *= -1;
    }
    if (newY > bounds.getBottom()) {
      newY = bounds.getBottom() - ( newY - bounds.getBottom() );
      speedY *= -1;
    }
    if (newY < bounds.getTop()) {
      newY = bounds.getTop() + ( bounds.getTop() - newY );
      speedY *= -1;
    }
  
    super.x = newX;
    super.y = newY;
  }
}
