% Create study
function model = comsol_create_study(model)
global FreqRange 
model.study.create('std1');
model.study('std1').feature.create('freq', 'Frequency');
model.study('std1').feature('freq').set('geomselection', 'geom1');
model.study('std1').feature('freq').set('physselection', 'ec');
model.study('std1').feature('freq').set('plist', FreqRange);

disp('created study');
end
