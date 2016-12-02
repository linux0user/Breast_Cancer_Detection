function [glcm,reqStats] = ParseInputs(allstats,varargin)
  
numstats = length(allstats);
iptchecknargin(1,numstats+1,nargin,mfilename);

reqStats = '';
glcm = varargin{1};

if ndims(glcm) > 3
  eid = sprintf('Images:%s:invalidSizeForGLCM',mfilename);
  msg = 'GLCM must either be an m x n or an m x n x p array.';
  error(eid,'%s',msg);
end

% Cast GLCM to double to avoid truncation by data type. Note that GLCM is not an
% image.
if ~isa(glcm,'double')
  glcm = double(glcm);
end

list = varargin(2:end);

if isempty(list)
  % GRAYCOPROPS(GLCM) or GRAYCOPROPS(GLCM,PROPERTIES) where PROPERTIES is empty.
  reqStats = allstats;
else
  if iscell(list{1}) || numel(list) == 1
    % GRAYCOPROPS(GLCM,{...})
    list = list{1};
  end

  if ischar(list)
    %GRAYCOPROPS(GLCM,SPACE-SEPARATED STRING)
    list = strread(list, '%s');
  end

  anyprop = allstats;
  anyprop{end+1} = 'all';
  
  for k = 1 : length(list)
    match = iptcheckstrs(list{k}, anyprop, mfilename, 'PROPERTIES', k+1);
    if strcmp(match,'all')
      reqStats = allstats;
      break;
    end
    reqStats{k} = match;
  end
  
end

% Make sure that reqStats are in alphabetical order.
reqStats = sort(reqStats);

if isempty(reqStats)
  eid = sprintf('Images:%s:internalError',mfilename);
  msg = 'Internal error: requestedStats has not been assigned.';
  error(eid,'%s',msg);
end