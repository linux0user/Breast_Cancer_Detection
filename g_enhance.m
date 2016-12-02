function HE = g_enhance (I, sigma)
     h = waitbar(0, '0 percentage done', 'Name', 'Enhancing',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''cancelling'',1)');
    setappdata(h,'canceling', 0);
    I = im2double (I);
    I = log(1 + I);
    waitbar(0.1, h, '10.00 percentage done');
    M = 2 * size (I, 1) + 1;
    N = 2 * size (I, 2) + 1;
    [x, y] = meshgrid (1:N, 1:M);
    centerX = ceil (N / 2);
    centerY = ceil (M / 2);
    gaussianNumerator = (x - centerX) .^2 + (y - centerY).^2;
    H = exp (-gaussianNumerator./(2*sigma.^2));
    H = 1 - H;
    H = fftshift (H);
    waitbar(0.25, h, '20.00 percentage done');

    If = fft2(I, M, N);
    Iout = real(ifft2(repmat( H, [1, 1, 1 ] ) .* If));
    Iout = Iout (1:size (I, 1), 1:size(I,2));
    Ihmf = exp (Iout) - 1;
    G = Ihmf;
    waitbar(0.5, h, '50.00 percentage done');

    stEl = strel ('disk', 15);
    Top = imtophat(G, stEl);
    Bot = imbothat (Top, stEl);
    waitbar(0.75, h, '75.00 percentage done');
    
    EnImage = (G + Top) - Bot;
    HE = adapthisteq (EnImage);
    waitbar(1, h, '100.00 percentage done');
    delete (h);
