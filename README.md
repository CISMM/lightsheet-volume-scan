# lightsheet-volume-scan
This repo hosts MATLAB files that CISMM used to perform initialization lightsheet volumetric scan on cells. Initialization scan builds a look-up table of focal distance for each lightsheet position in a lateral scan, and saves the results in a text file, which becomes the input to the [real-time fast scan LabView program](https://github.com/CISMM/fast_volume_scan).

**Note for this software to run, it requires an external Java library, [AuotPilot](https://microscopeautopilot.github.io/).
You can download a pre-compiled version [here](https://github.com/CISMM/volumetric_scan_with_autofocus/raw/master/AutoPilot-1.0.jar) or build your own by following instructions in https://github.com/MicroscopeAutoPilot/autopilot/wiki/howtobuild. 
