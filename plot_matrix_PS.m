% Plot permittivity of polymer matrix and interphase (output from prony series) as a
% function of frequency
% Practical usage: dielectric prony series tuning. 

function plot_matrix_PS
% ------------------input section------------------------
inc = 0.2;
logfreq = -4:inc:6; % Freq range
datafile = 'RoomTempEpoxy.mat'; % output from dynamfit
TS1                   = 1;                    % beta relaxation, s_beta, Tau shift. For tau <= 1, Shift multiplier along x direction. 1 is no shift
DS1                   = 1;                      % beta relaxation, M_beta, DeltaEpsilonShiftFor tau <= 1, Shift multiplier along y direction. 1 is no shift
TS2                   = 1;                      % Alpha relaxation, s_alpha, For tau > 1, Shift multiplier along x direction. 1 is no shift
DS2                   = 1;                       % Alpha relaxation, M_alpha, For tau > 1, Shift multiplier along y direction. 1 is no shift
CES                   = 0;               % ConstEpsilonShift
% -------------------------------------------------------
load(datafile)
[NumOfTerms,Temp] = size(TemPR); % from datafile
epsilon_inf = TemPR(NumOfTerms,2);

ep = zeros(length(logfreq),1);epp=zeros(length(logfreq),1);
intep = zeros(length(logfreq),1);intepp=zeros(length(logfreq),1);
for j = 1:length(logfreq)
    epsilonp =0; epsilonpp =0;
    intepsilonp = 0; intepsilonpp = 0;
    freq =10^logfreq(j);
    for i = 1 : NumOfTerms - 1
        deltaEpsilon =TemPR(i,2);
        tau =TemPR(i,1);
        epsilonp = epsilonp  + deltaEpsilon/(1+(freq*tau)^2);
        epsilonpp = epsilonpp + deltaEpsilon*freq*tau/(1+(freq*tau)^2);
        if tau>1
            intepsilonp = intepsilonp + DS2*deltaEpsilon/(1+(TS2*freq*tau)^2);
            intepsilonpp = intepsilonpp + DS2*deltaEpsilon*TS2*freq*tau/(1+(TS2*freq*tau)^2);
        else
            intepsilonp = intepsilonp + DS1*deltaEpsilon/(1+(TS1*freq*tau)^2);
            intepsilonpp = intepsilonpp + DS1*deltaEpsilon*TS1*freq*tau/(1+(TS1*freq*tau)^2);
        end
    end
    epsilonp = epsilonp + epsilon_inf;
    intepsilonp = intepsilonp + epsilon_inf+CES;
    ep(j) = epsilonp; epp(j) = epsilonpp;
    intep(j) = intepsilonp; intepp(j)=intepsilonpp;
end
logfreq=logfreq';
freq = 10.^(logfreq);
figure(), plot(logfreq,ep), hold on
% plot(logfreq,intep,'r')
figure(), plot(logfreq,epp),hold on
% plot(logfreq,intepp,'r')
PSresults = zeros(length(freq),3);
tune_eps_inf = 3.65;
ep=ep+tune_eps_inf;
PSresults(:,1)=freq; PSresults(:,2)=ep; PSresults(:,3)=epp;
% save('EpoxyFreqEpEpp','PSresults')
% save('IPLogFreqEpsilon','logfreq','intep','intepp')
end
