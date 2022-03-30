%   convertBIN2csv.m - explorematlab toolbox
%
%   This script reads a recorded binary file and converts it to a csv file.
%   
%   Github page: https://github.com/Mentalab-hub/explorematlab/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the path to binary file
[file,path] = uigetfile('*.BIN');
if file == 0
  % user pressed cancel
  fprintf('File selection cancelled');
  return
end
filepath = strcat(path,file);

AdcMaskWarningMsg = ['The ADC mask has been changed in the binary' ...
                    ' file. This script is not able to process such ' ...
                    'a binary file. Please use Explorepy to '... 
                    'convert the file.'];
                
fid = fopen(filepath);
read = 1;
ORN.data = [];
ORN.timestamp = [];
EEG.data = [];
EEG.timestamp = [];
Marker.timestamp = [];
Marker.code = [];
ENV.temperature = [];
ENV.light = [];
ENV.battery = [];
ENV.timestamp = [];
TS = [];

%% Reading file
while read
    packet = parseBtPacket(fid);
    switch packet.type
        case 'dev_info'
            if ~strcmp(packet.adc_mask, device_info.adc_mask)
                display(['Old ADC mask: ' device_info.adc_mask]);
                display(['New ADC mask: ' packet.adc_mask]);
                warning(AdcMaskWarningMsg);
                break
            end
            device_info = packet;
        case 'orn'
            ORN.data = cat(2, ORN.data, packet.orn);
            ORN.timestamp = cat(2, ORN.timestamp, packet.timestamp);
        case {'eeg4', 'eeg8'}
            if ~exist('device_info', 'var') || isempty(device_info)
                    warning('No device info discovered. Skipping.')
                    break
            end
            nSample = size(packet.data, 2);
            t = linspace(packet.timestamp, packet.timestamp + ...
                (nSample - 1)/device_info.data_rate, nSample);  % Extrapolate sample timestamps
            EEG.data = cat(2, EEG.data, packet.data);
            EEG.timestamp = cat(2, EEG.timestamp, t);
        case 'marker_event'
            Marker.timestamp = cat(1, Marker.timestamp, packet.timestamp);
            Marker.code = cat(1, Marker.code, packet.code);
        case 'env'
            ENV.temperature = cat(2, ENV.temperature, packet.temperature);
            ENV.light = cat(2, ENV.light, packet.light);
            ENV.battery = cat(2, ENV.battery, packet.battery);
            ENV.timestamp = cat(2, ENV.timestamp, packet.timestamp);
        case 'ts'
            TS = cat(2, TS, packet.ts);
        case 'disconnect'
            disconnect = packet;
        case 'unimplemented'
            continue
        otherwise
            read = 0;
    end
end

%% Save data as csv files
writeCSV(EEG, ORN, Marker, filepath, device_info); % Saves four CSV files in the same directory as original binary file
