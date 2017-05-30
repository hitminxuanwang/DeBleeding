%% the code is created based on ConvPyr
function [res]=ConvPyrBlending(trg,src,mask,tmask)
    h = fspecial('laplacian', 0);
    chi = imfilter(double(mask),h);
    chi(chi<0) = 0;
    chi(chi>0) = 1;
    erf = (trg - src);
    kernel=ones(13,13);
    window_erf=imfilter(erf,kernel)/(13*13);
    w = [0.1507 0.6836 1.0334 0.0270 0.0312 0.7753];
    h1 = w(1:3);
    h1 = [h1 h1(end-1:-1:1)];
    h1 = h1' * h1;
    h2 = h1*w(4);
    g = w(5:end);
    g = [g g(end-1:-1:1)];
    g = g' * g;
    Ichi = evalf( chi, h1, h2, g );
    for i=1:3
        sr = src(:,:,i);
        tr = trg(:,:,i);      
        a = window_erf(:,:,i);
        a(~chi) =  0;
        Ierf = evalf( a, h1, h2, g );
        %temp=Ierf./Ichi+sr;
        offset=Ierf./Ichi;
        temp =offset*0.5+ sr;       
        tr(mask) = temp(mask);
        temp =offset*(-0.5)+ tr;
        tr(tmask) = temp(tmask);
        res(:,:,i) = tr;
    end
end