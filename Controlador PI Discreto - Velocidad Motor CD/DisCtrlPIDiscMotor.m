%% Controlador PI Discreto Motor CD

clc
clear all
load('IdentMotorCD.mat')

Mp = 0.1; % Máximo sobre impulso
ts = 1; % Tiempo de asentamiento
Ts = 0.1; % Tiempo de muestreo

z = 1/sqrt(((pi^2)/((log(Mp))^2))+1);
wn = 3/(z*ts); % Criterio de error del 5%
num = wn^2;
den = [1 2*z*wn wn^2];
sys = tf(num,den)

wnz = wn*Ts;
wdz = wnz*sqrt(1-z^2);
a1 = 2*exp(-z*wnz)*cos(wdz);
a2 = exp(-2*z*wnz);
b1 = 1-exp(-z*wnz)*cos(wdz)-(((z*exp(-z*wnz))/sqrt(1-z^2))*sin(wdz));
b2 = exp(-2*z*wnz)-exp(-z*wnz)*cos(wdz)+(((z*exp(-z*wnz))/sqrt(1-z^2))*sin(wdz));
numd = [b1 b2];
dend = [1 -a1 a2];
sysd = tf(numd,dend,Ts)

az = ModMotor.Numerator(2);
bz = abs(ModMotor.Denominator(2));
Kp = (bz-a2)/az
Ki = (1+bz-(Kp*az)-a1)/az

Ie = 0;
e = 0;
ref = 8;

a = arduino('COM3','UNO','Libraries','rotaryEncoder');
configurePin(a,'D11','DigitalOutput');
configurePin(a,'D10','DigitalOutput');
configurePin(a,'D9','PWM');
encoder = rotaryEncoder(a,'D2','D3',12);
clear u Velrad

% Simulación del controlador
for i = 1:100
    rpm(i) = readSpeed(encoder)/64;
    Velrad(i) = (pi/30)*rpm(i);
    e = ref-Velrad(i);
    refs(i) = ref;
    u(i) = Kp*e+Ki*Ie;
    if u(i)>2
        u(i) = 2;
    end
    if u(i)<0
        u(i) = 0;
    end
    if i>50
        ref = 9;
    end
    writeDigitalPin(a,'D11',1);
    writeDigitalPin(a,'D10',0);
    writePWMVoltage(a,'D9',u(i));
    Ie = e+Ie;
end
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D10',0);
writePWMVoltage(a,'D9',0);