function S = stdIndex(index,glcm,m)

term1 = (index - m).^2 .* glcm(:);
S = sqrt(sum(term1));