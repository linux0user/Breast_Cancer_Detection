function g_train ()
    tic
    c = xlsread ('C:\Users\Pihu\Desktop\breast_cancr\train\class.xlsx');
    g_features (c, 1);
    g_manipulate (1);
    w = toc;
    w = strcat('Training completed. ', 'Time elapsed : ', num2str (w));
    h = msgbox(w);