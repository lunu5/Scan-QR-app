## QR Code Scan App

### I. Setup development environment
1. #### Installation
   > Follow this [link](https://flutter.dev/docs/get-started/install) to install Flutter
    

2. #### Check
   > After the installation, run `flutter doctor` to check if the setup was successful.
<hr>
		
### II. How to build the app
- #### Start the virtual emulator or real device
    - ##### **Emulator**
        > **IOS emulators do not have virtual camera so you can not test the app in the IOS emulator**
        1. ###### Open AVD managager from android studio and launch the emulator.
        2. ###### Set up camera
           > To test the QR scan, you need to use your computer webcam instead of the virtual camera of the emulator.
           - Step 1. Create a new emulator or edit the existed one.
           - Step 2. Choose `Show Advanced Settings` in the bottom left corner.
           - Step 3. Choose `Webcam0` for front or back camera.<br/><br/>


   - ##### **Real device**
        - ###### Android
          - Step 1. In settings, find the `Developer options`.
              If you see this option, go to step 5.
          - Step 2. Tap `About device` or `About phone`.
          - Step 3. Find and tap `Build number` seven times.
              Depending on your device and operating system, you may need to tap `Software information`, then tap `Build number` seven times.
          - Step 4. Enter your pattern, PIN or password to enable the Developer options menu.
          - Step 5. Enable `USB Debugging`.
          - Step 6. Connect your devices using the USB cable.<br/><br/>

        - ###### IOS
           > For IOS devices, you need to have an IOS computer.

<br/><br/>


- #### Run the app from VS code.
  - In the bottom right corner of VS code, choose a device to run the app.
  - Choose `Run` and tap `Start Without Debugging` or `Ctrl+F5` for a quick launch.
  - If you need to debug your code, choose `Run` and tap `Start Debugging` or `F5`.
