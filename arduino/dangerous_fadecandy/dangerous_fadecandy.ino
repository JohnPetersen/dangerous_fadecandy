/*
 This code collects input values from the Danger Shield 
 [https://www.sparkfun.com/products/10115] and writes them to the serial port.
 It is based on the Danger Shield Example Sketch by Chris Taylor and Nathan 
 Seidle.
 */

// Shift register bit values to display 0-9 on the seven-segment display
const byte ledCharSet[10] = {
  B00111111, 
  B00000110, 
  B01011011, 
  B01001111, 
  B01100110, 
  B01101101, 
  B01111101, 
  B00000111, 
  B01111111, 
  B01101111
};

// Pin definitions for v1.7 of the board
#define SLIDER1  A2 //Matches button 1
#define SLIDER2  A1 
#define SLIDER3  A0 //Matches button 3
#define LIGHT    A3
#define TEMP     A4

#define BUZZER   3
#define DATA     4
#define LED1     5
#define LED2     6
#define LATCH    7
#define CLOCK    8
#define BUTTON1  10
#define BUTTON2  11
#define BUTTON3  12
//v1.7 uses CapSense
//This relies on the Capactive Sensor library here: http://playground.arduino.cc/Main/CapacitiveSensor
#include <CapacitiveSensor.h>

CapacitiveSensor capPadOn92 = CapacitiveSensor(9, 2);   //Use digital pins 2 and 9,

int avgLightLevel;

void setup()
{
  Serial.begin(9600);

  //Initialize inputs and outputs
  pinMode(SLIDER1, INPUT);
  pinMode(SLIDER2, INPUT);
  pinMode(SLIDER3, INPUT);
  pinMode(LIGHT, INPUT);
  pinMode(TEMP, INPUT);

  //Enable internal pullups
  pinMode(BUTTON1, INPUT_PULLUP);
  pinMode(BUTTON2, INPUT_PULLUP);
  pinMode(BUTTON3, INPUT_PULLUP);

  pinMode(BUZZER, OUTPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);

  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATA, OUTPUT);

  //Initialize the capsense
  capPadOn92.set_CS_AutocaL_Millis(0xFFFFFFFF); // Turn off autocalibrate on channel 1 - From Capacitive Sensor example sketch

  //Take 16 readings from the light sensor and average them together
  avgLightLevel = 0;
  for(int x = 0 ; x < 16 ; x++)
    avgLightLevel += analogRead(LIGHT);
  avgLightLevel /= 16;
}

/*
 * Take the sensor value and convert it to degrees C.
 */
long convertTemp(long sensorValue) {
  // 5V is the same as 1023 from the ADC (12-bit) - example, the ADC returns 153 * 5000 = 765,000
  long temperature = sensorValue * 5000;
  temperature /= 1023; //It's now in mV - 765,000 / 1023 = 747
  // The TMP36 reports 500mV at 0C so let's subtract off the 500mV offset
  temperature -= 500; //747 - 500 = 247
  // Temp is now in C where 247 = 24.7
  return temperature;
}

void loop()
{
  //Read inputs
  int val1 = analogRead(SLIDER1);
  int val2 = analogRead(SLIDER2);
  int val3 = analogRead(SLIDER3);
  int btn1 = digitalRead(BUTTON1) == LOW ? 1 : 0;
  int btn2 = digitalRead(BUTTON2) == LOW ? 1 : 0;
  int btn3 = digitalRead(BUTTON3) == LOW ? 1 : 0;
  int lightLevel = analogRead(LIGHT);
  long temperature = convertTemp(analogRead(TEMP));
  long capLevel = capPadOn92.capacitiveSensor(30);
  
  //Display values
  char tempString[200];
  sprintf(tempString, 
          " Sliders:%04d,%04d,%04d Buttons:%01d,%01d,%01d Light:%04d Capsense:%04d \n",
          val1, val2, val3, btn1, btn2, btn3, lightLevel, capLevel);
  Serial.print(tempString);

  //Set the brightness on LED #2 (D6) based on slider 1
  int ledLevel = map(val1, 0, 1020, 0, 255); //Map the slider level to a value we can set on the LED
  analogWrite(LED1, ledLevel); //Set LED brightness

  //Set the brightness on LED #2 based on slider 2
  ledLevel = map(val2, 0, 1020, 0, 255); //Map the slider level to a value we can set on the LED
  analogWrite(LED2, ledLevel); //Set LED brightness

  //Set 7 segment display based on the 3rd slider
  int numToDisplay = map(val3, 0, 1020, 0, 9); //Map the slider value to a displayable value
  digitalWrite(LATCH, LOW);
  shiftOut(DATA, CLOCK, MSBFIRST, ~(ledCharSet[numToDisplay]));
  digitalWrite(LATCH, HIGH);
}