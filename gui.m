function varargout = gui(varargin)

    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @gui_OpeningFcn, ...
                       'gui_OutputFcn',  @gui_OutputFcn, ...
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
function gui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
function train_Callback(hObject, eventdata, handles)
    g_train();
function load_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('C:\Users\Pihu\Desktop\breast_cancr\result\mdb*', 'Select Test file');
    
    set (handles.filename, 'string', strcat (pathname, filename));
    set (handles.filename1, 'string', filename);
    set (handles.cluster, 'string', '4');
    filename = strcat('C:\Users\Pihu\Desktop\breast_cancr\all-mias\', filename);
    image = g_load (filename);
    imshow (image);
function enhance_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
    answer = inputdlg ('Enter sigma');
    ans = cell2mat (answer);
    set (handles.sigma, 'string', ans);
    ans = str2double (ans);
    image = g_enhance (I, ans);
    imshow (image);
function k_means_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
    answer = inputdlg ('Enter no. of clusters');
    ans = cell2mat (answer);
    set (handles.cluster, 'string', ans);
    ans = str2num (ans);
    lb = g_kmeans (I, ans, 1);
    imshow (lb, []);
function boundary_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
    k = get (handles.cluster, 'string');
    k = str2num (k);
    I = g_boundary (I, k, 1);
    imshow (I);
function detected_boundary_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
    filename1 = get (handles.filename1, 'string');
    filename = strcat('C:\Users\Pihu\Desktop\breast_cancr\all-mias\', filename1);
    image = g_load (filename);
    k = get (handles.cluster, 'string');
    k = str2num (k);
    I = g_boundary (I, k, 1);
    b = g_detected_boundary (I, image, 1);
function signature_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
        filename1 = get (handles.filename1, 'string');
    filename = strcat('C:\Users\Pihu\Desktop\breast_cancr\all-mias\', filename1);
    image = g_load (filename);
    k = get (handles.cluster, 'string');
    k = str2num (k);
    I = g_boundary (I, k, 1);
    Signature = g_detected_boundary (I, image, 0);

    Signature = Signature/max(Signature);
    plot(Signature,'linewidth',2);
function result_Callback(hObject, eventdata, handles)
    filename = get (handles.filename, 'string');
    I = g_load (filename);
        filename1 = get (handles.filename1, 'string');
    filename = strcat('C:\Users\Pihu\Desktop\breast_cancr\all-mias\', filename1);
    image = g_load (filename);
    k = get (handles.cluster, 'string');
    k = str2num (k);
    I = g_boundary (I, k, 1);
    b = g_detected_boundary (I, image, 1);
    [r n b m n1 b1 m1] = g_classify (I);
    set (handles.normal, 'string', strcat (num2str(n), '=>', num2str(n1 * 100), '%'));
    set (handles.benign, 'string', strcat (num2str(b), '=>', num2str(b1 * 100), '%'));
    set (handles.malignant, 'string', strcat (num2str(m), '=>', num2str(m1 * 100), '%'));
    if r == 0
        ans = 'Normal';
    elseif r == 1
        ans = 'Benign';
    elseif r == 2
        ans = 'Malignant';
    else
        ans = 'Undetermined';
    end
    h = msgbox (ans);
function correctness_Callback(hObject, eventdata, handles)
    g_correct ();
function t_g_normal_Callback(hObject, eventdata, handles)
    c = 0;
    g_plot (c, 1, 0);
function t_g_benign_Callback(hObject, eventdata, handles)
    c = 0;
    g_plot (c, 1, 3);
function t_g_malignant_Callback(hObject, eventdata, handles)
    c = 0;
    g_plot (c, 1, 6);
function r_g_normal_Callback(hObject, eventdata, handles)
    c = xlsread ('current.xlsx');
    c = c(2:end);
    g_plot (c, 0, 0);
function t_r_benign_Callback(hObject, eventdata, handles)
    c = xlsread ('current.xlsx');
    c = c(2:end);
    g_plot (c, 0, 3);
function r_g_malignant_Callback(hObject, eventdata, handles)
    c = xlsread ('current.xlsx');
    c = c(2:end);
    g_plot (c, 0, 6);
