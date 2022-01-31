function writeCSV(EEG, ORN, Marker, file)
% Write data into csv file
%   This function gets the data structure and saves data into a csv file.
%   
%   Inputs:
%       - EEG
%           EEG.data: matrix of EEG data (nChan x nSample)
%           EEG.timestamp: matrix of EEG timestamps
%       - ORN
%           ORN.data: matrix of EEG data (nSensor x nSample)
%           ORN.timestamp: matrix of ORN timestamps
%   Output:
%       - void (saves two files in the same folder as file)
%
%   Github page: https://github.com/Mentalab-hub/explorematlab/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nChan = size(EEG.data, 1);

%% Writing the header
csvFileName_eeg = strcat(file(1:end-4),'_ExG.csv');
csvFileName_orn = strcat(file(1:end-4),'_ORN.csv');
csvFileName_marker = strcat(file(1:end-4),'_Marker.csv');


fid_eeg = fopen(csvFileName_eeg,'w'); 
fid_orn = fopen(csvFileName_orn,'w');
fid_marker = fopen(csvFileName_marker,'w');

fprintf(fid_eeg,'TimeStamp, ');

for i=1:nChan
    fprintf(fid_eeg,'%s, ',strcat('ch',int2str(i)));
end
fprintf(fid_eeg,'\n');

fprintf(fid_orn,'%s\n','TimeStamp, ax, ay, az, gx, gy, gz, mx, my, mz');

fprintf(fid_marker,'TimeStamp, Code\n');

%% Writing the data into csv file
dlmwrite(csvFileName_eeg, cat(2,EEG.timestamp', EEG.data'), '-append', 'precision','%.4f');
dlmwrite(csvFileName_orn, cat(2,ORN.timestamp', ORN.data'), '-append', 'precision','%.4f');
dlmwrite(csvFileName_marker, cat(2, Marker.timestamp, Marker.code), '-append');

fclose(fid_eeg);
fclose(fid_orn);
fclose(fid_marker);
end

