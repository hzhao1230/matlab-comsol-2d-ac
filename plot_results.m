function plot_results(savefile,exptdata)

set(0,'DefaultFigureColor',[1 1 1])
% Set figure axes linewidth to 2
set(0,'defaultaxeslinewidth',2);
% Set figure linewidth to 2
set(0,'defaultlinelinewidth',2);
% Set figure axes fontsize to 20
set(0,'defaultaxesfontsize',20);
% Set figure text fontsize to 20
set(0,'defaulttextfontsize',20);

res_ep = [savefile,'_CompPermReal.csv'];
res_epp = [savefile,'_CompPermImag.csv'];
FEAPermReal = csvread(res_ep);
FEAPermImag = csvread(res_epp );
freq = FEAPermImag(:,1);
epp1 = FEAPermImag(:,2);
ep1 = FEAPermReal(:,2);

EXPTPerm = csvread(exptdata); % Experimental data
freqEXPT = EXPTPerm(:,1);
epEXPT = EXPTPerm(:,2);
eppEXPT = EXPTPerm(:,3);


f1=figure('visible','off'); % real
semilogx(freq,ep1), hold on
semilogx(freqEXPT, epEXPT, 'r')
xlabel 'log(Frequency [Hz])'
ylabel '\epsilon^'''
set(gca, 'XTick', [10.^-4 10.^-3 10.^-2 10.^-1 10.^0 10.^1 10.^2 10.^3 10.^4 10.^5 10.^6 ])
axis([freq(1) freq(end) min(ep1)*0.9 max(ep1)*1.1 ])

f2=figure('visible','off'); % imag
semilogx(freq,epp1),hold on
semilogx(freqEXPT, eppEXPT, 'r')
xlabel 'log(Frequency [Hz])'
ylabel '\epsilon^"'
axis([freq(1),freq(end), min(epp1)*0.9, max(epp1)*1.1 ]) 
set(gca, 'XTick', [10.^-4 10.^-3 10.^-2 10.^-1 10.^0 10.^1 10.^2 10.^3 10.^4 10.^5 10.^6 ])

saveas(f1,'./compare_epsilon_real','jpeg')
saveas(f2,'./compare_epsilon_imag','jpeg')

end