% Create physics
function model = comsol_create_physics(model, ind2)
global InitialVoltage AppliedVoltage CurrentSource 
model.physics.create('ec', 'ConductiveMedia', 'geom1'); % Initialize electric current physics 

model.physics('ec').feature('init1').set('V', 1, InitialVoltage);
model.physics('ec').feature.create('pc1', 'PeriodicCondition', 1);
Bdryindpbc = [ind2.pbc1, ind2.pbc2];
model.physics('ec').feature('pc1').selection.set(Bdryindpbc);
model.physics('ec').feature.create('gnd1', 'Ground', 1);
model.physics('ec').feature('gnd1').selection.set(ind2.Gnd);
model.physics('ec').feature.create('term1', 'Terminal', 1);
model.physics('ec').feature('term1').selection.set(ind2.tmnl);
model.physics('ec').feature('term1').set('TerminalType', 1, 'Voltage');
model.physics('ec').feature('term1').set('V0', 1, AppliedVoltage);

disp('created EC physics');
