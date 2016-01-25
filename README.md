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
6. (optional) To disable extrinsic interphase (short molecules layer), change commented section in comsol_create_material.m
7. (optional, by commenting or uncommenting plot_results) experimental data of the sample 

#Check before running: 
1. User defined input: values and data that are specific to current sample or model
2. Model configuration parameters: default values for model config. 
3. load_constant.m: physics conditions specific to current sample or model
4. Make sure polymer matrix (RoomTempEpoxy), structure (crop_...) are in the same folder. 
 

# General procedure for 2D FEA permittivity study with COMSOL API in MATLAB

I. Run Dynamfit code (provided separately) to obtain Prony Series coefficients to use for dielectric 'master curve' for matrix. Run plot_matrix_epoxy to make sure result from prony series coefficients match with experimental data

For epoxy, use coefficients in 'RoomTempEpoxy.mat', which matches with 'neat_epoxy2-YH.csv'

II. Use realistic RVE microstructure from TEM, reversely fit interphase shift factors based on comparison with experimental DS data

Grayscale images are cropped from original TEM image so that side length is about 1 micron, which is about the RVE size.  Pixel length of scale bar is recorded to provide conversion ratio between pixel and physical length.

Then binary image of RVE structure is obtained with dynamic binarization algorithm ('Niblack') to reduce effect of uneven brightness in the background. 

In Niblack algorithm, particles with diameter smaller than 15 nm is removed as they are treated as artifacts on sample surface. Thus, scaling ratio needs to be defined in 'noise_filter' to reflect actual cutting threshold in pixel unit. The algorithm is run with 'user_niblack' by specifying image filename (with path pre-configured within this main script), side length in pixels, conversion ratio mode (see noise_filter), and initial window size. Increase window size to include more particles in binary image. 


III. Run FEA model with COMSOL API 

Open two console terminals
a. comsol server (confirm port 2036, otherwise make change in comsol_build)
b. matlab -nosplash -nodesktop

5 result files will output from the run: 1 MPH file of the COMSOL model, 2 CSV files with complex DS, without header, 2 images of comparison of data between simulated result and experimental data 

IV. Compare results to determine tuning shift factors: plot and compare FE with experimental results

Observe peak and relaxation position, then adjust shift factors

V. Change shifting factors and re-run FE model
Run comsol_conf_tuneSF after configuring parameters.
Define new shifting factors for next run. This requires trial and error

Repeat step IV until FE result matches with experimental result. Record shift factors used in last tune. 
