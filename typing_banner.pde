int backgroundColor = #282828;
int textColor = #33FF33;

int width = 960, height = 400;
int screenLine0X = int(width / 2);
int screenLine0Y = int(height / 2) - 50; // 1st line is above the center of the screen
int screenLine1X = screenLine0X;
int screenLine1Y = int(height / 2); // 2nd line is true center of the screen

// [j][k] where j = number of screens and k = lines per screen
String[][] screens = new String[4][2];
int screenCursor = 0, lineCursor = 0;
boolean clearScreen = false;
int screenRefreshMs = 100;
int lastScreenChange = 0;
String onScreenLine1 = "", onScreenLine2 = "";

String cursorCharacter = "█";
int lastCursorBlink = 0;
int cursorRefreshMs = 300;

import gifAnimation.*;
GifMaker g;

void settings() {
  size(width, height);
}

void setup() {
  PFont font = createFont("Courier New Bold", 48);
  textFont(font);

  textAlign(CENTER);
  textSize(40);

  background(backgroundColor);
  fill(textColor);

  screens[0][0] = "Welcome!";
  screens[0][1] = "I'm Kevin Ramdath.";

  screens[1][0] = "I'm a Software Engineer";
  screens[1][1] = "working in NYC.";

  screens[2][0] = "Let's build something together,";
  screens[2][1] = "hire me for your next project!";

  screens[3][0] = "";
  screens[3][1] = "hello@kevinramdath.com";

  //String[] fontList = PFont.list();
  //printArray(fontList);
  g = new GifMaker(this, "out.gif");
  g.setRepeat(0);
}

void draw() {
  background(backgroundColor);

  // current lines of text on the screen
  String[] currentScreen = screens[screenCursor];

  int maxScreenLength = currentScreen[0].length() + currentScreen[1].length();
  if (lineCursor > maxScreenLength) {
    // we've already written the entire screen
    clearScreen = true;
    lineCursor = max(currentScreen[0].length(), currentScreen[1].length()) - 1;
    delay(1500);
  }

  if (lineCursor < 0) {
    lineCursor = 1;
    clearScreen = false;

    screenCursor += 1;
    if (screenCursor >= screens.length) { // done showing all screens
      screenCursor = 0; // go back to screen 0
      counter = -1;
      g.finish();
    }
    currentScreen = screens[screenCursor];
    delay(1000);
  }

  if (clearScreen) {
    // clear the screen from "lineCursor" down to 0 for both lines
    updateCurrentScreenForDeletion(currentScreen);
  } else {
    // show the current screen.
    updateCurrentScreenForWriting(currentScreen);
  }

  text(onScreenLine1, screenLine0X, screenLine0Y);
  text(onScreenLine2, screenLine1X, screenLine1Y);

  blinkCursor(clearScreen);
  updateLineCursor(clearScreen);

  if (counter != -1) {
    g.setDelay(50);
    g.addFrame();
    counter += 1;
  }
}

void updateCurrentScreenForWriting(String[] currentScreen) {
  if (lineCursor > currentScreen[0].length()) {
      onScreenLine1 = currentScreen[0];
      onScreenLine2 = currentScreen[1].substring(0, lineCursor - currentScreen[0].length());
    } else {
      onScreenLine1 = currentScreen[0].substring(0, lineCursor);
      onScreenLine2 = "";
    }
}

void updateCurrentScreenForDeletion(String[] currentScreen) {
  if (lineCursor >= currentScreen[0].length()) {
      onScreenLine1 = currentScreen[0];
    } else {
      onScreenLine1 = currentScreen[0].substring(0, lineCursor);
    }
    if (lineCursor >= currentScreen[1].length()) {
      onScreenLine2 = currentScreen[1];
    } else {
      onScreenLine2 = currentScreen[1].substring(0, lineCursor);
    }
}

void blinkCursor(boolean actionDelete) {
  if (millis() - lastCursorBlink > cursorRefreshMs) {
    drawCursor(actionDelete);
    lastCursorBlink = millis();
  }
}

void updateLineCursor(boolean actionDelete) {
  if (millis() - lastScreenChange > screenRefreshMs) {
    lineCursor = lineCursor + (actionDelete ? -1 : 1); // show 1 more or less character next frame
    lastScreenChange = millis();
  }
}

int counter = 0;
void drawCursor(boolean allLines) {
  if (allLines) {
    float maxTextWidth = max(textWidth(onScreenLine1), textWidth(onScreenLine2));
    text(cursorCharacter, screenLine0X + (maxTextWidth / 2) + 15, screenLine0Y);
    text(cursorCharacter, screenLine1X + (maxTextWidth / 2) + 15, screenLine1Y);
  } else if (onScreenLine2.length() > 0) { // we are writing line 2
    text(cursorCharacter, screenLine1X + (textWidth(onScreenLine2) / 2) + 15, screenLine1Y);
  } else {
    text(cursorCharacter, screenLine0X + (textWidth(onScreenLine1) / 2) + 15, screenLine0Y);
  }
}
