# lightsheet-volume-scan
This repo hosts MATLAB files that CISMM used to perform initialization lightsheet volumetric scan on cells. Initialization scan builds a look-up table of focal distance for each lightsheet position in a lateral scan, and saves the results in a text file, which becomes the input to the [real-time fast scan LabView program](https://github.com/CISMM/fast_volume_scan).

**Note that this software has a dependency of an external Java library, [AuotPilot](https://microscopeautopilot.github.io/). Build instructions can be found in https://github.com/MicroscopeAutoPilot/autopilot/wiki/howtobuild. 
