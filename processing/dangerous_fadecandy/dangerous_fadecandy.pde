import processing.serial.*;

OPC opc;
PImage dot;

Serial mySerial;
boolean serialReady = false;

void setup() {
  size(640, 640);

  for (String s : Serial.list()) {
    println("port: " + s);
    if (!serialReady && s.indexOf("tty") > -1 && s.indexOf("Bluetooth") == -1) {
      try {
        mySerial = new Serial(this, s, 9600);
        println("  Using port: " + s);
        serialReady = true;
      } catch(ArrayIndexOutOfBoundsException e) {
        println("No serial port found!");
      } catch (Exception e) {
        println("Error opening serial port.");
      }
    }
  }
  if (!serialReady) {
    println("No serial port found. Good luck!");
  }
  
  // Load a sample image
  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map an 8x8 grid of LEDs to the center of the window
  float spacing = height / 24.0;
  float offset = spacing * 4.0;
  opc.ledGrid8x8(0, width/2 + offset, height/2 - offset, spacing, 0, false);
  opc.ledGrid8x8(64, width/2 - offset, height/2 - offset, spacing, 0, false);
  opc.ledGrid8x8(128, width/2 - offset, height/2 + offset, spacing, 0, false);
  opc.ledGrid8x8(192, width/2 + offset, height/2 + offset, spacing, 0, false);
}

int sld1 = 0;
int sld2 = 0;
int sld3 = 0;
int btn1 = 0;
int btn2 = 0;
int btn3 = 0;
int light = 0;
int cap = 0;

int imgSize = 50;

int getInt(String s, int def) {
  try {
    return Integer.parseInt(s);
  } catch (NumberFormatException e) {
    return def;
  }
}
void readInput() {
  if (!serialReady) return;
  if (mySerial.available() < 62) {
    return;
  }
  String msg = mySerial.readStringUntil('\n'); // 10 == line feed
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
          btn1 = getInt(btnVals[0], btn1);
          btn2 = getInt(btnVals[1], btn2);
          btn3 = getInt(btnVals[2], btn3);
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

void draw() {
  background(0);
  
  readInput();
  
  color c = color(map(sld1, 0, 1023, 0, 255),map(sld2, 0, 1023, 0, 255),map(sld3, 0, 1023, 0, 255));

  // Draw the image, centered at the mouse location
  if (btn1 == 1 && imgSize > 0) {
    imgSize = imgSize - 1;
  } else if (btn2 == 1 && imgSize < 100) {
    imgSize = imgSize + 1;
  }
    
  float dotSize = height * (imgSize / 100.0);
  tint(c);
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
  
  
  
  // print the current control values.
  fill(c);
  // Sliders
  text("Slider 1: " + sld1, 10, height - 60);
  text("Slider 2: " + sld2, 10, height - 40);
  text("Slider 3: " + sld3, 10, height - 20);
  
  // Buttons
  text("Button 1: " + btn1, 110, height - 60);
  text("Button 2: " + btn2, 110, height - 40);
  text("Button 3: " + btn3, 110, height - 20);
  
  // Light & Capsense
  text("Light: " + light, 210, height - 60);
  text("CapSense: " + cap, 210, height - 40);
}

