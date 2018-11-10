%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script gets the data packages from Explore device and print them in
% MATLAB command view.
%
% Github page: https://github.com/Mentalab-hub/explorematlab/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

HardwareInfo = instrhwinfo('Bluetooth','Explore');
channel = HardwareInfo.Channels{1,1};
bt = Bluetooth('Explore', str2num(channel));
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
            disp(eeg8_data(:,end)) % Prints the last sample
        case 'end'
            is_acquiring = 0;
    end
end

fclose(bt);