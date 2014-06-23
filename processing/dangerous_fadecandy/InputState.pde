public interface InputState {
  
  public static final int SLIDER_MIN = 0;
  public static final int SLIDER_MAX = 1023;
  
  public void update();
  public int getSlider1();
  public int getSlider2();
  public int getSlider3();
  public boolean isButton1();
  public boolean isButton2();
  public boolean isButton3();
  public int getLight();
  public int getCapSense();
}
