clc
clear

load('DatosContrlMotor')

figure(1)
subplot(211)
stairs(Velrad)
hold on
subplot(211)
stairs(refs)
title('Señal del controlador')
subplot(212)
stairs(u)
title('Señal de control')