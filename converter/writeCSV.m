function writeCSV(EEG, ORN, Marker, file, device_info)
% Write data to CSV
%   This function gets the data structure and saves data into a csv file.
%   
%   Inputs:
%       - EEG
%           EEG.data: matrix of EEG data (nChan x nSample)
%           EEG.timestamp: matrix of EEG timestamps
%       - ORN
%           ORN.data: matrix of EEG data (nSensor x nSample)
%           ORN.timestamp: matrix of ORN timestamps
%       - Marker
%           Marker.code: int
%           Marker.timestamp: double
%       - file: string filepath to be written to (absolute path)
%       - device_info
%           device_info.data_rate: int
%           device_info.adc_mask: char array
%       - device_name: string
%   Output:
%       - void (saves four files in the same folder as file)
%
%   Github page: https://github.com/Mentalab-hub/explorematlab/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exg_units = 'uV';
nChan = size(EEG.data, 1);

%% Writing the header
csvFileName_eeg = strcat(file(1:end-4),'_ExG.csv');
csvFileName_orn = strcat(file(1:end-4),'_ORN.csv');
csvFileName_marker = strcat(file(1:end-4),'_Marker.csv');
csvFileName_meta = strcat(file(1:end-4),'_Meta.csv');

fid_eeg = fopen(csvFileName_eeg,'w');
fid_orn = fopen(csvFileName_orn,'w');
fid_marker = fopen(csvFileName_marker,'w');
fid_meta = fopen(csvFileName_meta,'w');

fprintf(fid_eeg,'TimeStamp, ');

for i=1:nChan
    fprintf(fid_eeg,'%s, ',strcat('ch',int2str(i)));
end
if fid_eeg == -1
    error(strcat('Unable to write to file: ', csvFileName_eeg, ['.' ...
        ' Either you do not have permission or the file is open.' ...
        ' Exiting.']))
    return
end
fprintf(fid_eeg,'\n');

if fid_orn == -1
    error(strcat('Unable to write to file: ', csvFileName_orn, ['.' ...
        ' Either you do not have permission or the file is locked.' ...
        ' Exiting.']))
    return
end
fprintf(fid_orn,'%s\n','TimeStamp, ax, ay, az, gx, gy, gz, mx, my, mz');

if fid_marker == -1
    error(strcat('Unable to write to file: ', csvFileName_marker, ['.' ...
        ' Either you do not have permission or the file is locked.' ...
        ' Exiting.']))
    return
end
fprintf(fid_marker,'TimeStamp, Code\n');

if fid_meta == -1
    error(strcat('Unable to write to file: ', csvFileName_meta, ['.' ...
        ' Either you do not have permission or the file is locked.' ...
        ' Exiting.']))
    return
end
fprintf(fid_meta, 'DateTime, Device, sr, adcMask, ExGUnits');

%% Writing the data into csv file
dlmwrite(csvFileName_eeg, cat(2, EEG.timestamp', EEG.data'), '-append', 'precision','%.4f');
dlmwrite(csvFileName_orn, cat(2, ORN.timestamp', ORN.data'), '-append', 'precision','%.4f');
dlmwrite(csvFileName_marker, cat(2, Marker.timestamp, Marker.code), '-append');
% Cannot use the same method to write non-numerics (the adc_mask)
writetable(cell2table([{'NaN'}, {'NaN'}, num2cell(device_info.data_rate), {device_info.adc_mask}, {exg_units}]), csvFileName_meta, 'WriteMode', 'Append');

% Make sure we aren't leaving anything open
fclose('all');
end

