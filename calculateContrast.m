function C = calculateContrast(glcm,r,c)
% Reference: Haralick RM, Shapiro LG. Computer and Robot Vision: Vol. 1,
% Addison-Wesley, 1992, p. 460.  
k = 2;
l = 1;
term1 = abs(r - c).^k;
term2 = glcm.^l;
  
term = term1 .* term2(:);
C = sum(term);