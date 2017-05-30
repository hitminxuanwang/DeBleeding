%any problem ,sent email to hitminxuanwang@gmail.com
source=im2double(imread('images/source.png'));
target=im2double(imread('images/target.png'));
src_mask=im2double(imread('images/mask.png'));

trg_mask=1-logical(trg_mask(:,:,1));

naive=source.*repmat(src_mask,[1,1,3])+target.*repmat(trg_mask,[1,1,3]);
res_convpyr=OrignConvPyrBlending(target,source,logical(src_mask),logical(trg_mask));
figure(1);imshow(res_convpyr);title('Convolution Pyramid');
res_ours=ConvPyrBlending(target,source,logical(src_mask),logical(trg_mask));
figure(2);imshow(res_ours);title('Our result');
%offsetmap=res_convpyr-naive+0.5;
