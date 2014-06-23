Dangerous Fadecandy
===================

Fadecandy playground with four [Neopixel matrices](https://www.adafruit.com/product/1487) and a [Danger Shield](https://www.sparkfun.com/products/11649) for control.

Display Modes
-------------
* Mouse controlled
* Bouncing ball


TODO
-----
* Adjust brightness based on Danger Shield light sensor value.
* Fix the speed strategy, the images don't appear to slow down at the same rate.
* Add more strategies
 * ColorCycle - color strategy that cycles through a list of colors.
 * LinkedMotion - a follower motion strategy that positions the image a percentage of the way to the followed image.
* Update strategies to take constructor parameters for time intervals and other values to help differentiate the look of each image.
