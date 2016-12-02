function E = calculateEnergy(glcm)
  
foo = glcm.^2;
E = sum(foo(:));