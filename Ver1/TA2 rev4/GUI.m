function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 02-Apr-2018 23:29:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnPayload.
function btnPayload_Callback(hObject, eventdata, handles)
% hObject    handle to btnPayload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('prediksi_payload.mat');
axes(handles.ax_roc);
cla;
pause(0.2);
string = '';
set(handles.txtHasil, 'String', string);
axes(handles.ax_roc);
global parameter;
parameter = []; %auc, tp, fp, tn, fn 
for ndb=1:5
    [FPR,TPR,T,AUC] = perfcurve(eval(strcat('pred',num2str(ndb),'(:,2)')), eval(strcat('pred',num2str(ndb),'(:,1)')), 1);
    mxx = 0;
    for id_t = 1:size(T,1)
        b_pred = (eval(strcat('pred',num2str(ndb),'(:,1)'))>=T(id_t));
        xTP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        xFP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xTN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xFN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        if (xTP+xTN)>mxx
            th = T(id_t);
            mxx = xTP+xTN;
            TP = xTP;
            TN = xTN;
            FP = xFP;
            FN = xFN;
        end
    end
    parameter = [parameter; AUC, TP, FP, TN, FN];
    hold on;
        if ndb==1
            plot(FPR,TPR,'k','LineWidth',2);
        elseif ndb==2
            plot(FPR,TPR,'m','LineWidth',2);
        elseif ndb==3
            plot(FPR,TPR,'b','LineWidth',2);
        elseif ndb==4
            plot(FPR,TPR,'g','LineWidth',2);
        elseif ndb==5
            plot(FPR,TPR,'r','LineWidth',2);
        end
    hold off;
end
c = linspace(0,1);
hold on;
plot(c,c,'--');
hold off;
legend('Payload 15%','Payload 25%','Payload 50%','Payload 75%','Payload 100%');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
complete = sprintf('Payload: 15%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 25%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 50%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 75%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 100%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n', parameter(1,1), 100*parameter(1,2)/(parameter(1,2)+parameter(1,5)), 100*parameter(1,3)/(parameter(1,3)+parameter(1,4)), parameter(2,1), 100*parameter(2,2)/(parameter(2,2)+parameter(2,5)), 100*parameter(2,3)/(parameter(2,3)+parameter(2,4)), parameter(3,1), 100*parameter(3,2)/(parameter(3,2)+parameter(3,5)), 100*parameter(3,3)/(parameter(3,3)+parameter(3,4)), parameter(4,1), 100*parameter(4,2)/(parameter(4,2)+parameter(4,5)), 100*parameter(4,3)/(parameter(4,3)+parameter(4,4)), parameter(5,1), 100*parameter(5,2)/(parameter(5,2)+parameter(5,5)), 100*parameter(5,3)/(parameter(5,3)+parameter(5,4)));
set(handles.txtHasil,'string',complete);

