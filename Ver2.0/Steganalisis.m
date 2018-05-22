function varargout = Steganalisis(varargin)
% STEGANALISIS MATLAB code for Steganalisis.fig
%      STEGANALISIS, by itself, creates a new STEGANALISIS or raises the existing
%      singleton*.
%
%      H = STEGANALISIS returns the handle to a new STEGANALISIS or the handle to
%      the existing singleton*.
%
%      STEGANALISIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANALISIS.M with the given input arguments.
%
%      STEGANALISIS('Property','Value',...) creates a new STEGANALISIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Steganalisis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Steganalisis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Steganalisis

% Last Modified by GUIDE v2.5 16-May-2018 17:48:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Steganalisis_OpeningFcn, ...
                   'gui_OutputFcn',  @Steganalisis_OutputFcn, ...
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


% --- Executes just before Steganalisis is made visible.
function Steganalisis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Steganalisis (see VARARGIN)

% Choose default command line output for Steganalisis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Steganalisis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Steganalisis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_open.
function btn_open_Callback(hObject, eventdata, handles)
% hObject    handle to btn_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
handles.output = hObject;
[fn,pn] = uigetfile({'*.jpg;*.png'},'Select Image File');
I = imread([pn,fn]);
axes(handles.ax_img);
imshow(I,[]);
guidata(hObject, handles);


% --- Executes on button press in btn_deteksi.
function btn_deteksi_Callback(hObject, eventdata, handles)
% hObject    handle to btn_deteksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
%     Pisahin gambar per channel
    Itred = I(:,:,1);
    Itgreen = I(:,:,2);
    Itblue = I(:,:,3);
    
%     Model Steganalisis LSB Matching
    set_red = [analisistekstur(graylevel_comat(Itred)) hcfcom(Itred)];
    set_green = [analisistekstur(graylevel_comat(Itgreen)) hcfcom(Itgreen)];
    set_blue = [analisistekstur(graylevel_comat(Itblue)) hcfcom(Itblue)];
    
%     Output ke GUI
    set(handles.txt_contrast_red, 'String', num2str(set_red(1)));
    set(handles.txt_correlation_red, 'String', num2str(set_red(2)));
    set(handles.txt_energy_red, 'String', num2str(set_red(3)));
    set(handles.txt_homogen_red, 'String', num2str(set_red(4)));
    set(handles.txt_hcfcom_red, 'String', num2str(set_red(5)));
    set(handles.txt_contrast_green, 'String', num2str(set_green(1)));
    set(handles.txt_correlation_green, 'String', num2str(set_green(2)));
    set(handles.txt_energy_green, 'String', num2str(set_green(3)));
    set(handles.txt_homogen_green, 'String', num2str(set_green(4)));
    set(handles.txt_hcfcom_green, 'String', num2str(set_green(5)));
    set(handles.txt_contrast_blue, 'String', num2str(set_blue(1)));
    set(handles.txt_correlation_blue, 'String', num2str(set_blue(2)));
    set(handles.txt_energy_blue, 'String', num2str(set_blue(3)));
    set(handles.txt_homogen_blue, 'String', num2str(set_blue(4)));
    set(handles.txt_hcfcom_blue, 'String', num2str(set_blue(5)));
    
    set_channel = [gabunginfitur(set_red) gabunginfitur(set_green) gabunginfitur(set_blue)];

%     Pendeteksian LSB Matching
    pred = 9;
    out_red = mf_channel(set_channel(1));
    out_green = mf_channel(set_channel(2));
    out_blue = mf_channel(set_channel(3));
    out_all = [out_red out_green out_blue];
    out_value = out_all(:,[1 3 5]);
    out_nilai = out_all(:,[2 4 6]);
%     kemungkinan rule
    rule_in_value = [];
    rule_in_nilai = [];
    for r=1:2
        for g=1:2
            for b=1:2
                rule_in_value = [rule_in_value; out_value(r,1) out_value(g,2) out_value(b,3)];
                rule_in_nilai = [rule_in_nilai; out_nilai(r,1) out_nilai(g,2) out_nilai(b,3)];
            end
        end
    end
%     rule channel
%     conjuction (and), untuk tiap channel
    rule_out_value = [];
    for i=1:size(rule_in_value,1)
        rule_out_value = [rule_out_value; rule_cn(cell2mat(rule_in_value(i,:)))];
    end
    rule_out_nilai = min(cell2mat(rule_in_nilai),[],2);
%     disjunction (or), untuk tiap output dari rule
    value = ['stego'; 'cover'];
    maxstego = 0; maxcover = 0;
    for i=1:size(rule_out_value,1)
        if strcmp(rule_out_value(i,:), value(1,:))
            if rule_out_nilai(i,1) > maxstego
                maxstego = rule_out_nilai(i,1);
            end
        end
        if strcmp(rule_out_value(i,:), value(2,:))
            if rule_out_nilai(i,1) > maxcover
                maxcover = rule_out_nilai(i,1);
            end
        end
    end
    nilai = [maxstego; maxcover];
%     model sugeno
    y = 0;
    for i=1:2
        if strcmp(value(i,:),'cover')
            y = y + (nilai(i)*0);
        else
            y = y + (nilai(i)*1);
        end
    end
    y = y/sum(nilai);
    if y >= 0.7 %thresholding
        pred = 1;
        set(handles.txt_predicted, 'String', 'Stego-image');
    else
        pred = 2;
        set(handles.txt_predicted, 'String', 'Cover-image');
    end
    
%     Output ke GUI
    x = get(handles.actual_class,'Value');
    switch x
    case 1
        set(handles.txt_actual, 'String', 'Stego-image');
        if pred == 1
            set(handles.txt_conf, 'String', 'True Positive');
        else
            set(handles.txt_conf, 'String', 'False Negative');
        end
    case 2
        set(handles.txt_actual, 'String', 'Cover-image');
        if pred == 1
            set(handles.txt_conf, 'String', 'False Positive');
        else
            set(handles.txt_conf, 'String', 'True Negative');
        end
    end
            
            

% --- Executes on button press in btn_reset.
function btn_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
axes(handles.ax_img);
cla;
string = '';
set(handles.txt_contrast_red, 'String', string);
set(handles.txt_correlation_red, 'String', string);
set(handles.txt_energy_red, 'String', string);
set(handles.txt_homogen_red, 'String', string);
set(handles.txt_hcfcom_red, 'String', string);
set(handles.txt_contrast_green, 'String', string);
set(handles.txt_correlation_green, 'String', string);
set(handles.txt_energy_green, 'String', string);
set(handles.txt_homogen_green, 'String', string);
set(handles.txt_hcfcom_green, 'String', string);
set(handles.txt_contrast_blue, 'String', string);
set(handles.txt_correlation_blue, 'String', string);
set(handles.txt_energy_blue, 'String', string);
set(handles.txt_homogen_blue, 'String', string);
set(handles.txt_hcfcom_blue, 'String', string);
set(handles.txt_actual, 'String', string);
set(handles.txt_predicted, 'String', string);
set(handles.txt_conf, 'String', string);

% --- Executes on selection change in actual_class.
function actual_class_Callback(hObject, eventdata, handles)
% hObject    handle to actual_class (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns actual_class contents as cell array
%        contents{get(hObject,'Value')} returns selected item from actual_class


% --- Executes during object creation, after setting all properties.
function actual_class_CreateFcn(hObject, eventdata, handles)
% hObject    handle to actual_class (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
