# typing-banner
 Processing script to create a typying banner for my GitHub developer page. 

 ![https://github.com/minormending](https://github.com/minormending/minormending/blob/main/banner.gif)


# Configuration
All configuration settings are at the top of the script, except for the screen text. By default the script show 4 screens with 2 lines of text per screen. You should change the contents of the below variable `screens` to the information you want to display:
```pde
screens[0][0] = "Welcome!";
screens[0][1] = "I'm FirstName LastName.";
 ...
screens[3][0] = "@TwitterHandle";
screens[3][1] = "Email@Address.com";
```

If you want to add more or less screens, you should update the `screens` declaration, in addition to adding/removing the items from the array:
```pde
String[][] screens = new String[4][2];
```

The default is green text on a black background, but you can easily change it to black text on white canvas by changing `backgroundColor` and `textColor`:
```pde
int backgroundColor = 255;
int textColor = 0;
```

Likewise, if you don't like the block cursor and want a normal line cursor, you can change `cursorCharacter`:
```pde
String cursorCharacter = "|";
```

## Processing Install
If you do not already have processing installed, Processing can be found at:
[Processing](https://processing.org/)