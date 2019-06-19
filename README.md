# explorematlab
A Matlab-based toolbox for Mentalab explore device


This package provides some Matlab scripts for Mentalab Explore device. Using these tools you can convert recorded binary files from the device to csv files, get the data in real-time from the C++ API (libexplorecpp) via lsl, and acquire data directly from device via Bluetooth connection.

## Dependencies
* [libexplorecpp](https://github.com/Mentalab-hub/libexplorecpp) (Only if you want to get data via C++ API)
* [labstreaminglayer](https://github.com/sccn/labstreaminglayer) (Only if you want to get data via C++ API)
* Matlab Instrument Control Toolbox (for acquiring data in realtime without C++ API)

## How to run
* Run the setup script to add necessary paths
* Binary to csv converter
  * Run "convertBIN2csv" command in Matlab
  * Select the binary file via GUI
  * The scripts converts and saves EEG and orientation data in two separated csv files in the same folder as original binary file
* For real-time signal acquisition from C++ API see this [link](https://github.com/Mentalab-hub/explorematlab/tree/master/lsl-acquisition)
* For real-time signal acquisition directly with Matlab see this [link](https://github.com/Mentalab-hub/explorematlab/tree/master/api)

## License
This project is licensed under the [GNU General Public License v3.0](LICENSE)
