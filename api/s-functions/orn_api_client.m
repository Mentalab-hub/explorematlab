function orn_api_client(block)
%   A MATLAB S-function for acquisition of EEG singal from Mentalab Explore
%   device.



setup(block);

%% Function: setup ===================================================
%   - Input port (to synchronize clock frequency)
%   - Output ports: EEG signal

%%
function setup(block)

% Register number of ports
block.NumInputPorts  = 0;
block.NumOutputPorts = 1;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
% block.InputPort(1).Dimensions        = 1;
% block.InputPort(1).DatatypeID  = 0;  % double
% block.InputPort(1).Complexity  = 'Real';
% block.InputPort(1).DirectFeedthrough = true;

% Override output port properties
block.OutputPort(1).Dimensions       = 9; % Orientation data
block.OutputPort(1).DatatypeID  = 0; % double
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';


% Register parameters
block.NumDialogPrms     = 0;

% Register sample times
block.SampleTimes = [1/23 0];
block.SimStateCompliance = 'DefaultSimState';

%% -----------------------------------------------------------------
%% The MATLAB S-function uses an internal registry for all
%% block methods. You should register all relevant methods
%% (optional and required) as illustrated below. You may choose
%% any suitable name for the methods and implement these methods
%% as local functions within the same file. See comments
%% provided for each function for more information.
%% -----------------------------------------------------------------

block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate); % Required

%end setup

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C-Mex counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)
block.NumDworks = 1;
  
  block.Dwork(1).Name            = 'x1';
  block.Dwork(1).Dimensions      = 9;  % orientation data
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;


%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C-MEX counterpart: mdlInitializeConditions
%%
function InitializeConditions(block)

eml.extrinsic('evalin');
device_name = evalin('base', 'device_name');

HardwareInfo = instrhwinfo('Bluetooth',device_name);
channel = HardwareInfo.Channels{1,1};

global bt
bt = Bluetooth(device_name, str2num(channel));
fopen(bt);
%end InitializeConditions


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C-MEX counterpart: mdlStart
%%
function Start(block)

block.Dwork(1).Data = zeros(1, block.Dwork(1).Dimensions); % Initialize the temporary workspace

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C-MEX counterpart: mdlOutputs
%%
function Outputs(block)
global bt

read = 1;
while read 
    package = parseBtPacket(bt);
    switch package.type
        case 'orn'
             block.OutputPort(1).Data = package.orn;
             read = 0;
        case 'eeg4'
%             block.OutputPort(1).Data = package.data';
%             read = 0;
        case 'end'
            is_acquiring = 0;
    end
end

% block.OutputPort(1).Data = block.Dwork(1).Data; % Push data to output
% block.OutputPort(2).Data = block.Dwork(2).Data; % Push data to outpub

%end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlUpdate
%%
function Update(block)


%end Update

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlDerivatives
%%
function Derivatives(block)

%end Derivatives

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C-MEX counterpart: mdlTerminate
%%
function Terminate(block)
global bt
fclose(bt)
%end Terminate

