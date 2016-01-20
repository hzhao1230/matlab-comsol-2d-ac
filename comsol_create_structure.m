% Create statistically re-generated filler/interface geometry
% Nomenclature: 
% IP1: extrinsic, short moledule layer
% IP2: intrinsic, interfacial polymer, the 'interphase'

function [model] = comsol_create_structure(model)
global InterfaceThickness1 InterfaceThickness2 dimensionX dimensionY ... 
    EllipseMatrix NewClusterNo ...

disp('Generating cluster microstructure ...');
FeatureName={}; % List of filler circles
FeatureName1={}; % List of interface circles

% Create fillers
for i = 1 : NewClusterNo
    FeatureName{i}=['Ellipse',num2str(i)];
    model.geom('geom1').feature().create(FeatureName{i},'Ellipse');
    model.geom('geom1').feature(FeatureName{i}).set('pos',[EllipseMatrix(i,4) EllipseMatrix(i,5)]);
    model.geom('geom1').feature(FeatureName{i}).set('semiaxes',[EllipseMatrix(i,2), EllipseMatrix(i,3)]);
    model.geom('geom1').feature(FeatureName{i}).set('rot', EllipseMatrix(i,1));
    model.geom('geom1').feature(FeatureName{i}).set('createselection','on');
    disp(['Ellipse',num2str(i)])
end
model.geom('geom1').runAll;
model.geom('geom1').feature.create('UnionFiller', 'Union');
model.geom('geom1').feature('UnionFiller').selection('input').set(FeatureName);
model.geom('geom1').feature('UnionFiller').set('createselection', 'on');
model.geom('geom1').feature('UnionFiller').set('intbnd', 'off');
model.geom('geom1').runAll;

% Create Ellipses containing IF1 and fillers
for i = 1: NewClusterNo
    FeatureName1{i}=['EllipseIF1',num2str(i)];
    model.geom('geom1').feature().create(FeatureName1{i},'Ellipse');
    model.geom('geom1').feature(FeatureName1{i}).set('pos',[EllipseMatrix(i,4) EllipseMatrix(i,5)]);
    model.geom('geom1').feature(FeatureName1{i}).set('semiaxes',[EllipseMatrix(i,2)+InterfaceThickness1, EllipseMatrix(i,3)+InterfaceThickness1]);
    model.geom('geom1').feature(FeatureName1{i}).set('rot', EllipseMatrix(i,1));
    model.geom('geom1').feature(FeatureName1{i}).set('createselection','on');
    disp(['EllipseIF1-',num2str(i)])
end
model.geom('geom1').runAll;
model.geom('geom1').feature.create('UnionLargeEllipse1', 'Union');
model.geom('geom1').feature('UnionLargeEllipse1').selection('input').set(FeatureName1);
model.geom('geom1').feature('UnionLargeEllipse1').set('createselection', 'on');
model.geom('geom1').feature('UnionLargeEllipse1').set('intbnd', 'off');
model.geom('geom1').runAll;

% Create IF1 by taking difference between 1st outer ellipses and fillers
model.geom('geom1').feature.create('DiffInterface1', 'Difference');
model.geom('geom1').feature('DiffInterface1').selection('input').set('UnionLargeEllipse1');
model.geom('geom1').feature('DiffInterface1').selection('input2').set('UnionFiller');
model.geom('geom1').feature('DiffInterface1').set('keep', 'on');
model.geom('geom1').feature('DiffInterface1').set('createselection', 'on');
model.geom('geom1').feature('DiffInterface1').set('intbnd', 'off');
model.geom('geom1').runAll;

% Ellipses contain IF2, IF1 and fillers
for i = 1: NewClusterNo
    FeatureName2{i}=['EllipseIF2',num2str(i)];
    model.geom('geom1').feature().create(FeatureName2{i},'Ellipse');
    model.geom('geom1').feature(FeatureName2{i}).set('pos',[EllipseMatrix(i,4) EllipseMatrix(i,5)]);
    model.geom('geom1').feature(FeatureName2{i}).set('semiaxes',[EllipseMatrix(i,2)+InterfaceThickness1+InterfaceThickness2, EllipseMatrix(i,3)+InterfaceThickness1+InterfaceThickness2]);
    model.geom('geom1').feature(FeatureName2{i}).set('rot', EllipseMatrix(i,1));
    model.geom('geom1').feature(FeatureName2{i}).set('createselection','on');
    disp(['EllipseIF2-',num2str(i)])
end
model.geom('geom1').runAll;
model.geom('geom1').feature.create('UnionLargeEllipse2', 'Union');
model.geom('geom1').feature('UnionLargeEllipse2').selection('input').set(FeatureName2);
model.geom('geom1').feature('UnionLargeEllipse2').set('createselection', 'on');
model.geom('geom1').feature('UnionLargeEllipse2').set('intbnd', 'off');
model.geom('geom1').runAll;

% Create IF2 by taking difference between 2nd and 1st outer ellipses
model.geom('geom1').feature.create('DiffInterface2', 'Difference');
model.geom('geom1').feature('DiffInterface2').selection('input').set('UnionLargeEllipse2');
model.geom('geom1').feature('DiffInterface2').selection('input2').set('UnionLargeEllipse1');
model.geom('geom1').feature('DiffInterface2').set('keep', 'on');
model.geom('geom1').feature('DiffInterface2').set('createselection', 'on');
model.geom('geom1').feature('DiffInterface2').set('intbnd', 'off');
model.geom('geom1').runAll;

% Define rectangular domain
model.geom('geom1').feature.create('RectBlock', 'Rectangle');
model.geom('geom1').feature('RectBlock').set('size', [dimensionX, dimensionY]);
model.geom('geom1').feature('RectBlock').set('createselection', 'on');
model.geom('geom1').run('RectBlock');

model.geom('geom1').feature.create('DiffMatrix', 'Difference');
model.geom('geom1').feature('DiffMatrix').selection('input').set('RectBlock');
model.geom('geom1').feature('DiffMatrix').selection('input2').set('UnionLargeEllipse2');
model.geom('geom1').feature('DiffMatrix').set('keep', 'on');
model.geom('geom1').feature('DiffMatrix').set('createselection', 'on');
model.geom('geom1').runAll;

mphsave(model, 'GEOM_ONLY') % Save temp comsol model to file for debug

disp('Finished building unions and differences on fillers, interphase, and rectangular simulation block.');