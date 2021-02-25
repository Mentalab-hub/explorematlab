# ExploreMatlab
A Matlab-based toolbox for Mentalab explore device


This package provides some Matlab scripts to be used with Mentalab Explore device. Please note that these scripts provide only some basic features. It is recommended to work with [Explorepy](https://github.com/Mentalab-hub/explorepy) as it provides a complete set of features to the users.

Using these tools you would be able to
* acquire data directly from device via Bluetooth connection,
* get the data in real-time from [Explorepy](https://github.com/Mentalab-hub/explorepy) or [explorecpp](https://github.com/Mentalab-hub/explorecpp) via lsl, and 
* convert recorded binary files from the device to csv files, 


## Dependencies
* Matlab Instrument Control Toolbox (for acquiring data in realtime directly)
* Matlab DSP System Toolbox (for running Simulink examples)
* [Explorepy](https://github.com/Mentalab-hub/explorepy) (Only if you want to get data via Explorepy)
* [Explorecpp](https://github.com/Mentalab-hub/explorecpp) (Only if you want to get data via Explorecpp)
* [labstreaminglayer](https://github.com/sccn/labstreaminglayer) (Only if you want to get data via Explorepy or Explorecpp)


## How to use?
* Run the setup script to add necessary paths
* For real-time signal acquisition directly with Matlab see this [link](https://github.com/Mentalab-hub/explorematlab/tree/master/api)
* For real-time signal acquisition from LSL see this [link](https://github.com/Mentalab-hub/explorematlab/tree/master/lsl-acquisition)
* * Binary to csv converter
  * Run "convertBIN2csv" command in Matlab
  * Select the binary file via GUI
  * The scripts converts and saves EEG and orientation data in two separated csv files in the same folder as original binary file

## License
This project is licensed under the [GNU General Public License v3.0](LICENSE)
