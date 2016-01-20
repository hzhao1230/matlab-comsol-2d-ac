% Assign entities with material properties

function model = comsol_create_material(model)
global      MatrixConductivity FillerConductivity FillerRelPerm ElectrodeConductivity ElectrodeRelPerm InterfaceConductivity InterfaceRelPerm InterfaceImagPerm 
	
% Define filler material
model.material.create('mat1');
model.material('mat1').selection.named('geom1_UnionFiller_dom');
model.material('mat1').propertyGroup('def').set('electricconductivity', FillerConductivity);
model.material('mat1').propertyGroup('def').set('relpermittivity',FillerRelPerm);

% Define matrix material
model.material.create('mat2'); % Matrix
model.material('mat2').selection.named('geom1_DiffMatrix_dom');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'ep-j*epp'});
model.material('mat2').propertyGroup('def').set('electricconductivity', MatrixConductivity); 

% Define extrinsic interface materials - thin
model.material.create('mat4');  
model.material('mat4').selection.named('geom1_DiffInterface1_dom');

strInterfacePerm = [num2str(InterfaceRelPerm),'-j*', num2str(InterfaceImagPerm)];
model.material('mat4').propertyGroup('def').set('relpermittivity', strInterfacePerm);   
model.material('mat4').propertyGroup('def').set('electricconductivity', InterfaceConductivity);     
   
%%% Uncomment below to remove the effect of this thin layer IF1
%   model.material('mat4').propertyGroup('def').set('relpermittivity', {'epint-j*eppint'});                                 
%   model.material('mat4').propertyGroup('def').set('electricconductivity', MatrixConductivity);

% Define intrinsic interface materials - thicker
model.material.create('mat5'); 
model.material('mat5').selection.named('geom1_DiffInterface2_dom');                       
model.material('mat5').propertyGroup('def').set('relpermittivity', {'epint-j*eppint'});
model.material('mat5').propertyGroup('def').set('electricconductivity', MatrixConductivity);      

disp('Created all materials');
end
