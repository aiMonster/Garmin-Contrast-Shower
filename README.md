# Garmin Contrast Shower watch application
An application for Garmin watches to take a contrast shower

# Version History
**1.0.0**
0.4.0 - Added possibility to disable activity recording  
0.3.0 - Now an activity is recording  
0.2.0 - Added possibility to edit configurations  
0.1.1 - Moved cycles and view operations to the separate managers  
0.1.0 - Initial mvp version

# Future features
* Possibility to publish your activity, so it could be tracked
* Smart plans (e.g. if whole week without missing, switch to the second cycles regime)

# Fututure bugfixes/improvements
* Shorten vibration between cycles
* Refactor code
* Add done icon when completed
* Display Save/Discard after completed
* Configure first cycle type

# Local set up
Use Visual Studio Code and Monkey C plugin

Side Loading an App:
  1. Use Ctrl + Shift + P (Command + Shift + P on the Mac) to summon the command palette
  2. In the command palette type “Build for Device” and select Monkey C: Build for Device
  3. Select the product you wish to build for
  4. Copy the generated PRG files to your device’s GARMIN/APPS directory
