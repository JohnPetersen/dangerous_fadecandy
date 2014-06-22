/**
 * This class displays an image at the mouse location
 */
public class MouseImg extends Img {
  public MouseImg(String imagePath, int w, int h) {
    super(imagePath, mouseX, mouseY, w, h);
  }

  protected void updatePosition() {
    super.x = mouseX;
    super.y = mouseY;
  }
}
