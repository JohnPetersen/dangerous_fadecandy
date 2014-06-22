public class BBox {
  private final int x;
  private final int y;
  private final int w;
  private final int h;
  
  public BBox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public boolean contains(int testX, int testY) {
    return !(testX < this.x || testY < this.y ||
        testX > this.x + this.w ||
        testY > this.y + this.h);
  }

  public int getTop() {
    return y;
  }
  
  public int getBottom() {
    return y + h;
  }
  
  public int getLeft() {
    return x;
  }
  
  public int getRight() {
    return x + w;
  }
  
  public void draw() {
    rect(x, y, w, h);
  }

}
