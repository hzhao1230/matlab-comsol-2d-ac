% Load constants
function [] = comsol_load_constant()

global AppliedVoltage InitialVoltage MatrixConductivity InterfaceConductivity CurrentSource FillerConductivity ... % electric properties
    FillerRelPerm InterfaceRelPerm InterfaceImagPerm ElectrodeConductivity ElectrodeRelPerm ...
    FreqRange TimeRange ACMode extra_E_infi

% Model parameters
extra_E_infi                        = -0.55;                % polymer matrix adjustment: vertical shift from prony series output and expt data comparison
AppliedVoltage                      = 1.5e-3;               % Initial voltage applied on electrode
InitialVoltage                      = 0.01e-3;              % Initial voltage applied over entire domain
CurrentSource                       = 2e3;                   % Current source from electrode
FreqRange                           = 10.^(-3:0.2:6);       % Frequency range of AC terminal

% Material Properties
MatrixConductivity                  = 1e-15;                 % Electric conductivity of fillers, matrix and interface
FillerConductivity                  = MatrixConductivity;    % Conductivity of filler
FillerRelPerm                       = 3.9;                   % 3x of matrix's. Relative permittivity of filler
InterfaceRelPerm                    = 1;                     % Relative permittivity of IF1
InterfaceImagPerm                   = 0.01; 
InterfaceConductivity               = 1e-15;                 % Conductivity of IF1

