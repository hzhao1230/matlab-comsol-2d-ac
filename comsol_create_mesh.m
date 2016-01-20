% Create mesh
function model = comsol_create_mesh(model, ind2)
global ManualMesh MeshLevel
model.mesh.create('mesh1', 'geom1');
if ManualMesh % User-defined mesh
    % Define meshing parameters
    hmax                         = 0.08;                 % max element size
    hmin                         = 0.01;                 % min element size
    hgrad                        = 1.5;                  % max element growth rate
    hcurve                       = 5;                    % resolution of curvature
    hnarrow                      = 0.2;                  % resolution of narrow regions    
    model.mesh('mesh1').automatic(false);      
    model.mesh('mesh1').feature('size').set('custom', 'on');   
    model.mesh('mesh1').feature('size').set('hmax', hmax);
    model.mesh('mesh1').feature('size').set('hmin', hmin);
    model.mesh('mesh1').feature('size').set('hgrad', hgrad);
    model.mesh('mesh1').feature('size').set('hcurve', hcurve);
    model.mesh('mesh1').feature('size').set('hnarrow', hnarrow);
else % Automatic physics-controlled mesh
    model.mesh('mesh1').autoMeshSize(MeshLevel); 
end
model.mesh('mesh1').run;

disp('Finished meshing');
end
