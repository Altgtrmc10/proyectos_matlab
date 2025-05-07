function varargout = game(varargin)
% GAME M-file for game.fig
%      GAME, by itself, creates a new GAME or raises the existing
%      singleton*.
%
%      H = GAME returns the handle to a new GAME or the handle to
%      the existing singleton*.
%
%      GAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAME.M with the given input arguments.
%
%      GAME('Property','Value',...) creates a new GAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help game

% Last Modified by GUIDE v2.5 11-Dec-2017 17:51:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @game_OpeningFcn, ...
                   'gui_OutputFcn',  @game_OutputFcn, ...
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

% --- Executes just before game is made visible.
function game_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to game (see VARARGIN)

% Choose default command line output for game
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes game wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global t;t=0.21;
global POINTS;POINTS=0;
set(handles.edit1,'String',['PUNTOS: ',num2str(POINTS)]);
SizeX=100;SizeY=100;
Loc=[50 49;50 50;50 51;50 52];
LocX=Loc(:,2);LocY=Loc(:,1);
TargetX=45;TargetY=50;
global Direction;Direction=1;
% [1=left;2=up;3=right;4=down];
% Generation of Target
pause on;
if ispc
    [y,Fs]=audioread('Windows Ding.wav');
end
ScreenR=zeros(SizeX,SizeY);
ScreenG=80*ones(SizeX,SizeY);
ScreenB=zeros(SizeX,SizeY);
while(1)
    len=length(LocX);
    if sum([TargetX TargetY]==[LocY(1) LocX(1)])==2
        POINTS=POINTS+1;
        if ispc
            audioplayer(y,Fs);
        end
        set(handles.edit1,'String',['PUNTOS: ',num2str(POINTS)]);
        LocX(2:len+1)=LocX(1:len);
        LocY(2:len+1)=LocY(1:len);
        while(1)
            TargetX=randi(SizeX,1);
            if sum(LocX==TargetX)==0
                break;
            end
        end
        while(1)
            TargetY=randi(SizeY,1);
            if sum(LocY==TargetY)==0
                break;
            end
        end
    else    
        LocX(2:len)=LocX(1:len-1);
        LocY(2:len)=LocY(1:len-1);
    end
    if Direction==1 
        if LocX(1)~=1
            LocX(1)=LocX(1)-1;
        elseif LocX(1)==1
            LocX(1)=SizeX;
        end    
    elseif Direction==2
        if LocY(1)~=1
            LocY(1)=LocY(1)-1;
        elseif LocY(1)==1
            LocY(1)=SizeY;
        end    
    elseif Direction==3 
        if LocX(1)~=SizeX
            LocX(1)=LocX(1)+1;
        elseif LocX(1)==SizeX
            LocX(1)=1;
        end    
    elseif Direction==4 
        if LocY(1)~=SizeY
            LocY(1)=LocY(1)+1;
        elseif LocY(1)==SizeY
            LocY(1)=1;
        end
    end
    flag=0;
    for h=2:length(LocX)
        if LocX(1)==LocX(h)&&LocY(1)==LocY(h)
            if ispc
                [y,Fs]=audioread('tada.wav');
            end
            errordlg('FIN DEL JUEGO');
            if ispc
                audioplayer(y,Fs);
            end
            flag=1;
            break;
        end
    end
    if flag==1
        break;
    end    
    ScreenRt=ScreenR;
    ScreenGt=ScreenG;
    ScreenBt=ScreenB;
    for n=1:length(LocX)
        ScreenRt(LocY(n),LocX(n))=255;
        ScreenGt(LocY(n),LocX(n))=255;
        ScreenBt(LocY(n),LocX(n))=0;
    end
    ScreenRt(TargetX,TargetY)=255;
    ScreenGt(TargetX,TargetY)=255;
    ScreenBt(TargetX,TargetY)=255;
    ScreenI=cat(3,ScreenRt,ScreenGt,ScreenBt);
    imshow(uint8(ScreenI));
    
    pause(t);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO) 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause on;
if strcmp(get(handles.pushbutton5,'String'),'PAUSA')
   pause;
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t;
if t>=0.06
    t=t-0.05;
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t;
t=t+0.05;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Direction;

% Grabar voz de usuario.
voz=audiorecorder(44100,16,1);
recordblocking(voz,2);
yy=getaudiodata(voz);
audiowrite('voz.wav',yy,44100);

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

if (error_min==error(1)) && Direction~=4 % Arriba
    Direction=2;
	set(handles.text5,'String','Arriba');
end
if (error_min==error(2)) && Direction~=2 % Abajo
    Direction=4;
	set(handles.text5,'String','Abajo');
end
if (error_min==error(3)) && Direction~=3 % Izquierda
    Direction=1;
	set(handles.text5,'String','Izquierda');
end
if (error_min==error(4)) && Direction~=1 % Derecha
    Direction=3;
	set(handles.text5,'String','Derecha');
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
