clear all
close all
clc
% DICOM_Matrix einladen
[M_highflip]=loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_highflip_orig\',-1,0);

load('ReferenzMatrix_Denoising.mat')
load('T2Sternmap.mat')
group_highflip_1   = M_highflip(:,:, 1:15).*ReferenzMatrix;
group_highflip_2   = M_highflip(:,:,16:30).*ReferenzMatrix;

% DICOM_Info auslesen
highflip_info_S1 = dicominfo('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_highflip_orig\File0001.ima')
highflip_info_S2 = dicominfo('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_highflip_orig\File0016.ima')
        TE_Highflip_S1      = highflip_info_S1.EchoTime
        TE_Highflip_S2      = highflip_info_S2.EchoTime
        

[x,y,z]          = size(group_highflip_1);
group_highflip_1_new = zeros(x,y,z);
group_highflip_2_new = zeros(x,y,z);
S0_Map              = zeros(x,y,z);
var_Map             = zeros(x,y,z);
for c=1:1:z         %Schichten
    for a=2:1:x     %Zeilen
        for b=2:1:y %Spalten
            if group_highflip_1(a,b,c) ~=0
                m1 = exp((-TE_Highflip_S1)/T2_Stern_Map(a,b,c));
                n1 = exp((-TE_Highflip_S2)/T2_Stern_Map(a,b,c));
                S1 = group_highflip_1(a,b,c);
                S2 = group_highflip_2(a,b,c);
                S0 = (m1*S1+n1*S2)/(m1^2+n1^2);
                S0_Map(a,b,c)=S0;
                group_highflip_1_new(a,b,c) = round(S0*exp((-TE_Highflip_S1)/T2_Stern_Map(a,b,c)));%S1 new;
                group_highflip_2_new(a,b,c) = round(S0*exp((-TE_Highflip_S2)/T2_Stern_Map(a,b,c)));%S2 new;
                var_Map(a,b,c) =(group_highflip_1_new(a,b,c)-(S0*exp((-TE_Highflip_S1)/T2_Stern_Map(a,b,c))))^2 + (group_highflip_2_new(a,b,c)-(S0*exp((-TE_Highflip_S2)/T2_Stern_Map(a,b,c))))^2;
            end
        end
    end
end
% figure (1)
% subplot 221
% imagesc(group_highflip_1(:,:,1),[0 800]),colorbar
% 
% title('Gre Highflip mit TE = 3.95')
% 
% subplot 222
% imagesc(group_highflip_1_new(:,:,1), [0 800]),colorbar
% title('New Created Gre Highflip mit TE = 3.95')
% 
% subplot 223
% imagesc(group_highflip_2(:,:,1), [0 600]),colorbar
% title('Gre Highflip mit TE = 11')
% 
% subplot 224
% imagesc(group_highflip_2_new(:,:,1), [0 600]),colorbar
% title('New Created Gre Highflip mit TE = 11')
% figure (2)
% imagesc(var_Map(:,:,1)),colorbar
% title('Varianz Map')

figure (1)
subplot (351)
imagesc(group_highflip_1_new(:,:,1), [0 800]); colorbar
subplot (352)
imagesc(group_highflip_1_new(:,:,2), [0 800]); colorbar
subplot (353)
imagesc(group_highflip_1_new(:,:,3), [0 800]); colorbar
subplot (354)
imagesc(group_highflip_1_new(:,:,4), [0 800]); colorbar
subplot (355)
imagesc(group_highflip_1_new(:,:,5), [0 800]); colorbar
subplot (356)
imagesc(group_highflip_1_new(:,:,6), [0 800]); colorbar
subplot (357)
imagesc(group_highflip_1_new(:,:,7), [0 800]); colorbar
subplot (358)
imagesc(group_highflip_1_new(:,:,8), [0 800]); colorbar
subplot (359)
imagesc(group_highflip_1_new(:,:,9), [0 800]); colorbar
subplot (3,5,10)
imagesc(group_highflip_1_new(:,:,10), [0 800]); colorbar
subplot (3,5,11)
imagesc(group_highflip_1_new(:,:,11), [0 800]); colorbar
subplot (3,5,12)
imagesc(group_highflip_1_new(:,:,12), [0 800]); colorbar
subplot (3,5,13)
imagesc(group_highflip_1_new(:,:,13), [0 800]); colorbar
subplot (3,5,14)
imagesc(group_highflip_1_new(:,:,14), [0 800]); colorbar
subplot (3,5,15)
imagesc(group_highflip_1_new(:,:,15), [0 800]); colorbar;
sgtitle('MSLOW0015:  Gre Highflip gefiltert und rekonstruiert nach T2*, TE = 3.95ms');


figure (2)
subplot (351)
imagesc(group_highflip_2_new(:,:,1), [0 600]); colorbar
subplot (352)
imagesc(group_highflip_2_new(:,:,2), [0 600]); colorbar
subplot (353)
imagesc(group_highflip_2_new(:,:,3), [0 600]); colorbar
subplot (354)
imagesc(group_highflip_2_new(:,:,4), [0 600]); colorbar
subplot (355)
imagesc(group_highflip_2_new(:,:,5), [0 600]); colorbar
subplot (356)
imagesc(group_highflip_2_new(:,:,6), [0 600]); colorbar
subplot (357)
imagesc(group_highflip_2_new(:,:,7), [0 600]); colorbar
subplot (358)
imagesc(group_highflip_2_new(:,:,8), [0 600]); colorbar
subplot (359)
imagesc(group_highflip_2_new(:,:,9), [0 600]); colorbar
subplot (3,5,10)
imagesc(group_highflip_2_new(:,:,10), [0 600]); colorbar
subplot (3,5,11)
imagesc(group_highflip_2_new(:,:,11), [0 600]); colorbar
subplot (3,5,12)
imagesc(group_highflip_2_new(:,:,12), [0 600]); colorbar
subplot (3,5,13)
imagesc(group_highflip_2_new(:,:,13), [0 600]); colorbar
subplot (3,5,14)
imagesc(group_highflip_2_new(:,:,14), [0 600]); colorbar
subplot (3,5,15)
imagesc(group_highflip_2_new(:,:,15), [0 600]); colorbar;
sgtitle('MSLOW0015:  Gre Highflip gefiltert und rekonstruiert nach T2*, TE = 11 ms');

figure (3)
subplot (351)
imagesc(var_Map(:,:,1) ); colorbar
subplot (352)
imagesc(var_Map(:,:,2) ); colorbar
subplot (353)
imagesc(var_Map(:,:,3) ); colorbar
subplot (354)
imagesc(var_Map(:,:,4) ); colorbar
subplot (355)
imagesc(var_Map(:,:,5) ); colorbar
subplot (356)
imagesc(var_Map(:,:,6) ); colorbar
subplot (357)
imagesc(var_Map(:,:,7) ); colorbar
subplot (358)
imagesc(var_Map(:,:,8) ); colorbar
subplot (359)
imagesc(var_Map(:,:,9) ); colorbar
subplot (3,5,10)
imagesc(var_Map(:,:,10) ); colorbar
subplot (3,5,11)
imagesc(var_Map(:,:,11) ); colorbar
subplot (3,5,12)
imagesc(var_Map(:,:,12) ); colorbar
subplot (3,5,13)
imagesc(var_Map(:,:,13) ); colorbar
subplot (3,5,14)
imagesc(var_Map(:,:,14) ); colorbar
subplot (3,5,15)
imagesc(var_Map(:,:,15) ); colorbar;
sgtitle('MSLOW0015:  Varianz zwischen neu erstellten MR-Bildern');