#include "HL1606strip.h"

#define STRIP_D 4
#define STRIP_C 3
#define STRIP_L 2

HL1606strip strip = HL1606strip(STRIP_D, STRIP_L, STRIP_C, 90);


void setup(void) {
  Serial.begin(9600);
  solidColor(BLACK);
}

void loop(void) { 
  int cmd;
  if (Serial.available() > 0) {
      cmd = Serial.read();
      switch (cmd) {
        case 'r':
          solidColor(RED);
          break;
        case 'g':
          solidColor(BLUE);
          break;
        case 'b':
          solidColor(GREEN);
          break;
        case 'y':
          solidColor(VIOLET);
          break;
        case 'v':
          solidColor(YELLOW);
          break;
        case 't':
          solidColor(TEAL);
          break;
        case '1':
          solidColor(WHITE);
          break;
        case '0':
          solidColor(BLACK);
          break;
      }
  }
  strip.writeStrip();
}


void solidColor(uint8_t color) {
  uint8_t i;
  for (i = 0; i < strip.numLEDs(); i++) {
      strip.setLEDcolor(i, color);
  }
  strip.writeStrip();
}



/**********************************************/

// scroll a rainbow!
void rainbowParty(uint8_t wait) {
  uint8_t i, j;

  for (i=0; i< strip.numLEDs(); i+=6) {
    // initialize strip with 'rainbow' of colors
    strip.setLEDcolor(i, RED);
    strip.setLEDcolor(i+1, YELLOW);
    strip.setLEDcolor(i+2, GREEN);
    strip.setLEDcolor(i+3, TEAL);
    strip.setLEDcolor(i+4, BLUE);
    strip.setLEDcolor(i+5, VIOLET);
 
  }
  strip.writeStrip();   
  
  for (j=0; j < strip.numLEDs(); j++) {

    // now set every LED to the *next* LED color (cycling)
    uint8_t savedcolor = strip.getLEDcolor(0);
    for (i=1; i < strip.numLEDs(); i++) {
      strip.setLEDcolor(i-1, strip.getLEDcolor(i));  // move the color back one.
    }
    // cycle the first LED back to the last one
    strip.setLEDcolor(strip.numLEDs()-1, savedcolor);
    strip.writeStrip();
    delay(wait);
  }
}


// turn everything off (fill with BLACK)
void stripOff(void) {
  // turn all LEDs off!
  for (uint8_t i=0; i < strip.numLEDs(); i++) {
      strip.setLEDcolor(i, BLACK);
  }
  strip.writeStrip();   
}

// have one LED 'chase' around the strip
void chaseSingle(uint8_t color, uint8_t wait) {
  uint8_t i;
  
  // turn everything off
  for (i=0; i< strip.numLEDs(); i++) {
    strip.setLEDcolor(i, BLACK);
  }

  for (i=0; i < strip.numLEDs(); i++) {
    strip.setLEDcolor(i, color);
    if (i != 0) {
      // make the LED right before this one OFF
      strip.setLEDcolor(i-1, BLACK);
    }
    strip.writeStrip();
    delay(wait);  
  }
  // turn off the last LED before leaving
  strip.setLEDcolor(strip.numLEDs() - 1, BLACK);
}

// fill the entire strip, with a delay between each pixel for a 'wipe' effect
void colorWipe(uint8_t color, uint8_t wait) {
  uint8_t i;
  
  for (i=0; i < strip.numLEDs(); i++) {
      strip.setLEDcolor(i, color);
      strip.writeStrip();   
      delay(wait);
  }
}


