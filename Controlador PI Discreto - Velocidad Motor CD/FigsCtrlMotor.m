clc
clear

load('DatosContrlMotor')

figure(1)
subplot(211)
stairs(Velrad)
hold on
subplot(211)
stairs(refs)
title('Se�al del controlador')
subplot(212)
stairs(u)
title('Se�al de control')