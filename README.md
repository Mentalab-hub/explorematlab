# explorematlab
A Matlab-based toolbox for Mentalab explore device


This package provides some Matlab scripts for Mentalab Explore device. Using these tools you can convert recorded binary files from the device to csv files, get the data in real-time from the C++ API (libexplorecpp) via lsl, and acquire data directly from device via Bluetooth connection.

## Dependencies
* [libexplorecpp](https://github.com/Mentalab-hub/libexplorecpp) (Only if you want to get data via C++ API)
* [labstreaminglayer](https://github.com/sccn/labstreaminglayer) (Only if you want to get data via C++ API)
* Matlab Instrument Control Toolbox (for acquiring data in realtime without C++ API)
