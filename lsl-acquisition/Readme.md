# Data acquisition from LSL
For data acquisition from an LSL stream, first, you need to push data into LSL using either [Explorepy](https://github.com/Mentalab-hub/explorepy) or [Explorecpp](https://github.com/Mentalab-hub/explorecpp). If you have not installed Explorepy or Explorecpp follow these instruction links
* Explorepy [installation](https://explorepy.readthedocs.io/en/latest/installation.html#installation) and [usage](https://explorepy.readthedocs.io/en/latest/usage.html#command-line-interface) (look at push2lsl command)
* Explorecpp [installation](https://github.com/Mentalab-hub/explorecpp/blob/master/windows_installation.md) and LSL [integration](https://github.com/Mentalab-hub/explorecpp/blob/master/lsl_integration.md) procedures


### labstreaminglayer in Matlab
* Please follow the instructions of liblsl-matlab from this [link](https://github.com/labstreaminglayer/liblsl-Matlab) to install LSL for Matlab.
* Add LSL library folder to your Matlab path recursively (more info [here](https://github.com/labstreaminglayer/liblsl-Matlab#how-to-use))
* The default setting in the example is for 4-channel device. If you are using an 8-channel device, change the following variables from 4 to 8:
  * Line 31:  _`block.OutputPort(1).Dimensions       = 4; % Number of EEG channels`_
  * Line 73:   _`block.Dwork(1).Dimensions      = 4;  % Number of EEG channels`_
* Push Explore data to LSL using Explorepy or Explorecpp.
* Open example.slx file and press "Run". It visualizes ExG and orientation signals in realtime.
