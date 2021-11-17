clear all
close all
clc
[greLow,iNoFiles,infoFirst]=loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_lowflip\',-1,0);
FA1nom          = infoFirst.FlipAngle 
TR1             = infoFirst.RepetitionTime;

[flipmap,iNoFiles,infoFirst]=loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\FlipMaps\',-1,0);

[greHigh,iNoFiles,infoFirst]=loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_highflip_orig\',-1,0);
FA2nom          = infoFirst.FlipAngle;
TR2             = infoFirst.RepetitionTime;

% load('Highflip_Datei_After_Denoising.mat')
load('ReferenzMatrix_new.mat')
load('Gre_Highflip_new.mat')
%load('Gre_Highflip_new.mat')                   %Sigma = 1
%load('Gre_Highflip_new_sig_1komma5.mat')       %Sigma = 1.5


group_lowflip  = greLow (:,:,1:15).*ReferenzMatrix_new;

group_highflip_1_new_raum_8nachbar = group_highflip_1_new_raum_8nachbar.*ReferenzMatrix_new;
group_highflip_2_new_raum_8nachbar = group_highflip_2_new_raum_8nachbar.*ReferenzMatrix_new;
group_flipmap  = flipmap(:,:,1:15).*ReferenzMatrix_new;



ratio = zeros(size(group_lowflip));%verhaltnis zwischen S1 und S2;
ratio(:,:,:) = group_lowflip./group_highflip_1_new_raum_8nachbar;
ratio_new = zeros(size(group_lowflip));%verhaltnis zwischen S1 und S2;
ratio_new(:,:,:) = group_lowflip./group_highflip_2_new_raum_8nachbar;



%T1 herausfinden
syms t1;
[x,y,z]=size(ratio);
T1=zeros(x,y,z);

for c=1:1:z         %Schichten
    for a=2:1:x     %Zeilen
        for b=2:1:y %Spalten          
            for t1 = 50:1:3500
                if group_flipmap(a,b,c) ~= 0
                    if ratio(a,b,c)==Inf %there are some errors in matrix"Vhlts", a small number of values are displayed as"Inf".
                        ratio(a,b,c) =0;
                    end
                    Eq_lowflip  = ((1-exp(-TR1/t1))/(1-(cosd((group_flipmap(a,b,c)/1000)*FA1nom)*exp(-TR1/t1))))*sind((group_flipmap(a,b,c)/1000)*FA1nom);
                    Eq_Highflip = ((1-exp(-TR2/t1))/(1-(cosd((group_flipmap(a,b,c)/1000)*FA2nom)*exp(-TR2/t1))))*sind((group_flipmap(a,b,c)/1000)*FA2nom);
                    Equ = Eq_lowflip/Eq_Highflip;
                    Abweichung = abs(Equ-ratio(a,b,c));
                    if (t1==50)
                        Abw(a,b,c) =Abweichung;
                        T1(a,b,c)  =t1;
                    elseif (Abweichung<Abw(a,b,c))
                            Abw(a,b,c) =Abweichung;
                            T1(a,b,c)  =t1;
                    end
                end
            end
        end
	end
end

%T1 herausfinden
syms t1;
[x,y,z]=size(ratio_new);
T1_new=zeros(x,y,z);
for c=1:1:z         %Schichten
    for a=2:1:x     %Zeilen
        for b=2:1:y %Spalten          
            for t1 = 50:1:3500
                if group_flipmap(a,b,c) ~= 0
                    if ratio_new(a,b,c)==Inf %there are some errors in matrix"Vhlts", a small number of values are displayed as"Inf".
                        ratio_new(a,b,c) =0;
                    end
                    Eq_lowflip  = ((1-exp(-TR1/t1))/(1-(cosd((group_flipmap(a,b,c)/1000)*FA1nom)*exp(-TR1/t1))))*sind((group_flipmap(a,b,c)/1000)*FA1nom);
                    Eq_Highflip = ((1-exp(-TR2/t1))/(1-(cosd((group_flipmap(a,b,c)/1000)*FA2nom)*exp(-TR2/t1))))*sind((group_flipmap(a,b,c)/1000)*FA2nom);
                    Equ = Eq_lowflip/Eq_Highflip;
                    Abweichung = abs(Equ-ratio_new(a,b,c));
                    if (t1==50)
                        Abw(a,b,c) =Abweichung;
                        T1_new(a,b,c)  =t1;
                    elseif (Abweichung<Abw(a,b,c))
                            Abw(a,b,c) =Abweichung;
                            T1_new(a,b,c)  =t1;
                    end
                end
            end
        end
	end
end

T1_After_Denoising_Raum_8nachbar = (T1+T1_new)/2;


% figure(1)
% subplot (1,2,1)
% imagesc(T1(:,:,10), [50 3500]),colorbar
% title('T1 Map TE = 3.95')
% 
% 
% subplot (1,2,2)
% imagesc(T1_new(:,:,11) ,[50 3500]),colorbar
% title('T1 Map , TE= 11')
% 
% 
% figure(2)
% imagesc(T1_After_Denoising_Raum_8nachbar(:,:,1)),colorbar
% title('T1 Map nachdem kombinierter Rauschunterdrückung, 8 Nachbarschaft')


figure (1)
subplot (351)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,1), [50 3500]);  colorbar
subplot (352)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,2), [50 3500]);  colorbar
subplot (353)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,3), [50 3500]);  colorbar
subplot (354)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,4), [50 3500]);  colorbar
subplot (355)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,5), [50 3500]);  colorbar
subplot (356)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,6), [50 3500]);  colorbar
subplot (357)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,7), [50 3500]);  colorbar
subplot (358)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,8), [50 3500]);  colorbar
subplot (359)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,9), [50 3500]);  colorbar
subplot (3,5,10)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,10), [50 3500]);  colorbar
subplot (3,5,11)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,11), [50 3500]);  colorbar
subplot (3,5,12)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,12), [50 3500]);  colorbar
subplot (3,5,13)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,13), [50 3500]);  colorbar
subplot (3,5,14)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,14), [50 3500]);  colorbar
subplot (3,5,15)
imagesc(T1_After_Denoising_Raum_8nachbar(:,:,15), [50 3500]);  colorbar;
sgtitle('MSLOW0015: T1 Map nachdem kombinierter Rauschunterdrückung, 8 Nachbarschaft');
