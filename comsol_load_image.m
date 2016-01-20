% myfun_comsol_load_image

function [] = comsol_load_image( structure)
global  dimensionX dimensionY DomLength ...
    dimension_to_pixel CutSide EllipseMatrix NewClusterNo...
    vf_expt ReScale ... 

RemainSide = 1-2*CutSide;   

% Obtain dimension-to-pixel ratio and simulation box side length.
disp(['Ratio of physical length to pixel: ', num2str(dimension_to_pixel),'nm-per-pixel'])

% Load img_para matrix and assign data into EllipseMatrix for creating structure
load(structure);
dimensionY = dimensionX; 
[NewClusterNo, Nrow] = size(img_para);
EllipseMatrix=zeros(NewClusterNo,5);
EllipseMatrix(:,1)=img_para(1:NewClusterNo,1); % rotation angle. Unit in degree
EllipseMatrix(:,2)=img_para(1:NewClusterNo,2); % long axis
EllipseMatrix(:,3)=img_para(1:NewClusterNo,3); % short axis
EllipseMatrix(:,4)=img_para(1:NewClusterNo,4) + CutSide*dimensionX; % X pos
EllipseMatrix(:,5)=img_para(1:NewClusterNo,5) + CutSide*dimensionY; % Y pos


disp(['Number of clusters in FEA geometry: ',num2str(NewClusterNo)])
ActualVF = 3.1416*EllipseMatrix(:,2)'*EllipseMatrix(:,3)/(dimensionX*dimensionY);
disp(['Actual VF in simulation window: ',num2str(ActualVF)])

% Correct long/short axes to match apparent VF with labeled
if ReScale == 1
	ScaleRatio = sqrt(vf_expt/ActualVF);
	EllipseMatrix(:,2) = EllipseMatrix(:,2)*ScaleRatio; 
	EllipseMatrix(:,3) = EllipseMatrix(:,3)*ScaleRatio; 
	CorrectedVF = 3.1416*EllipseMatrix(:,2)'*EllipseMatrix(:,3)/(dimensionX*dimensionY);
	disp(['Corrected VF in simulation window: ',num2str(CorrectedVF)]) 
end

end