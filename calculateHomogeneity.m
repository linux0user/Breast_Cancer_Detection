function H = calculateHomogeneity(glcm,r,c)
term1 = (1 + abs(r - c));
term = glcm(:) ./ term1;
H = sum(term);
