# matlab-comsol-2d-ac
matlab code for FE simulation of nanodielectric relaxation using COMSOL API

This program is part of suite of codes for FEA modeling of nanodielectric relaxation. 

#Software Requirement: 

COMSOL 4.2 or above. 

MATLAB

#Run model:
1. Open comsol server on command line
2. Check assigned port number and enter it in comsol_conf.m
3. Check path of comsol binary files and enter it in comsol_conf.m
4. Open matlab and run comsol_conf.m

#Files needed before running：
1. MAT containing polymer matrix data (RoomTempEpoxy.mat in the example case): contains a variable named 'TemPR' that contains prony series coefficients from Dyanmifit algorithm. 
2. CSV containing experimental data of dielectric relaxation. 
3. MAT contaning microstructure geometry of nanophase. 

#Data required for getting solution: 
1. Shift factors for interphase (Tau/DeltaEpsilon Shift 1/2) for alpha and beta relaxations
2. Tau0: threshold relaxation time that separates alpha from beta relaxations
3. Dimension_to_pixel ratio (nm/pixel). Conversion between physical and image sizes
4. IP1/IP2: user defined interphase thicknesses 
5. Volume fraction: imposed volume fractin of nanophase 

#Check before running: 
1. User defined input: values and data that are specific to current sample or model
2. Model configuration parameters: default values for model config. 
3. load_constant.m: physics conditions specific to current sample or model
4. Make sure polymer matrix (RoomTempEpoxy), structure (crop_...) are in the same folder. 
 


