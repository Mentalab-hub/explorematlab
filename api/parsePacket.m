function [output] = parsePacket(fid)
% Parse the incoming data package
%   This function reads and parses one data package from the input stream.
%   
%   Input:
%       - fid: file/stream identifier
%   Output:
%       - fid: file/stream identifier
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output = [];
interruptWarning = 'Stream interrupted unexpectedly!';
fletcherMismatchWarning = 'Fletcher mismatch!';
pidUnexpectedWarning = 'Unexpected package ID: ';
[pid,n] = fread(fid,1,'*ubit8');    % Read the package ID
if n==0
    warning(interruptWarning);
    return; % No data in the stream/file
end
output.cnt = fread(fid,1,'*ubit8');        % Counter of the package
payload = fread(fid,1,'uint16');    % Number of bytes in the package
timestamp = fread(fid,1,'uint32');  % Timestamp of the package

switch pid
    case 13         % Orientation package
        output.type = 'orn';
        output.orn = fread(fid,(payload-8)/2,'int16');
    
    case 19         % Environment package
        output.type = 'env';
        output.temperature = fread(fid,1,'*bit8');
        output.light = fread(fid,1,'uint16');
        output.battery = fread(fid,1,'uint16');
    
    case {144, 146, 30, 62} % EEG package
        [temp,n] = fread(fid,(payload-8)/3,'*bit24');
        if n< ((payload-8)/3) %check if the package terminates in between
            warning(interruptWarning);
            return;
        end
        if pid == 144  % Specify the number of channel and reference voltage
            output.type = 'eeg4';
            nChan = 5;      % 4 channels + 1 status
            vref = 2.4;
            nPacket = 33;
        elseif pid == 62
            output.type = 'eeg4';
            nChan = 5;      % 4 channels
            vref = 2.4;
            nPacket = [];
        else
            output.type = 'eeg8'
            nChan = 9;      % 8 channels + 1 status
            vref = 4.5;
            nPacket = [];
        end
        temp = reshape(temp,[nChan,nPacket]);
        output.data = double(temp(2:end,:))* vref / ( 2^23 - 1 ) * 6/32; % Calculate the real voltage value
        %output.status = temp(1,:);    %save the status of data points
    case 27
        output.type = 'ts';
        output.timestamp = fread(fid,(payload-8)/4,'uint32');
    otherwise
        warning([pidUnexpectedWarning pid])
        temp = fread(fid,payload-8,'*bit8'); % Read the payload
end


% Check the consistency of the Fletcher
[fletcher, n] = fread(fid,4,'*ubit8');
if n<4
    warning(interruptWarning);
elseif((pid~=27)&&(fletcher(4) ~= 222)) || ((pid==27)&&(fletcher(4)~=255))
    disp(fletcher);
    warning(fletcherMismatchWarning)
end

end

