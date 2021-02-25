# MATLAB-based API for Explore data acquisition

This API allows you to get the data directly from Explore device via MATLAB software. 

## Requirements

* MATLAB Instrument Control Toolbox™ (Currently only supported on Windows 10 and MAC)
* MATLAB SIMULINK
* MATLAB DSP System Toolbox

# How to run

* Pair Explore device with your computer
* Run setup.m to add needed paths to MATLAB
* Go to api folder
* The code "api_no_viz.m" gives you access to raw data. You need to specify the device name in the code: `device_name = "Explore_####";` which `####` is the last 4 MAC address of your Explore device.
* For EEG signal visualization in Simulink open and run "eeg4_demo.slx" or "eeg8_demo.slx" for 4 and 8 channel devices respectively. Before running, enter the device name in Matlab editor by `device_name = "Explore_####";`
* For orientation data visualization in Simulink open and run "orn_demo.slx". Before running the scenario, enter the device name in Matlab editor by `device_name = "Explore_####";`

