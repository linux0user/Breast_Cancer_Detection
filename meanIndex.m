function M = meanIndex(index,glcm)

M = index .* glcm(:);
M = sum(M);