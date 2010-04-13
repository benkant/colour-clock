/**
 * $Id: ColourClock.pde 30 2008-12-15 08:26:58Z btgiles $
 *
 * Copyright (C) 2008 Ben Giles
 * btgiles@gmail.com
 * bencode.googlecode.com
 *
 * Released under the GPL, Version 3
 * License available here: http://www.gnu.org/licenses/gpl.txt
 */
 
import processing.opengl.*;

PFont font;

float hourRotX = 0.0f;
float minuteRotX = 0.0f;
float secondRotX = 0.0f;

float hourRotY = 0.0f;
float minuteRotY = 0.0f;
float secondRotY = 0.0f;

void setup() {
  size(600, 400, OPENGL);
  font = loadFont("BankGothic-Light-48.vlw");
  textFont(font);
  stroke(153);
  smooth();
}

void draw() {
  background(153);
  int _hour = hour();
  int _minute = minute();
  int _second = second();
  int _millis = millis();
  
  if (mousePressed == true) {
    // draw time in text
    String sHour = formatTime(_hour);
    String sMinute = formatTime(_minute);
    String sSecond = formatTime(_second);
    String sTime = sHour + " : " + sMinute + " : " + sSecond;
    fill(255);
    textAlign(CENTER);
    text(sTime, width/2, 50);
  }
  
  // draw time in colour cubes
  // get RGB time values
  float hourRed = ((float)_hour / 24) * 255;
  float minuteGreen = ((float)_minute / 60) * 255;
  float secondBlue = ((float)_second / 60) * 255;

  // rotation
  secondRotX = ((float) _second / 60) * 360;
  secondRotY = 0.0f;

  minuteRotX = ((float) _minute / 60) * 360;
  minuteRotY = 0.0f;

  hourRotX = ((float) _hour / 24) * 360;
  hourRotY = 0.0f;

  // draw the hour cube
  pushMatrix();
    translate(100, height/2, -50);
    rotateX(radians(hourRotX));
    rotateY(radians(hourRotY));
    fill((int)hourRed, 0, 0);
    box(125);
  popMatrix();
  
  // draw minute cube
  pushMatrix();
    translate(300, height/2, -50);
    rotateX(radians(minuteRotX));
    rotateY(radians(minuteRotY));
    fill(0, (int)minuteGreen, 0);
    box(125);
  popMatrix();
  
  // draw second cube
  pushMatrix();
    translate(500, height/2, -50);
    rotateX(radians(secondRotX));
    rotateY(radians(secondRotY));
    fill(0, 0, (int)secondBlue);
    box(125);
  popMatrix();
}

String formatTime(int timeVal) {
  NumberFormat formatter = NumberFormat.getIntegerInstance();
  formatter.setMinimumIntegerDigits(2);
  return formatter.format((long) timeVal);
}
