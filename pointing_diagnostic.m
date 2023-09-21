function varargout = pointing_diagnostic(varargin)
% POINTING_DIAGNOSTIC MATLAB code for pointing_diagnostic.fig
%      POINTING_DIAGNOSTIC by itself, creates a new POINTING_DIAGNOSTIC or raises the
%      existing singleton*.
%
%      H = POINTING_DIAGNOSTIC returns the handle to a new POINTING_DIAGNOSTIC or the handle to
%      the existing singleton*.
%
%      POINTING_DIAGNOSTIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINTING_DIAGNOSTIC.M with the given input arguments.
%
%      POINTING_DIAGNOSTIC('Property','Value',...) creates a new POINTING_DIAGNOSTIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pointing_diagnostic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pointing_diagnostic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pointing_diagnostic

% Last Modified by GUIDE v2.5 21-Jul-2023 09:44:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pointing_diagnostic_OpeningFcn, ...
                   'gui_OutputFcn',  @pointing_diagnostic_OutputFcn, ...
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

% --- Executes just before pointing_diagnostic is made visible.
function pointing_diagnostic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pointing_diagnostic (see VARARGIN)

% Choose default command line output for pointing_diagnostic
handles.output = 'Yes';

% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat

IconData=questIconData;
questIconMap(256,:) = get(handles.figure1, 'Color');
IconCMap=questIconMap;

Img=image(IconData, 'Parent', handles.image_axes);
set(handles.figure1, 'Colormap', IconCMap);

set(handles.image_axes, ...
    'Visible', 'off', ...
    'YDir'   , 'reverse'       , ...
    'XLim'   , get(Img,'XData'), ...
    'YLim'   , get(Img,'YData')  ...
    );

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes pointing_diagnostic wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = pointing_diagnostic_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Delete image_axes aqcuisition objects
imaqreset;

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vid = videoinput('gentl', 1, 'Mono8'); % Establish video object with grayscale readout
src = getselectedsource(vid); % Stream frames from the video input object
vid.FramesPerTrigger = inf; % Set FramesPerTrigger to keep aquiring frames indefinitely until stop is called
src.ExposureTime = str2double(get(handles.exposure_time,'string')) % Set stream's ExposureTime from GUI string exposure time
src.Gain = str2double(get(handles.gain,'string')) % Set stream's Gain from GUI string GainLevel

% Turn on triggering based on trigger radio button 
% Only compatible with certain camera types e.g. acA1920-40uc
if get(handles.trigger,'Value')
    triggerconfig(vid,'hardware','DeviceSpecific','DeviceSpecific'); % Allow for trigger configuration
    src.TriggerSelector = 'FrameStart'; % Trigger for the start of one fram acquisition
    src.TriggerSource = 'Line1'; % Cable pin to trigger on
    src.TriggerActivation = 'RisingEdge'; % Point of signal to trigger on
    src.TriggerMode = 'on';
    src.TriggerDelay = str2double(get(handles.trigger_delay,'string'))
end



start(vid); % Start acquiring frames from vid to buffer

counter = 1; % Start counter to keep track of frames
% Intial image acquisition for reference
img_0 = getsnapshot(vid); 
rp_0 = regionprops(true(size(img_0)),img_0,'WeightedCentroid');
centers_x0 = rp_0.WeightedCentroid(1);
centers_y0 = rp_0.WeightedCentroid(2);

set(handles.running,'Value',1) % Set feedback radio button to running
while 1
    % Closing sequence for stopping session
    if ~get(handles.running,'Value')
        stop(vid);
        imaqreset;
        % Save data if save is toggled
        if get(handles.save,'Value')
            date_time = fix(clock); % Acqurie date vector and cast it to an int array 
            % Separate date and time strings
            date = strcat(int2str(date_time(1)),int2str(date_time(2)),int2str(date_time(3)));
            time = strcat(int2str(date_time(4)),int2str(date_time(5)),int2str(date_time(6)));
            csvwrite(strcat('pointing_',date,'_',time,'.txt'),horzcat(centers_x.',centers_y.')); % Save 2 x count matrix as a csv according to the date_time
        end
        break;
    end
    
    img = getsnapshot(vid); % Acquire frame
    rp = regionprops(true(size(img)),img,'WeightedCentroid'); % Find weighted centroid of whole image through regionprops 
    % Calculate distance from initial center and append to vectors
    centers_x(counter) = rp.WeightedCentroid(1) - centers_x0; 
    centers_y(counter) = rp.WeightedCentroid(2) - centers_y0;
    
    axes(handles.image_axes); % Make image_axes from the figure the current axes for plotting
    imshow(img) % Plot grabbed image
    
    axes(handles.x_pointing_axes) % Make x_pointing_axes from figure the current axes for plotting
    plot(centers_x,'MarkerFaceColor',[0 0 1],'MarkerSize',6,'Marker','o','Color',[0 0 1]); % plot center_x time series
    
    axes(handles.y_pointing_axes) % Make x_pointing_axes from figure the current axes for plotting
    plot(centers_y,'MarkerFaceColor',[0 1 0],'MarkerSize',6,'Marker','o','Color',[0 1 0]); % plot center_y time series
    
    
    
    data = getdata(vid, vid.FramesAvailable); % Readout data from buffer
    pause(.1); % Pause for camera to read
    counter = counter + 1; % increment counter
    
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.running,'Value',0) % Running radio button to off
close(gcf); % Close current figure




function exposure_time_Callback(hObject, eventdata, handles)
% hObject    handle to exposure_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exposure_time as text
%        str2double(get(hObject,'String')) returns contents of exposure_time as a double


% --- Executes during object creation, after setting all properties.
function exposure_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exposure_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gain_Callback(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gain as text
%        str2double(get(hObject,'String')) returns contents of gain as a double


% --- Executes during object creation, after setting all properties.
function gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain date and time as integer array and write a file using it with
% contents of x and y pointing time series



% --- Executes on button press in running.
function running_Callback(hObject, eventdata, handles)
% hObject    handle to running (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of running


% --- Executes on button press in trigger.
function trigger_Callback(hObject, eventdata, handles)
% hObject    handle to trigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trigger



function trigger_delay_Callback(hObject, eventdata, handles)
% hObject    handle to trigger_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trigger_delay as text
%        str2double(get(hObject,'String')) returns contents of trigger_delay as a double


% --- Executes during object creation, after setting all properties.
function trigger_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trigger_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
