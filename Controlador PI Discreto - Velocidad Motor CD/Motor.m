clc
clear all

%% Identificación Motor CD

Nm = 200; % Número de muestras
[u,freqs] = idinput(Nm,'prbs',[],[-1 1]); % PRBS sin tiempo estable
Ts = 0.1;

a = arduino('COM3','UNO','Libraries','rotaryEncoder');
configurePin(a,'D11','DigitalOutput');
configurePin(a,'D10','DigitalOutput');
configurePin(a,'D9','PWM');
encoder = rotaryEncoder(a,'D2','D3',12);
% count = readCount(encoder,'reset',true);

for i = 1:length(u)
    tic
%    count  = readCount(encoder);
%    pos(i) = (count/3072)*360;
%    posRad(i) = degtorad(pos(i));
    rpm(i) = readSpeed(encoder)/64;
    Velrad(i) = (pi/30)*rpm(i);
    if u(i)>0
        writeDigitalPin(a,'D11',1);
        writeDigitalPin(a,'D10',0);
        writePWMVoltage(a,'D9',u(i));
    end
    if u(i)<0
        ua = abs(u(i));
        writeDigitalPin(a,'D11',0);
        writeDigitalPin(a,'D10',1);
        writePWMVoltage(a,'D9',ua);
    end
    toc
end
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D10',0);
writePWMVoltage(a,'D9',0);

% datosP = iddata(posRad',u,Ts);
datosV = iddata(Velrad',u,Ts);
% numV1 = VelModel1.numerator;
% denV1 = VelModel1.denominator;
% sysV1 = tf(numV1,denV1);
% sysV1d = c2d(sysV1,Ts);

%% Sintonización PI

% Mp = 0.1;
% ts = 0.5;
% z = 1/sqrt(((pi^2)/((log(Mp))^2))+1);
% wn = 3/(z*ts);
% wnz = wn*Ts;
% wdz = wnz*sqrt(1-z^2);
% A1 = 2*exp(-z*wnz)*cos(wdz);
% A2 = exp(-2*z*wnz);
% B1 = 1-exp(-z*wnz)*cos(wdz)-(((z*exp(-z*wnz))/sqrt(1-z^2))*sin(wdz));
% B2 = exp(-2*z*wnz)-exp(-z*wnz)*cos(wdz)+(((z*exp(-z*wnz))/sqrt(1-z^2))*sin(wdz));
%
% az = ModelVdiscreto.Numerator(2);
% bz = abs(ModelVdiscreto.Denominator(2));
% Kp = (bz-A2)/az
% Ki = (bz+1-az*Kp-A1)/az
% 
% save('Identificacion.mat')