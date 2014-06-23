
public class Img {
  private final PImage i;
  protected color currentColor;
  protected final Point currentPosition;
  protected final Point currentSpeed;
  protected final int w;
  protected final int h;
  protected final Point currentScale;
  protected final BBox bounds;
  protected final InputState input;
  
  private SpeedStrategy speedStrat;
  private MotionStrategy motionStrat;
  private ColorStrategy colorStrat;
  private ScaleStrategy scaleStrat;
  
  public Img(String imagePath, color c, int x, int y, int dx, int dy, int w, int h, BBox bounds, InputState input,
      SpeedStrategy speedStrat, MotionStrategy motionStrat, ColorStrategy colorStrat, ScaleStrategy scaleStrat) {
    this.i = loadImage(imagePath);
    this.currentColor = c;
    this.currentPosition = new Point(x, y);
    this.currentSpeed = new Point(dx, dy);
    this.w = w;
    this.h = h;
    this.currentScale = new Point(1.0, 1.0);
    this.bounds = bounds;
    this.input = input;
    this.speedStrat = speedStrat;
    this.motionStrat = motionStrat;
    this.colorStrat = colorStrat;
    this.scaleStrat = scaleStrat;
  }
  
  public void draw() {
    this.speedStrat.updateSpeeds(this.input, this.currentSpeed);
    this.motionStrat.updatePosition(this.input, this.bounds, this.currentSpeed, this.currentPosition);
    this.currentColor = this.colorStrat.updateColor(this.input, this.currentColor);
    this.scaleStrat.updateScaleFactors(this.input, this.currentScale);
     
    float tmpWidth = this.w * this.currentScale.x;
    float tmpHeight = this.h * this.currentScale.y;
    tint(this.currentColor);
    image(i, this.currentPosition.x-tmpWidth/2.0, this.currentPosition.y-tmpHeight/2.0, tmpWidth, tmpHeight);
  }
}  
