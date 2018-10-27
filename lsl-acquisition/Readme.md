# C++ API and labstreaminglayer integration

This guide helps you to setup a labstreaminglayer (LSL) connection in order to send data acquired by C++ API to other environment such as Matlab, Openvibe, C#, Python, etc..

### Explore C++ API (libexplorecpp)
Follow [this tutorial](https://github.com/Mentalab-hub/libexplorecpp) to install the C++ API.

### labstreaminglayer
* You need to install LSL on your computer. Follow [this instruction](https://github.com/sccn/labstreaminglayer/blob/master/INSTALL.md) to install and build LSL and its dependencies. You might be able to use pre-compiled LSL from [here](ftp://sccn.ucsd.edu/pub/software/LSL/SDK/) instead of installing LSL from scratch. However, these binary releases might not work on all operating systems with different architectures.

* Create a new Visual Studio project and include API library. Add “lsl_cpp.h” to the project libraries.
Copy LSL bin folder (containing LSL binary files) to your project folder and add it to your project libraries (Project properties > Linker > General > Additional Library Directories). 
Use acquisition_server class for acquiring data and sending to LSL. (Look at [this example](NOTHING))

### Openvibe:
* Download and install Openvibe from [this link](http://openvibe.inria.fr/downloads/).
* Start Openvibe acquisition server. Choose lsl driver from the list and in driver properties search for the “Explore_EEG stream”, connect to the stream and play data acquiring.
* In Openvibe designer you can design your scenario to preprocess and visualize the data.

### Matlab:
* If you have installed and built your LSL software with Visual Studio and you are using a 64bit Matlab, you do not have the 64bit LSL libraries in your built project. You need to download the pre-compiled version of lsl-Matlab SDK from [here](ftp://sccn.ucsd.edu/pub/software/LSL/SDK/).
* If you are using a 32bit version of Matlab, the 32bit LSL libraries will be enough. 
* Add liblsl-matlab folder and all subfolders to Matlab path.
* Run the examples for getting the data in real time from the device.
* The default setting in the example is for 4-channel device. If you are using an 8-channel device, change the following variables from 4 to 8:
  * Line 31:  _'<block.OutputPort(1).Dimensions       = 4; % Number of EEG channels>'_
  * Line 73:   _'<block.Dwork(1).Dimensions      = 4;  % Number of EEG channels>'_
