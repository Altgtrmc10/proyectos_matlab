clc
clear

disp('Ingrese 1 para "arriba".')
disp('Ingrese 2 para "abajo".')
disp('Ingrese 3 para "izquierda".')
disp('Ingrese 4 para "derecha".')

z=input('Seleccione la grabaci�n que desea hacer: ');
switch(z)

	case 1
	     	disp('Ingrese "arriba".')
		n=2;
		pause(n)
		y=audiorecorder(44100,16,1);
		disp('Inicia la grabaci�n; hable ahora.')
		recordblocking(y,2);
		disp('Ha finalizado la grabaci�n.')
	yy=getaudiodata(y);
	sound(yy,44100);
	audiowrite('arriba.wav',yy,44100);

	case 2
		disp('Ingrese "abajo".')
		n=2;
		pause(n)
		y=audiorecorder(44100,16,1);
		disp('Inicia la grabaci�n; hable ahora.')
		recordblocking(y,2);
		disp('Ha finalizado la grabaci�n.')
	yy=getaudiodata(y);
	sound(yy,44100);
	audiowrite('abajo.wav',yy,44100);

	case 3
		disp('Ingrese "izquierda".')
		n=2;
		pause(n)
		y=audiorecorder(44100,16,1);
		disp('Inicia la grabaci�n; hable ahora.')
		recordblocking(y,2);
		disp('Ha finalizado la grabaci�n.')
	yy=getaudiodata(y);
	sound(yy,44100);
	audiowrite('izquierda.wav',yy,44100);

	case 4
		disp('Ingrese "derecha".')
		n=2;
		pause(n)
		y=audiorecorder(44100,16,1);
		disp('Inicia la grabaci�n; hable ahora.')
		recordblocking(y,2);
		disp('Ha finalizado la grabaci�n.')
	yy=getaudiodata(y);
	sound(yy,44100);
	audiowrite('derecha.wav',yy,44100);

end