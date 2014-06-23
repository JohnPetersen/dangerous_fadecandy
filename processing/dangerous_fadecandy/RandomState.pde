public class RandomState implements InputState {
  
  private final int rateSlider1;
  private final int rateSlider2;
  private final int rateSlider3;
  private final float chanceOnBtn1;
  private final float chanceOnBtn2;
  private final float chanceOnBtn3;
  
  private int directionSlider1 = 1;
  private int directionSlider2 = 1;
  private int directionSlider3 = 1;
  
  private int sld1 = 500;
  private int sld2 = 500;
  private int sld3 = 500;
  private boolean btn1 = false;
  private boolean btn2 = false;
  private boolean btn3 = false;
  private int light = 0;
  private int cap = 0;
  
  public RandomState(int rateSlider1, int rateSlider2, int rateSlider3, 
      float chanceOnBtn1, float chanceOnBtn2, float chanceOnBtn3) {
    if (rateSlider1 > SLIDER_MAX || rateSlider2 > SLIDER_MAX || rateSlider3 > SLIDER_MAX)
      throw new IllegalArgumentException("Slider rate must be less than the maximum slider value, " + SLIDER_MAX);
    this.rateSlider1 = rateSlider1;
    this.rateSlider2 = rateSlider2;
    this.rateSlider3 = rateSlider3;
    this.chanceOnBtn1 = chanceOnBtn1;
    this.chanceOnBtn2 = chanceOnBtn2;
    this.chanceOnBtn3 = chanceOnBtn3;
  }
  
  public void update() {
    
    sld1 += rateSlider1 * directionSlider1;
    if (sld1 < SLIDER_MIN) {
      sld1 = SLIDER_MIN;
      directionSlider1 *= -1;
    } else if (sld1 > SLIDER_MAX) {
      sld1 = SLIDER_MAX;
      directionSlider1 *= -1;
    }
    sld2 += rateSlider2 * directionSlider2;
    if (sld2 < SLIDER_MIN) {
      sld2 = SLIDER_MIN;
      directionSlider2 *= -1;
    } else if (sld2 > SLIDER_MAX) {
      sld2 = SLIDER_MAX;
      directionSlider2 *= -1;
    }
    sld3 += rateSlider3 * directionSlider3;
    if (sld3 < SLIDER_MIN) {
      sld3 = SLIDER_MIN;
      directionSlider3 *= -1;
    } else if (sld3 > SLIDER_MAX) {
      sld3 = SLIDER_MAX;
      directionSlider3 *= -1;
    }
    
    btn1 = random(1.0) <= chanceOnBtn1;
    btn2 = random(1.0) <= chanceOnBtn2;
    btn3 = random(1.0) <= chanceOnBtn3;
    
    light = (int)(SLIDER_MAX / 2.0 + randomGaussian());
    if (light < SLIDER_MIN) {
      light = SLIDER_MIN;
    } else if (light > SLIDER_MAX) {
      light = SLIDER_MAX;
    }
    cap = (int)(SLIDER_MAX / 2.0 + randomGaussian());
    if (cap < SLIDER_MIN) {
      cap = SLIDER_MIN;
    } else if (cap > SLIDER_MAX) {
      cap = SLIDER_MAX;
    }
    
  }
  
  public int getSlider1() {
    return sld1;
  }
  
  public int getSlider2() {
    return sld2;
  }
  
  public int getSlider3() {
    return sld3;
  }
  
  public boolean isButton1() {
    return btn1;
  }
  
  public boolean isButton2() {
    return btn2;
  }
  
  public boolean isButton3() {
    return btn3;
  }
  
  public int getLight() {
    return light;
  }
  
  public int getCapSense() {
    return cap;
  }
}

