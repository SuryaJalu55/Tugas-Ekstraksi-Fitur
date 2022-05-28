function varargout = TugasCVfix(varargin)
% TUGASCVFIX MATLAB code for TugasCVfix.fig
%      TUGASCVFIX, by itself, creates a new TUGASCVFIX or raises the existing
%      singleton*.
%
%      H = TUGASCVFIX returns the handle to a new TUGASCVFIX or the handle to
%      the existing singleton*.
%
%      TUGASCVFIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUGASCVFIX.M with the given input arguments.
%
%      TUGASCVFIX('Property','Value',...) creates a new TUGASCVFIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TugasCVfix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TugasCVfix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TugasCVfix

% Last Modified by GUIDE v2.5 28-May-2022 17:52:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TugasCVfix_OpeningFcn, ...
                   'gui_OutputFcn',  @TugasCVfix_OutputFcn, ...
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


% --- Executes just before TugasCVfix is made visible.
function TugasCVfix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TugasCVfix (see VARARGIN)
global p
p.Mydata = [];
% Choose default command line output for TugasCVfix
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TugasCVfix wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TugasCVfix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile ('*.jpg');
im=imread ([PathName,FileName]);
handles.im = im;
guidata(hObject,handles);
axes(handles.axes1);
imshow(im);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%proses merubah gambar rgb menjadi grayscale
    image = handles.im;
    gray = rgb2gray(image);
    guidata(hObject,handles);
    axes(handles.axes2);
    imshow(gray);
    axes(handles.axes3);
    imhist(gray);
    
    %proses merubah gambar grayscale menjadi biner
    biner = im2bw(gray, graythresh(gray));
    n_biner = imcomplement(biner);
    axes(handles.axes4);
    imshow(n_biner);
    
    %menghitung luas & parimeter
    bw = imfill(biner,'holes');
    stats = regionprops(bw,'All');
    area = cat(1, stats.Area);
    perimeter = cat(1, stats.Perimeter);
    
    
    set(handles.edit1, 'String',num2str(area));
    set(handles.edit2, 'String',num2str(perimeter));
    
    
    handles.a = num2str(area);
    handles.p = num2str(perimeter);
    guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p
    area = handles.a;
    perimeter = handles.p;
    p.Mydata = [p.Mydata;[{area} {perimeter}]];
    set(handles.uitable1, 'Data', p.Mydata);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global p
    if isempty(p.Mydata)== false
           x1Range = 'B2';
           [baseFileName,folder]=uiputfile('&.xlsx');
           fullFileName = fullfile(folder,baseFileName);
           xlswrite(fullFileName,p.Mydata, x1Range);
    else
        return
    end



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
