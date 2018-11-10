% Simple script for setting paths needed for explorematlab toolbox
%
%
% Github page: https://github.com/Mentalab-hub/explorematlab/

basedir = pwd; % The current directory

% Add needed directories
addpath([basedir '/api/'])
addpath([basedir '/api/parser'])
addpath([basedir '/api/s-functions'])
addpath([basedir '/converter/'])
addpath([basedir '/lsl-acquisition/'])