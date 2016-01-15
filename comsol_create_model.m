% Create a COMSOL model (geometry, random function (if needed), variable
% definitions.
function model = comsol_create_model(model)
global epmodel
% Create 2D geometry
model.geom.create('geom1', 2);
%model.geom('geom1').lengthUnit('um');
model.geom('geom1').lengthUnit([native2unicode(hex2dec('00b5'), 'Cp1252') 'm']);

model.variable.create('var1');
model.variable('var1').model('mod1');
        model.variable('var1').set('ep',epmodel.ep);
        model.variable('var1').set('epp',epmodel.epp);
        model.variable('var1').set('epint',epmodel.epint);
        model.variable('var1').set('eppint',epmodel.eppint);


