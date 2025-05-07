function varargout = gui_comandos(varargin)
% GUI_COMANDOS MATLAB code for gui_comandos.fig
%      GUI_COMANDOS, by itself, creates a new GUI_COMANDOS or raises the existing
%      singleton*.
%
%      H = GUI_COMANDOS returns the handle to a new GUI_COMANDOS or the handle to
%      the existing singleton*.
%
%      GUI_COMANDOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COMANDOS.M with the given input arguments.
%
%      GUI_COMANDOS('Property','Value',...) creates a new GUI_COMANDOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_comandos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_comandos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_comandos

% Last Modified by GUIDE v2.5 09-Dec-2017 11:02:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_comandos_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_comandos_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before gui_comandos is made visible.
function gui_comandos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_comandos (see VARARGIN)

% Choose default command line output for gui_comandos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_comandos wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_comandos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Salir.
close;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Grabar voz de usuario.
voz=audiorecorder(44100,16,1);
recordblocking(voz,2);
yy=getaudiodata(voz);
audiowrite('voz.wav',yy,44100);

set(handles.axes1);
axes(handles.axes1);
plot(yy);
grid on;
xlabel('Tiempo de muestreo');
ylabel('Amplitud de la frecuencia');
title('Grabación hecha');

% Reproducir voz de usuario.
[voz,Fs]=audioread('voz.wav');
sound(voz,Fs);

% Reconocer voz de usuario.
[arriba,Fs]=audioread('arriba.wav');
[abajo,Fs]=audioread('abajo.wav');
[izquierda,Fs]=audioread('izquierda.wav');
[derecha,Fs]=audioread('derecha.wav');

arriba=abs(fft(arriba));
abajo=abs(fft(abajo));
izquierda=abs(fft(izquierda));
derecha=abs(fft(derecha));

arriba=(arriba-min(arriba))/(max(arriba)-min(arriba));
abajo=(abajo-min(abajo))/(max(abajo)-min(abajo));
izquierda=(izquierda-min(izquierda))/(max(izquierda)-min(izquierda));
derecha=(derecha-min(derecha))/(max(derecha)-min(derecha));

[v,Fs]=audioread('voz.wav');
V=abs(fft(v));
V=(V-min(V))/(max(V)-min(V));

error(1)=mean(abs(arriba-V));
error(2)=mean(abs(abajo-V));
error(3)=mean(abs(izquierda-V));
error(4)=mean(abs(derecha-V));

error_min=min(error);

if (error_min==error(1))
	set(handles.text1,'String','Arriba');
end
if (error_min==error(2))
	set(handles.text1,'String','Abajo');
end
if (error_min==error(3))
	set(handles.text1,'String','Izquierda');
end
if (error_min==error(4))
	set(handles.text1,'String','Derecha');
end