% --- Executes on button press in btnIncidental.
function btnIncidental_Callback(hObject, eventdata, handles)
% hObject    handle to btnIncidental (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('prediksi_incidental.mat');
axes(handles.ax_roc);
cla;
pause(0.2);
string = '';
set(handles.txtHasil, 'String', string);
axes(handles.ax_roc);
global parameter;
parameter = []; %auc, tp, fp, tn, fn 
for ndb=1:5
    [FPR,TPR,T,AUC] = perfcurve(eval(strcat('pred',num2str(ndb),'(:,2)')), eval(strcat('pred',num2str(ndb),'(:,1)')), 1);
    mxx = 0;
    for id_t = 1:size(T,1)
        b_pred = (eval(strcat('pred',num2str(ndb),'(:,1)'))>=T(id_t));
        xTP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        xFP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xTN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xFN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        if (xTP+xTN)>mxx
            th = T(id_t);
            mxx = xTP+xTN;
            TP = xTP;
            TN = xTN;
            FP = xFP;
            FN = xFN;
        end
    end
    parameter = [parameter; AUC, TP, FP, TN, FN];
    hold on;
        if ndb==1
            plot(FPR,TPR,'k','LineWidth',2);
        elseif ndb==2
            plot(FPR,TPR,'m','LineWidth',2);
        elseif ndb==3
            plot(FPR,TPR,'b','LineWidth',2);
        elseif ndb==4
            plot(FPR,TPR,'g','LineWidth',2);
        elseif ndb==5
            plot(FPR,TPR,'r','LineWidth',2);
        end
    hold off;
end
c = linspace(0,1);
hold on;
plot(c,c,'--');
hold off;
legend('Payload 15%','Payload 25%','Payload 50%','Payload 75%','Payload 100%');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
complete = sprintf('Payload: 15%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 25%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 50%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 75%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 100%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n', parameter(1,1), 100*parameter(1,2)/(parameter(1,2)+parameter(1,5)), 100*parameter(1,3)/(parameter(1,3)+parameter(1,4)), parameter(2,1), 100*parameter(2,2)/(parameter(2,2)+parameter(2,5)), 100*parameter(2,3)/(parameter(2,3)+parameter(2,4)), parameter(3,1), 100*parameter(3,2)/(parameter(3,2)+parameter(3,5)), 100*parameter(3,3)/(parameter(3,3)+parameter(3,4)), parameter(4,1), 100*parameter(4,2)/(parameter(4,2)+parameter(4,5)), 100*parameter(4,3)/(parameter(4,3)+parameter(4,4)), parameter(5,1), 100*parameter(5,2)/(parameter(5,2)+parameter(5,5)), 100*parameter(5,3)/(parameter(5,3)+parameter(5,4)));
set(handles.txtHasil,'string',complete);

% --- Executes on button press in btnIntentional.
function btnIntentional_Callback(hObject, eventdata, handles)
% hObject    handle to btnIntentional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('prediksi_intentional.mat');
axes(handles.ax_roc);
cla;
pause(0.2);
string = '';
set(handles.txtHasil, 'String', string);
axes(handles.ax_roc);
global parameter;
parameter = []; %auc, tp, fp, tn, fn 
for ndb=1:5
    [FPR,TPR,T,AUC] = perfcurve(eval(strcat('pred',num2str(ndb),'(:,2)')), eval(strcat('pred',num2str(ndb),'(:,1)')), 1);
    mxx = 0;
    for id_t = 1:size(T,1)
        b_pred = (eval(strcat('pred',num2str(ndb),'(:,1)'))>=T(id_t));
        xTP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        xFP = sum(b_pred == 1 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xTN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 0);
        xFN = sum(b_pred == 0 & eval(strcat('pred',num2str(ndb),'(:,2)')) == 1);
        if (xTP+xTN)>mxx
            th = T(id_t);
            mxx = xTP+xTN;
            TP = xTP;
            TN = xTN;
            FP = xFP;
            FN = xFN;
        end
    end
    parameter = [parameter; AUC, TP, FP, TN, FN];
    hold on;
        if ndb==1
            plot(FPR,TPR,'k','LineWidth',2);
        elseif ndb==2
            plot(FPR,TPR,'m','LineWidth',2);
        elseif ndb==3
            plot(FPR,TPR,'b','LineWidth',2);
        elseif ndb==4
            plot(FPR,TPR,'g','LineWidth',2);
        elseif ndb==5
            plot(FPR,TPR,'r','LineWidth',2);
        end
    hold off;
end
c = linspace(0,1);
hold on;
plot(c,c,'--');
hold off;
legend('Payload 15%','Payload 25%','Payload 50%','Payload 75%','Payload 100%');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
complete = sprintf('Payload: 15%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 25%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 50%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 75%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n\n\nPayload: 100%%\nArea Under the Curve\t: %f\nCorrectly Classified as Stego\t\t\t: %g%%\nWrongly Classified as Stego\t\t\t: %g%%\n', parameter(1,1), 100*parameter(1,2)/(parameter(1,2)+parameter(1,5)), 100*parameter(1,3)/(parameter(1,3)+parameter(1,4)), parameter(2,1), 100*parameter(2,2)/(parameter(2,2)+parameter(2,5)), 100*parameter(2,3)/(parameter(2,3)+parameter(2,4)), parameter(3,1), 100*parameter(3,2)/(parameter(3,2)+parameter(3,5)), 100*parameter(3,3)/(parameter(3,3)+parameter(3,4)), parameter(4,1), 100*parameter(4,2)/(parameter(4,2)+parameter(4,5)), 100*parameter(4,3)/(parameter(4,3)+parameter(4,4)), parameter(5,1), 100*parameter(5,2)/(parameter(5,2)+parameter(5,5)), 100*parameter(5,3)/(parameter(5,3)+parameter(5,4)));
set(handles.txtHasil,'string',complete);
