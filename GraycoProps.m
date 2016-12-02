function stats = GraycoProps(varargin)

allStats = {'Contrast','Correlation','Energy','Homogeneity'};
  
[glcm, requestedStats] = ParseInputs(allStats, varargin{:});

% Initialize output stats structure.
numStats = length(requestedStats);
numGLCM = size(glcm,3);
empties = repmat({zeros(1,numGLCM)},[numStats 1]);
stats = cell2struct(empties,requestedStats,1);

for p = 1 : numGLCM
  

  if numGLCM ~= 1 %N-D indexing not allowed for sparse. 
   tGLCM = normalizeGLCM(glcm(:,:,p));
  else 
   tGLCM = normalizeGLCM(glcm);
  end

  % Get row and column subscripts of GLCM.  These subscripts correspond to the
  % pixel values in the GLCM.
  s = size(tGLCM);
  [c,r] = meshgrid(1:s(1),1:s(2));
  r = r(:);
  c = c(:);

  % Calculate fields of output stats structure.
  for k = 1:numStats
    name = requestedStats{k};  
    switch name
     case 'Contrast'
      stats.(name)(p) = calculateContrast(tGLCM,r,c);
      
     case 'Correlation'
      stats.(name)(p) = calculateCorrelation(tGLCM,r,c);
      
     case 'Energy'
      stats.(name)(p) = calculateEnergy(tGLCM);
      
     case 'Homogeneity'
      stats.(name)(p) = calculateHomogeneity(tGLCM,r,c);
    end
  end

end