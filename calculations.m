%%ENES220 Crane Project


clc;

%MATERIAL CHARACTERISTICS
stDensity = 0.284; %lb/in^3
alDensity = 0.098; %lb/in^3
cableUT = 200000; %lb/in^2

%LIFTING ASSEMBLY DESIGN CHARACTERISTICS
%Given
liveLoadMax = 100000; %lb
motorHP = 50; %hp
liftHeight = 30*12; %in
%Design
cableSF = 2; %IMPORTANT
pulleyRatio = 4;
cableDiameter = sqrt(cableSF*liveLoadMax *4 / (pulleyRatio * cableUT * pi));
minDrumOD = 20*cableDiameter; %in


%BEAM DESIGN CHARACTERISTICS
%Given
beamLength = 80*12; %in
%Design
beamSF = 2; %IMPORTANT
beamWidth= 24; %inches
beamFlange = 2.5; %inches
beamHeight = 30; %inches
beamWeb = 2.5; %inches
beamDensity = stDensity; %lb/in^3
beamE = 30000000; %lb/in^2 modulus of elasticity, from steel

%LIFTING ASSEMBLY CALCULATED PHYSICAL CHARACTERISTICS
cableTension = liveLoadMax / pulleyRatio;

motorRPM = motorHP * 63024 / (minDrumOD*.5*cableTension); %HP = lb*in*RPM / 63024
cableSpeed = minDrumOD*pi*motorRPM/60; %in/sec
liftTime = pulleyRatio * liftHeight/cableSpeed; %seconds

J = (pi/32) * minDrumOD^4; %second polar moment of area
TorsionalShearStressDrum = (cableTension* cableSF * (minDrumOD/2))/J;

%BEAM CALCULATED PHYSICAL CHARACTERISTICS
b= beamHeight/2;
beamArea = (beamWidth*beamHeight)-(2*((beamHeight - 2*beamFlange)*(beamWidth/2-beamWeb/2))); %inches^2
beamVolume = beamLength*beamArea; %inches^3
Q = ((beamHeight-2*beamFlange)/2)*(beamWeb)*(((beamHeight-2*beamFlange)/2)/2)+beamFlange*beamWidth*(beamHeight/2-beamFlange/2); %1st moment of area
beamWeight = beamVolume*beamDensity; %lb
beamMOI = (1/12)*((beamWidth*beamHeight^3)-(beamWidth-beamWeb)*(beamHeight-(2*beamFlange))^3);

%REACTIONS AND FORCES

%BEAM SHEAR FORCE
distributedWeight=(beamWeight*1.2)/beamLength;
x = 80*12; %inches
reactionForce = (((1.5)*(12)*(50000+1000)+(40)*(12)*(distributedWeight))/(80*12));
shearForce=reactionForce-distributedWeight*(x)^1 -(1000+50000)*(x-942)^0;
shearStress = (shearForce * Q)/(beamMOI * b);

%BEAM MOMENT
moment = reactionForce*x-(distributedWeight/2)*(x)^2-(1000+50000)*(x-942);
z = beamMOI/(beamHeight/2);
momentStress = moment/z;

%BEAM DISTORTION
beamSag = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-1000*beamLength^3)/(48*beamE*beamMOI);
beamVerticalDeflection = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-51000*beamLength^3)/(48*beamE*beamMOI);
beamSlope = (-1*distributedWeight*beamLength^3)/(24*beamE*beamMOI)+(-51000*beamLength^2)/(16*beamE*beamMOI);
additionalDeflection = beamVerticalDeflection-beamSag;

%DISPLAY
normalReturn = sprintf('Normal (bending) stress = %s psi',momentStress);
disp(normalReturn);
shearReturn = sprintf('Shear stress = %s psi',shearStress);
disp(shearReturn);
deflectionReturn = sprintf('Beam deflection = %s in',additionalDeflection);
disp(deflectionReturn);
