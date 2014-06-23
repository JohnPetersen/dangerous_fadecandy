/**
 * This class displays an image at the mouse location
 */
public class MouseImg extends Img {
  public MouseImg(String imagePath, int w, int h, InputState input) {
    super(imagePath, mouseX, mouseY, w, h, input);
  }

  protected void updatePosition() {
    super.x = mouseX;
    super.y = mouseY;
  }
}
