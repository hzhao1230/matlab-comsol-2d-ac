% Add or update shifting factors 
function model = comsol_create_shifting_factors(model, x)
str_TauShift1               = num2str(x(1));
str_DeltaEpsilonShift1      = num2str(x(2));
str_TauShift2               = num2str(x(3));
str_DeltaEpsilonShift2      = num2str(x(4));
str_ConstantC               = num2str(x(5));
model.variable('var1').set('TS1',str_TauShift1); 
model.variable('var1').set('DS1',str_DeltaEpsilonShift1);
model.variable('var1').set('TS2',str_TauShift2); 
model.variable('var1').set('DS2',str_DeltaEpsilonShift2);
model.variable('var1').set('const',str_ConstantC);
end