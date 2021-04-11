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
TorsionalShearStress = (cableTension* cableSF * (minDrumOD/2))/J

beamLength = 80*12; %inches
stDensity = 0.284; %lb/in^3
alDensity = 0098; %lb/in^3

beamArea = (insert_area); %inches^2
beamVolume = beamLength*beamArea; %inches^3
beamWeight = beamVolume*beamDensity; %lb

A=?
V=80*12*A
W = V*.284
Wo=W/80
x=?
V=-Wo(x)^1 -(2000+100000*cableSF)/2 *(x-78.5)^0