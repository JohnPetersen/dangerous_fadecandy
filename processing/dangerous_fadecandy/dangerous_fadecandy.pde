import processing.serial.*;

OPC opc;
Img dot;

BBox bounds;
InputState input;

void setup() {
  size(640, 640);

  Serial serial;
  boolean serialReady = false;
  for (String s : Serial.list()) {
    println("port: " + s);
    if (!serialReady && s.indexOf("tty") > -1 && s.indexOf("Bluetooth") == -1) {
      try {
        serial = new Serial(this, s, 9600);
        println("  Using port: " + s);
        input = new SerialState(serial);
        serialReady = true;
      } catch(ArrayIndexOutOfBoundsException e) {
        println("No serial port found!");
      } catch (Exception e) {
        println("Error opening serial port.");
      }
    }
  }
  if (!serialReady) {
    println("No serial port found. Using random input.");
    input = new RandomState(47,59,67,0.1,0.1,0.1);
  }

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map an 8x8 grid of LEDs to the center of the window
  float spacing = height / 24.0;
  float offset = spacing * 4.0;
  opc.ledGrid8x8(0, width/2 + offset, height/2 - offset, spacing, 0, false);
  opc.ledGrid8x8(64, width/2 - offset, height/2 - offset, spacing, 0, false);
  opc.ledGrid8x8(128, width/2 - offset, height/2 + offset, spacing, 0, false);
  opc.ledGrid8x8(192, width/2 + offset, height/2 + offset, spacing, 0, false);
  
  // define the bounding region
  int bboxSize = (int)(spacing * 16);
  bounds = new BBox(width/2 - bboxSize/2, height/2 - bboxSize/2, bboxSize, bboxSize);
  
  // Instantiate a mouse positioned or a bouncing image.
  dot = new MouseImg("dot.png", 50, 50);
  //dot = new BounceImg("dot.png", 150, 150, bounds);
}

int imgSize = 50;

void draw() {
  background(0);
  
  input.update();
  
  color c = color(map(input.getSlider1(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255),
                  map(input.getSlider2(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255),
                  map(input.getSlider3(), InputState.SLIDER_MIN, InputState.SLIDER_MAX, 0, 255));

  // Adjust the image size based on button status.
  if (input.isButton1() && imgSize > 0) {
    imgSize = imgSize - 1;
  } else if (input.isButton2() && imgSize < 100) {
    imgSize = imgSize + 1;
  }
    
  float dotSize = height * (imgSize / 100.0);
  // TODO can we scale the image with some sort of transform?
  tint(c);
  
  dot.draw();
  
  noFill();
  stroke(255,0,0);
  bounds.draw();
  
  // print the current control values.
  fill(c);
  // Sliders
  text("Slider 1: " + input.getSlider1(), 10, height - 60);
  text("Slider 2: " + input.getSlider2(), 10, height - 40);
  text("Slider 3: " + input.getSlider3(), 10, height - 20);
  
  // Buttons
  text("Button 1: " + input.isButton1(), 110, height - 60);
  text("Button 2: " + input.isButton2(), 110, height - 40);
  text("Button 3: " + input.isButton3(), 110, height - 20);
  
  // Light & Capsense
  text("Light: " + input.getLight(), 210, height - 60);
  text("CapSense: " + input.getCapSense(), 210, height - 40);
  text("FPS: " + frameRate, 210, height - 20);
}

