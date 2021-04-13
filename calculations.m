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
alDensity = 0.098; %lb/in^3

beamWidth= 12; %inches
beamFlange = 1.02; %inches
beamHeight = 36.01; %inches
beamWeb = .65; %inches
b= beamHeight/2
Q = ((beamHeight-2*beamFlange)/2)*(beamWeb)*(((beamHeight-2*beamFlange)/2)/2)+beamFlange*beamWidth*(beamHeight/2-beamFlange/2)
beamArea = (beamWidth*beamHeight)-((beamHeight - 2*beamFlange)*(beamWidth-beamWeb)); %inches^2
beamVolume = beamLength*beamArea; %inches^3
beamDensity = stDensity;
beamWeight = beamVolume*beamDensity; %lb
beamMOI = (1/12)*((beamWidth*beamHeight^3)-(beamWidth-beamWeb)*(beamHeight-(2*beamFlange))^3);
beamE = 30000000;

distributedWeight=(beamWeight*1.2)/beamLength
x = 80
shearForce=-distributedWeight*(x)^1 -(1000+50000*cableSF)/2 *(x-942)^0
shearStress = (shearForce * Q)/(beamMOI * b)

beamSag = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-1000*beamLength^3)/(48*beamE*beamMOI)
beamVerticalDeflection = (-5*(distributedWeight)*beamLength^4)/(384*beamE*beamMOI)+(-51000*beamLength^3)/(48*beamE*beamMOI)
beamSlope = (-1*distributedWeight*beamLength^3)/(24*beamE*beamMOI)+(-51000*beamLength^2)/(16*beamE*beamMOI)
