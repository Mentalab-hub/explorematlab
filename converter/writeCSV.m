function [outputArg1,outputArg2] = writeCSV(EEG, ORN, file)
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
csvFileName_eeg = strcat(file(1:end-4),'_EEG.csv');
csvFileName_orn = strcat(file(1:end-4),'_ORN.csv');

fid_eeg = fopen(csvFileName_eeg,'w'); 
fid_orn = fopen(csvFileName_orn,'w');

fprintf(fid_eeg,'%s, ','TimeStamp');

for i=1:nChan
    fprintf(fid_eeg,'%s, ',strcat('ch',int2str(i)));
end

fprintf(fid_eeg,'\n%s, ','hh:mm:ss');
for i=1:nChan
    fprintf(fid_eeg,'%s, ','mV');
end
fprintf(fid_eeg,'\n');

fprintf(fid_orn,'%s \n','TimeStamp, ax, ay, az, gx, gy, gz, mx, my, mz');
fprintf(fid_orn,'%s \n, ','hh:mm:ss, mg/LSB, mg/LSB, mg/LSB, mdps/LSB, mdps/LSB, mdps/LSB, mgauss/LSB, mgauss/LSB, mgauss/LSB');

%% Writing the data into csv file
dlmwrite(csvFileName_eeg, cat(2,EEG.timestamp', EEG.data'), '-append');
dlmwrite(csvFileName_orn, cat(2,ORN.timestamp', ORN.data'), '-append');

fclose(fid_eeg);
fclose(fid_orn);
end

