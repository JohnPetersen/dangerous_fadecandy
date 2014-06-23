public class SerialState implements InputState {
  private final Serial serial;
  
  private int sld1 = 500;
  private int sld2 = 500;
  private int sld3 = 500;
  private boolean btn1 = false;
  private boolean btn2 = false;
  private boolean btn3 = false;
  private int light = 0;
  private int cap = 0;
  
  public SerialState(Serial s) {
    this.serial = s;
  }
  
  private int getInt(String s, int def) {
    try {
      return Integer.parseInt(s);
    } catch (NumberFormatException e) {
      return def;
    }
  }
  
  public void update() {
    if (serial.available() < 62) {
      return;
    }
    String msg = serial.readStringUntil('\n'); // 10 == line feed
    if (msg != null) {
      println("Parsing new message");
      String[] data = msg.split(" ");
      for (int i = 1; i <= data.length - 1; i++) {
        // Parse the recieved values, but skip the first and last 
        // elements since they're usually malformed.
        try {
          String s = data[i];
          println("  parsing element " + (i) + ": " + s);
          String[] eltData = s.split(":");
          if (s.startsWith("S")) {
            // Parse slider data
            String[] sldVals = eltData[1].split(",");
            sld1 = getInt(sldVals[0], sld1);
            sld2 = getInt(sldVals[1], sld2);
            sld3 = getInt(sldVals[2], sld3);
          } else if (s.startsWith("B")) {
            // Parse button data
            String[] btnVals = eltData[1].split(",");
            btn1 = getInt(btnVals[0], btn1?1:0) != 0;
            btn2 = getInt(btnVals[1], btn2?1:0) != 0;
            btn3 = getInt(btnVals[2], btn3?1:0) != 0;
          } else if (s.startsWith("L")) {
            // Parse light data
            light = getInt(eltData[1], light);
          } else if (s.startsWith("C")) {
            // Parse cap sense data
            cap = getInt(eltData[1], cap);
          } else {
            println("  Unknown data element: " + s);
          }
        } catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }
  }
  
  public int getSlider1(){
    return sld1;
  }
  public int getSlider2(){
    return sld2;
  }
  public int getSlider3(){
    return sld3;
  }
  public boolean isButton1(){
    return btn1;
  }
  public boolean isButton2(){
    return btn2;
  }
  public boolean isButton3(){
    return btn3;
  }
  public int getLight(){
    return light;
  }
  public int getCapSense(){
    return cap;
  }
}
