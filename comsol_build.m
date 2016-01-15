% 'myfun_comsol_build': build and compute solution from COMSOL 

function [model] = comsol_build(PScoeff, structure,savefile)
% Initialization
global TauShift1 DeltaEpsilonShift1 TauShift2 DeltaEpsilonShift2 ConstEpsilonShift ACMode EpsDistribution ...
    ControlMode GetSolution PortNum

%% Section I: Load Data
comsol_load_constant();

% Step One: Load input dielectric function model, if needed
if EpsDistribution
	comsol_load_epsilon_model(PScoeff);
end

% Step Two: Define composite structure
comsol_load_image(structure);

% Connect with COMSOL server with port number, default 2036.
mphstart(PortNum);
import com.comsol.model.*
import com.comsol.model.util.*
model = ModelUtil.create('Model');
model.modelNode.create('mod1');

%% Section II: Create COMSOL model
% Step One: Initialize model
model       = comsol_create_model(model);

% Step Two: Create statistically re-generated microstructure
model       = comsol_create_structure(model);

% Step Four: Create boundary selection indices
indBoundary = comsol_create_boundary_selection(model);

% Step Five: Assign entities with material properties
model       = comsol_create_material(model);

% Step Six: Create physics
model       = comsol_create_physics(model, indBoundary);

% Step Seven: Create mesh
model       = comsol_create_mesh(model,  indBoundary);

% Step Eight: Assign shift factors for interphase 
SF  	= [TauShift1, DeltaEpsilonShift1, TauShift2 ,DeltaEpsilonShift2,ConstEpsilonShift  ];
model   = comsol_create_shifting_factors(model, SF);

%% Section III:  Obtain solution from COMSOL
% Step One: Create Physics-based Study
model       = comsol_create_study(model);

mphsave(model, 'PRECOMPUTED')

if GetSolution == 1
    % Step Two: Obtain solution
    model   = comsol_create_solution(model);
    
    % Step Three: Post-processing
    model   = comsol_post_process(model, indBoundary, savefile);
end

end