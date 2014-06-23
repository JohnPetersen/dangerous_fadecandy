
public class Img {
  private final PImage i;
  protected int x = 0;
  protected int y = 0;
  protected final int w;
  protected final int h;
  protected float sizeScale = 1.0;
  protected final InputState input;
  
  public Img(String imagePath, int x, int y, int w, int h, InputState input) {
    i = loadImage(imagePath);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.input = input;
  }
  
  protected void updatePosition() {
    // default image behavior is to remain in it's original position.
  }
  
  protected void updateSize() {
    // Adjust the image size based on button status.
    if (input.isButton1() && sizeScale > 0) {
      sizeScale -= 0.1;
    }
    if (input.isButton2() && sizeScale < 100.0) {
      sizeScale += 0.1;
    }
  }
  
  public void draw() {
    updatePosition();
    updateSize();
    
    float tmpWidth = this.w * this.sizeScale;
    float tmpHeight = this.h * this.sizeScale;
    image(i, this.x-tmpWidth/2.0, this.y-tmpHeight/2.0, tmpWidth, tmpHeight);
  }
}  
