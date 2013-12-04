function varargout = EEGVolumeControl(varargin)
% EEGVOLUMECONTROL MATLAB code for EEGVolumeControl.fig
%      EEGVOLUMECONTROL, by itself, creates a new EEGVOLUMECONTROL or raises the existing
%      singleton*.
%
%      H = EEGVOLUMECONTROL returns the handle to a new EEGVOLUMECONTROL or the handle to
%      the existing singleton*.
%
%      EEGVOLUMECONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEGVOLUMECONTROL.M with the given input arguments.
%
%      EEGVOLUMECONTROL('Property','Value',...) creates a new EEGVOLUMECONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EEGVolumeControl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EEGVolumeControl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EEGVolumeControl

% Last Modified by GUIDE v2.5 04-Dec-2013 11:40:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEGVolumeControl_OpeningFcn, ...
                   'gui_OutputFcn',  @EEGVolumeControl_OutputFcn, ...
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


% --- Executes just before EEGVolumeControl is made visible.
function EEGVolumeControl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EEGVolumeControl (see VARARGIN)

% Choose default command line output for EEGVolumeControl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
addpath(genpath('../Data Collection'));
addpath(genpath('../libsvm-3.17'));
addpath(genpath('../RBFN'));
addpath(genpath('../TestData'));
addpath(genpath('../Project'));
addpath(genpath('../PSO'));
addpath(genpath('../VolumeControl'));
addpath(genpath('../BioRadioMatlab'));
load('realtime.mat');

% initialize global variables
global bioRadioHandle isCollecting;
bioRadioHandle = -1;
isCollecting = 0;
global isEnabled;
isEnabled=0;

% UIWAIT makes EEGVolumeControl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EEGVolumeControl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
global isEnabled;
global bioRadioHandle;
global isCollecting;
if(isEnabled==0)
    isEnabled=1;
    bioRadioHandle = connectBioRadio(dllPath,configPath,portName);
    % start collecting
    isCollecting = 1;

    Volume=.5;
    SetWindowsVolume(Volume);
    rawWindow = zeros( 4,collectionInterval);
    while (isCollecting ==1 && Volume < 1 && Volume >0)
        % wait one second
        pause(1);
        % get new values
        rawWindow = perform2(rawWindow,collectionInterval);
        % classify 
        if(2==classifyVolume(rawWindow, modelRBFN))
            Volume= Volume-.05;
        else
            Volume = Volume+.05;
        end
        % set  volume
        if(Volume >= 0 && Volume <=1)
            SetWindowsVolume(Volume);
            set(handles.slider1,'Value',Volume);
        end
    end;
else
    isEnabled=0;
    % clean up 
    isCollecting = 0;
    if(bioRadioHandle ~=1)
        disconnectBioRadio(bioRadioHandle);
    end
end;
    


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function configFileTXT_Callback(hObject, eventdata, handles)
% hObject    handle to configFileTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of configFileTXT as text
%        str2double(get(hObject,'String')) returns contents of configFileTXT as a double


% --- Executes during object creation, after setting all properties.
function configFileTXT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to configFileTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Config_BTN.
function Config_BTN_Callback(hObject, eventdata, handles)
% hObject    handle to Config_BTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.ini','Select BioRadio Configfile');
set(handles.configFileTXT,'String',PathName);



function DLLTXT_Callback(hObject, eventdata, handles)
% hObject    handle to DLLTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DLLTXT as text
%        str2double(get(hObject,'String')) returns contents of DLLTXT as a double


% --- Executes during object creation, after setting all properties.
function DLLTXT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DLLTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DLL_BTN.
function DLL_BTN_Callback(hObject, eventdata, handles)
% hObject    handle to DLL_BTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.dll','Select BioRadio DLL');
set(handles.DLLTXT,'String',PathName);