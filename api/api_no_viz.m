%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

instrhwinfo('Bluetooth','Explore')
bt = Bluetooth('Explore', 5);
fopen(bt);

t=[];
n = 1;
is_acquiring = 1;
%orn_data = zeros(9,1);
while is_acquiring
    package = parseBtPacket(bt);
    disp(package.type)
    switch package.type
        case 'orn'
            orn_data = package.orn';
            disp(orn_data)
        case 'eeg4'
            eeg4_data = package.data;
            disp(eeg4_data(:,end))
        case 'end'
            is_acquiring = 0;
    end
    n = n + 1;
end

fclose(bt);