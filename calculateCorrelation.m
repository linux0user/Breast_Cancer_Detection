function Corr = calculateCorrelation(glcm,r,c)

mr = meanIndex(r,glcm);
Sr = stdIndex(r,glcm,mr);
  
mc = meanIndex(c,glcm);
Sc = stdIndex(c,glcm,mc);

term1 = (r - mr) .* (c - mc) .* glcm(:);
term2 = sum(term1);

ws = warning('off','Matlab:divideByZero');
Corr = term2 / (Sr * Sc);
warning(ws);