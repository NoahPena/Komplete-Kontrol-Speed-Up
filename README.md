
<br />
<div align="center">
   <img src="https://github.com/NoahPena/Native-Instruments-Scan-Manager/blob/main/Komplete%20Kontrol%20Speed%20Up/Assets.xcassets/AppIcon.appiconset/AppIcon_512.png" alt="Logo" width="80" height="80">

# Native Instruments Scan Manager

A simple application for enabling/disabling the Komplete Kontrol and Maschine Scanning functionality

![](https://github.com/NoahPena/Native-Instruments-Scan-Manager/blob/main/AppScreenshot.png)

</div>

## Description

A big bottle-neck of Native Instruments Product startup times is the need to scan for new plugins every time the application is started. Most producers aren't adding new plugins every time they start up Komplete Kontrol or Maschine, so this application disables the scanning functionality from these programs by renaming the ScanApp application so that the startup sequence does not see it, thus skipping it. 

## Getting Started

### Dependencies

* Minimum MacOS 11 Big Sur Required
* Either [Komplete Kontrol](https://www.native-instruments.com/en/products/komplete/bundles/komplete-kontrol/) and/or [Maschine](https://www.native-instruments.com/en/products/maschine/production-systems/maschine/) installed

### Installing

* [Download the latest release](https://github.com/NoahPena/Native-Instruments-Scan-Manager/releases)
* Open the .dmg file
* Drag the Native Instruments Scan Manager to your Applications folder

### Usage

The application on startup will detect if you have the Maschine and/or Komplete Kontrol Applications installed in the default locations. If you don't have one of the applications installed, that side of the application window will be blurred out

The Toggle on each side is representative of whether the ScanApp is enabled or disabled for each Application.

* Enabling the ScanApp will allow the Application to scan for new apps on startup (normal behavior)
* Disabling the ScanApp will rename the ScanApp so that the Application skips the scanning process

If you install new plugins and need one of the applications to find them, then you'll need to re-enable the ScanApp, then open up the Application to allow it to scan for new plugins, and then disable the ScanApp

## Help

If you run into any issues or have any suggestions feel free to post it in the issues section, or email me at

```
Noah Peña
noahpenamusic@gmail.com
```

## Version History

* 1.2
    * Fixed Maschine 3 not being recognized
    * Added ability to use different versions of KK and Maschine together
* 1.1
    * Added Support for Komplete Kontrol 2 and Maschine 3
* 1.0
    * Initial Release
