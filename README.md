![icon](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/icon.png) Dangerous Fadecandy
===================

[Fadecandy](https://github.com/scanlime/fadecandy) playground with four [Neopixel matrices](https://www.adafruit.com/product/1487) and a [Danger Shield](https://www.sparkfun.com/products/11649) for control.

![Overview](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/overview.png)

## Danger Shield
The Danger Shield is used as an input device in this project. Attached to an Arduino, the input values are sent via a serial connection to the PC. The code for the Danger Shield is in the arduino folder.

## Fadecandy
A [Processing](https://www.processing.org/) sketch reads the control values from the serial connection and generates graphics. A Fadecandy server + controller board are used to drive a 16x16 matrix of RGB LEDs.
![fadecandy](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/fadecandy_detail.png)

The dangerous_fadecandy sketch in the processing folder displays the generated graphics as well as the control inputs and a bounding box representing the displayable area of the matrix. 
![screen shot](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/screen_shot.png)

## Matrix of Neopixel Matrices
Four of Adafruit's Neopixel matrices are mounted on a 10" square of foam board. This allow the wires to be neatly hidden.
![wiring](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/mount_detail.png)

Molex connectors are used for both signal and power. The genders are reversed for the signal and power inputs so it is not possible to accidentally connect power to the signal line.
![wiring](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/back_overview.png)

[Power](https://learn.adafruit.com/adafruit-neopixel-uberguide/power) is distributed from a [5v 10A](https://www.adafruit.com/products/658) by a plug assembly with and integrated 1000µF capacitor.
![power](https://raw.githubusercontent.com/JohnPetersen/dangerous_fadecandy/master/docs/img/power_detail.png)

Display Modes
-------------
* Mouse controlled
* Bouncing ball
* Follower and Orbital linked-motion types

TODO
-----
* Fix the speed strategy, the images don't appear to slow down at the same rate.
* Add more strategies
 * ColorCycle - color strategy that cycles through a list of colors.
* Update strategies to take constructor parameters for time intervals and other values to help differentiate the look of each image.
* Create a state input class for keyboard control so the Danger Shield is not required
