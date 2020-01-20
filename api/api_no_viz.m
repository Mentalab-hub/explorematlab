%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script gets the data packages from Explore device and print them in
% MATLAB command view.
%
% Github page: https://github.com/Mentalab-hub/explorematlab/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

device_name = 'Explore_2FA3';
HardwareInfo = instrhwinfo('Bluetooth',device_name);
channel = HardwareInfo.Channels{1,1};
bt = Bluetooth(device_name, str2num(channel));
fopen(bt);


is_acquiring = 1;

while is_acquiring
    package = parseBtPacket(bt);
    disp(package.type)
    switch package.type
        case 'orn'
            orn_data = package.orn';
            disp(orn_data)
        case 'eeg4'
            eeg4_data = package.data;
            disp(eeg4_data(:,end)) % Prints the last sample
        case 'eeg8'
            eeg8_data = package.data;
            disp(eeg8_data(:,end)') % Prints the last sample
        case 'dev_info'
            disp(['Explore firmware version: ' package.fw_version]);
            disp(['Explore ExG sampling rate: ' num2str(package.data_rate)]);
            disp(['Explore ADC mask: ' package.adc_mask]);
        case 'marker_event'
            disp(['Marker event with code: ' num2str(package.code)]);
        case 'end'
            is_acquiring = 0;
    end
end

fclose(bt);