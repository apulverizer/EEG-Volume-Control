function varargout = emgMain(varargin)
% EMGMAIN M-file for emgMain.fig
%      EMGMAIN, by itself, creates a new EMGMAIN or raises the existing
%      singleton*.
%
%      H = EMGMAIN returns the handle to a new EMGMAIN or the handle to
%      the existing singleton*.
%
%      EMGMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMGMAIN.M with the given input arguments.
%
%      EMGMAIN('Property','Value',...) creates a new EMGMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before emgMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to emgMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emgMain

% Last Modified by GUIDE v2.5 16-Jan-2012 22:09:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @emgMain_OpeningFcn, ...
                   'gui_OutputFcn',  @emgMain_OutputFcn, ...
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


% --- Executes just before emgMain is made visible.
function emgMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to emgMain (see VARARGIN)

% Choose default command line output for emgMain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes emgMain wait for user response (see UIRESUME)
% uiwait(handles.figMain);

initGlobals();


% --- Outputs from this function are returned to the command line.
function varargout = emgMain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtDLLPath_Callback(hObject, eventdata, handles)
% hObject    handle to txtDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtDLLPath as text
%        str2double(get(hObject,'String')) returns contents of txtDLLPath as a double


% --- Executes during object creation, after setting all properties.
function txtDLLPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtConfigPath_Callback(hObject, eventdata, handles)
% hObject    handle to txtConfigPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtConfigPath as text
%        str2double(get(hObject,'String')) returns contents of txtConfigPath as a double


% --- Executes during object creation, after setting all properties.
function txtConfigPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtConfigPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDLLPath.
function btnDLLPath_Callback(hObject, eventdata, handles)
% hObject    handle to btnDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get and Set the DLL Path name
[FileName,PathName] = uigetfile('*.dll','Select BioRadio DLL');
set(handles.txtDLLPath,'String',PathName);

% --- Executes on button press in btnConfigPath.
function btnConfigPath_Callback(hObject, eventdata, handles)
% hObject    handle to btnConfigPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('*.ini','Select BioRadio Config File');
set(handles.txtConfigPath,'String',strcat(PathName,FileName));

% --- Executes on selection change in cboPortName.
function cboPortName_Callback(hObject, eventdata, handles)
% hObject    handle to cboPortName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function cboPortName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cboPortName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnConnect.
function btnConnect_Callback(hObject, eventdata, handles)
% hObject    handle to btnConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bioRadioHandle isCollecting;

buttonString = get(handles.btnConnect,'String');

if( strcmp(buttonString,'Connect') )
        
    % Get Configuration info
    dllPath = get(handles.txtDLLPath,'String');
    configPath = get(handles.txtConfigPath,'String');
    portNames = get(handles.cboPortName,'String');
    portSel = get(handles.cboPortName,'Value');
    portName = portNames{portSel};

    % Change the Button
    set(handles.btnConnect,'String', 'Connecting');
    set(handles.btnConnect,'Enable','off');

    pause(0.1);

    % Connect to the Radio
    bioRadioHandle = connectBioRadio(dllPath,configPath,portName);

    % Change the Button
    set(handles.btnConnect,'String', 'Disconnect');
    set(handles.btnConnect,'Enable','on');
    pause(0.1);

    % Set the collecting flag
    isCollecting = 1;

    % Setup the intial collectio interval
    collectionInterval = str2double(get(handles.txtCollectionInt,'String'));
    rawWindow = zeros( 2,collectionInterval);
    filterWindow = zeros( 2,collectionInterval);
    fftWindow = zeros( 2,collectionInterval);
    
    % Channel Numbers 
    channelNumbers = [1 2];    
    
    % Axes handles
    rawAxes     = [handles.rawChannel1 handles.rawChannel2];
    filterAxes  = [handles.filteredChannel1 handles.filteredChannel2];
    fftAxes     = [handles.fftChannel1 handles.fftChannel2];
    
    while( isCollecting == 1 )

        % Get the current collection interval size
        windowSize = str2double(get(handles.txtCollectionInt,'String'));
        
        % Get the threshold values
        leftThreshold = str2double(get(handles.txtLeftThreshold,'String'));
        rightThreshold = str2double(get(handles.txtRightThreshold,'String'));
         
        [rawWindow filterWindow fftWindow] = perform( rawWindow, filterWindow, fftWindow, windowSize);
         
        plotData(rawWindow, filterWindow, fftWindow, rawAxes, filterAxes, fftAxes, channelNumbers);
         
        executeCommand(fftWindow,leftThreshold,rightThreshold);
         
        % Wait for 1 ms
        pause(.080);
    end
else
    
    % Change the Button
    set(handles.btnConnect,'String', 'Disconnecting');
    set(handles.btnConnect,'Enable','off');
    pause(0.1);
    
    disconnectBioRadio(bioRadioHandle);
    
    isCollecting = 0;
     
    % Flag that radio is disconnected
    bioRadioHandle = -1;
    
    % Change the Button
    set(handles.btnConnect,'String', 'Connect');
    set(handles.btnConnect,'Enable','on');
    pause(0.1);
    
end

% --- Executes when user attempts to close figMain.
function figMain_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

global bioRadioHandle;
global isCollecting;

isCollecting = 0;

if( bioRadioHandle ~= -1 )
    disconnectBioRadio(bioRadioHandle);
end



function txtCollectionInt_Callback(hObject, eventdata, handles)
% hObject    handle to txtCollectionInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCollectionInt as text
%        str2double(get(hObject,'String')) returns contents of txtCollectionInt as a double


% --- Executes during object creation, after setting all properties.
function txtCollectionInt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCollectionInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnFiltdemo.
function btnFiltdemo_Callback(hObject, eventdata, handles)
% hObject    handle to btnFiltdemo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filterdesign();


% --- Executes on button press in btnSetFilterCoeff.
function btnSetFilterCoeff_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetFilterCoeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtLeftThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to txtLeftThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtLeftThreshold as text
%        str2double(get(hObject,'String')) returns contents of txtLeftThreshold as a double


% --- Executes during object creation, after setting all properties.
function txtLeftThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtLeftThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRightThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to txtRightThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRightThreshold as text
%        str2double(get(hObject,'String')) returns contents of txtRightThreshold as a double


% --- Executes during object creation, after setting all properties.
function txtRightThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRightThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
