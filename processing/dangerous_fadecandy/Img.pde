
public class Img {
  private final PImage i;
  protected int x = 0;
  protected int y = 0;
  protected int w = 0;
  protected int h = 0;
  
  public Img(String imagePath, int x, int y, int w, int h) {
    i = loadImage(imagePath);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  protected void updatePosition() {
    // default image behavior is to remain in it's original position.
  }
  
  public void draw() {
    updatePosition();
    image(i, this.x-this.w/2.0, this.y-this.h/2.0, this.w, this.h);
  }
}  
