% Post-processing. Create csv files for output results
function model = comsol_post_process(model,  ind2, savefile)
global AppliedVoltage dimensionY


% create 2D plot group
model.result.create('pg1', 2);
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'ec.normE');
model.result('pg1').feature('surf1').set('descr', 'Electric field norm');
model.result('pg1').name('Electric Field Norm (ec)');
model.result('pg1').run;

str_EpsilonBulkImag = sprintf('real(ec.Jy/%.3g[V])*%.3g*1e-3[mm]/ec.freq/2/3.14/8.85e-12[F/m]',AppliedVoltage,dimensionY);
model.result.numerical.create('av1', 'AvLine');
model.result.numerical('av1').selection.set(ind2.Gnd);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Average 1, Epsilon Double Prime');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').set('expr', str_EpsilonBulkImag);
model.result.numerical('av1').set('descr', 'Epsilon Double Prime');
model.result.numerical('av1').setResult;
model.result.create('pg2', 1);
model.result('pg2').feature.create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('table', 'tbl1');
model.result('pg2').run;
model.result.export.create('plot1', 'pg2', 'tblp1', 'Plot');
model.result.export('plot1').set('header', 'off');
txtfilenameImag = [savefile,'_CompPermImag.csv'];
disp('Write imaginary composite permittivity to file:'); disp(txtfilenameImag);        
model.result.export('plot1').set('filename', txtfilenameImag);
model.result.export('plot1').run;


str_EpsilonBulkReal = sprintf('imag(ec.Jy/%.3g[V])*%.3g*1e-3[mm]/ec.freq/2/3.14/8.85e-12[F/m]',AppliedVoltage,dimensionY);
% Create Line Average along ground surface
model.result.numerical.create('av2', 'AvLine');
model.result.numerical('av2').selection.set(ind2.Gnd);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Line Average 2, Epsilon Prime');
model.result.numerical('av2').set('table', 'tbl2');
model.result.numerical('av2').set('expr', str_EpsilonBulkReal);
model.result.numerical('av2').set('descr', 'Epsilon Prime');
model.result.numerical('av2').setResult;
txtfilenameReal = [savefile,'_CompPermReal.csv'];
model.result.create('pg3', 1);
model.result('pg3').feature.create('tblp2', 'Table');
model.result('pg3').feature('tblp2').set('table', 'tbl2');
model.result('pg3').run;
model.result.export.create('plot2', 'pg3', 'tblp2', 'Plot');
model.result.export('plot2').set('header', 'off');
model.result.export('plot2').set('filename', txtfilenameReal);
disp('Write real composite permittivity to file:'); disp(txtfilenameReal);        
model.result.export('plot2').run;           


end
