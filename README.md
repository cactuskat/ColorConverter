# unit_converter

'Unit Converter' concerts from any 3 units (gram, pound, ounce) to any other unit. App changes color based on touch.

Select any of the 3 options as the original unit, another as the target, and then click submit.The result will show in the textbox.

Tapping an empty area of the screen cycles the background through exactly 5 colors. Each tap advances to the next color and wraps back to the first after the fifth.

### Loom Video
https://www.loom.com/share/1e6d79ca4607423cb1f4ad44496b45a9

### How to run it
- Open 'unit_converter' folder on VS code
- Select 'Start Debugging'
- Select simulator of choice (Was tested with Google Chrome)

### Color Palette
Colors: 
- Default (Purples)
- Coffee Theme (Browns)
- Matcha Theme (Greens)
- Ocean Theme (Blues)
- Barbie Mode (Pinks)

Readable contrast is based on background brightness using 'ThemeData.estimateBrightnessForColor'.If the background of the text is too dark, the text will switch from default white to black.

### Sample Inputs & Expected Outputs
[ 1 gram ] -> [ 0.04 ounce]

[ 1 pound ] -> [ 16 ounce ]

[ 5 ounce ] -> [ 141.7 gram]

[ 1 gram ] -> [ 1 gram ]

[ -5 ounce ] -> Error

### What is This?
This program is a flutter based project made for CPSC 4150
