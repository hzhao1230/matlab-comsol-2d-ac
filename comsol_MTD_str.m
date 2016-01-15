% Write Multi-Term Debye relaxation functions in strings for COMSOL model
function [str_real,str_imag, str_Intreal, str_Intimag] = comsol_MTD_str(x)
global tau0
% Input structure:
% x(2k-1):deltaEpsilon_k, x(2k):log(tau_k), x(length(x)):Epsilon_infi
NumOfTerms=floor((length(x))./2);
str_real = '';
str_imag = '';
str_Intreal = '';
str_Intimag = '';
for i=1:NumOfTerms
    str_CurrentTermReal = sprintf('+%.3g/(1+(10^(%.3g)*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i));
    str_CurrentTermImag = sprintf('+%.3g*(10^(%.3g)*ec.freq/1[Hz])/(1+(10^(%.3g)*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i),x(2*i));
    
    % Assign DS1 DS2 TS1 TS2 to reflect alpha and beta relaxation in spectroscopy
    if 10^(x(2*i)) > tau0 % Use DS2 TS2, alpha relaxation
        str_CurrentIntTermReal = sprintf('+%.3g*DS2/(1+(10^(%.3g)*TS2*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i));
        str_CurrentIntTermImag = sprintf('+%.3g*DS2*(10^(%.3g)*TS2*ec.freq/1[Hz])/(1+(10^(%.3g)*TS2*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i),x(2*i));
    else % use DS1 TS1, beta relaxation
        str_CurrentIntTermReal = sprintf('+%.3g*DS1/(1+(10^(%.3g)*TS1*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i));
        str_CurrentIntTermImag = sprintf('+%.3g*DS1*(10^(%.3g)*TS1*ec.freq/1[Hz])/(1+(10^(%.3g)*TS1*ec.freq/1[Hz])^2)',x(2*i-1),x(2*i),x(2*i));
    end
    
    str_real = strcat(str_real, str_CurrentTermReal);
    str_imag = strcat(str_imag, str_CurrentTermImag);
    str_Intreal = strcat(str_Intreal, str_CurrentIntTermReal);
    str_Intimag = strcat(str_Intimag, str_CurrentIntTermImag);
end
str_real=strcat(str_real, sprintf('+%0.3g', x(length(x))));% epsilon_infi is added.
str_Intreal=strcat(str_Intreal, sprintf('+%0.3g+const', x(length(x))));
