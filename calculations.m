%%ENES220 Crane Project
%

cableSF = 2;
liveLoadMax = 100000;
cableUT = 200000;
motorHP = 50; %hp

pulleyRatio = 4;
liftHeight = 30*12 %inches

cableDiameter = sqrt(cableSF*liveLoadMax *4 / (pulleyRatio * cableUT * pi))

minDrumOD = 20*cableDiameter

cableTension = liveLoadMax / pulleyRatio

%HP = lb*in*RPM / 63024
motorRPM = motorHP * 63024 / (minDrumOD*.5*cableTension)

cableSpeed = minDrumOD*pi*motorRPM/60 %in/sec

liftTime = pulleyRatio * liftHeight/cableSpeed %seconds

J = (pi/32) * minDrumOD^4
TorsionalShearStressDrum = (cableTension* cableSF * (minDrumOD/2))/J

beamLength = 80*12; %inches
stDensity = 0.284; %lb/in^3
alDensity = 0098; %lb/in^3

beamArea = (insert_area); %inches^2
beamVolume = beamLength*beamArea; %inches^3
beamWeight = beamVolume*beamDensity; %lb
beamMOI = (insert_MOI);
beamE = (insert_moduluselasticity);

distributedWeight=beamWeight/beamLength
syms x
ShearForce=-distributedWeight*(x)^1 -(2000+100000*cableSF)/2 *(x-942)^0

beamSag = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-2000*beamLength^3)/(48*beamE*beamMOI)
beamVerticalDeflection = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-202000*beamLength^3)/(48*beamE*beamMOI)
beamSlope = (-1*distributedWeight*beamLength^3)/(24*beamE*beamMOI)+(-202000*beamLength^2)/(16*beamE*beamMOI)
