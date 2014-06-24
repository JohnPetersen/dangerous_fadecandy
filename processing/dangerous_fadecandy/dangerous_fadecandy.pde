import processing.serial.*;
import java.util.List;

OPC opc;
List<Img> images = new ArrayList<Img>();

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
  
  // Three bouncing dots.
  int numberOfDots = 3;
  ColorStrategy colorStrat = new RandomColorStrategy();
  ScaleStrategy scaleStrat = new ButtonInputScaleStrategy();
  for (int i = 0; i < numberOfDots; i++) {
    Img img = new Img("trans-dot.png", color(128,128,128), (int)(i*bboxSize/7.0), 0, (int)(7*(i+1)*noise(i)), (int)(13*noise(i)), 150, 150, bounds, input, 
      new InputDrivenSpeedStrategy(), new BouncingMotionStrategy(), colorStrat, scaleStrat);
    images.add(img);
  }
  
  // One bouncer with a simi-random color and a tail of orbiters.
  Img img = new Img("trans-dot.png", color(255,128,128), 0, 0, 13, 7, 100, 100, bounds, input, 
      new ConstantSpeedStrategy(), new BouncingMotionStrategy(), new RandomColorStrategy(-1, -1, 255), scaleStrat);
  images.add(img);
  for (int i = 0; i < 3; i++) {
    img = new Img("trans-dot.png", color(128,255,128), 0, 0, 0, 0, 90-i*15, 90-i*15, bounds, input, 
        new ConstantSpeedStrategy(), new OrbitalMotionStrategy(img, noise(i)), colorStrat, scaleStrat);
    images.add(img);
  }
  
  // A mouse controlled dot with three orbiters.
  Img center = new Img("trans-dot.png", color(255,255,255), 0, 0, 0, 0, 150, 150, bounds, input, 
      new ConstantSpeedStrategy(), new MouseMotionStrategy(), new SingleSliderColorStrategy(2), scaleStrat);
  images.add(center);
  img = new Img("trans-dot.png", color(255,0,0), 0, 0, 0, 0, 80, 80, bounds, input, 
        new ConstantSpeedStrategy(), new OrbitalMotionStrategy(center, 0.05, 0.0), new ConstantColorStrategy(), scaleStrat);
  images.add(img);
  img = new Img("trans-dot.png", color(0,255,0), 0, 0, 0, 0, 80, 80, bounds, input, 
        new ConstantSpeedStrategy(), new OrbitalMotionStrategy(center, 0.05, TWO_PI/3.0), new ConstantColorStrategy(), scaleStrat);
  images.add(img);
  img = new Img("trans-dot.png", color(0,0,255), 0, 0, 0, 0, 100, 100, bounds, input, 
        new ConstantSpeedStrategy(), new OrbitalMotionStrategy(center, 0.05, TWO_PI*2/3.0), new ConstantColorStrategy(), scaleStrat);
  images.add(img);
}

void draw() {
  background(0);
  
  input.update();
  
  // Adjust brightness
  float gamma = map(input.getLight(), 0, 1023, 3.5, 0.5);
  opc.setColorCorrection(gamma, 1.0, 1.0, 1.0);
  
  for (Img img : images) {
    img.draw();
  }
  
  // Draw the bounding box
  noFill();
  stroke(255,0,0);
  bounds.draw();
  
  // print the current control values.
  fill(color(0,255,0));
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

void exit() {
  background(0);
  super.exit();
}

