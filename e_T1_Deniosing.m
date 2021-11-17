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

load('Highflip_Datei_After_Denoising.mat')
group_lowflip  = greLow (:,:,1:15).*ReferenzMatrix;
group_highflip = greHigh(:,:,1:15).*ReferenzMatrix;
group_flipmap  = flipmap(:,:,1:15).*ReferenzMatrix;



ratio = zeros(size(group_lowflip));%verhaltnis zwischen S1 und S2;
ratio(:,:,:) = group_lowflip./group_highflip;
ratio_new = zeros(size(group_lowflip));%verhaltnis zwischen S1 und S2;
ratio_new(:,:,:) = group_lowflip./group_highflip_1_new;



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




% 
% subplot (1,2,1)
% imagesc(T1(:,:,1), [50 3500]),colorbar
% title('T1 Map before Denoising')
% 
% 
% subplot (1,2,2)
% imagesc(T1_new(:,:,1), [50 3500]),colorbar
% title('T1 Map after Denoising')
% T1_After_T1_Fiter = T1_new;


figure (1)
subplot (351)
imagesc(T1_new(:,:,1), [50 3500]);  colorbar
subplot (352)
imagesc(T1_new(:,:,2), [50 3500]);  colorbar
subplot (353)
imagesc(T1_new(:,:,3), [50 3500]);  colorbar
subplot (354)
imagesc(T1_new(:,:,4), [50 3500]);  colorbar
subplot (355)
imagesc(T1_new(:,:,5), [50 3500]);  colorbar
subplot (356)
imagesc(T1_new(:,:,6), [50 3500]);  colorbar
subplot (357)
imagesc(T1_new(:,:,7), [50 3500]);  colorbar
subplot (358)
imagesc(T1_new(:,:,8), [50 3500]);  colorbar
subplot (359)
imagesc(T1_new(:,:,9), [50 3500]);  colorbar
subplot (3,5,10)
imagesc(T1_new(:,:,10), [50 3500]);  colorbar
subplot (3,5,11)
imagesc(T1_new(:,:,11), [50 3500]);  colorbar
subplot (3,5,12)
imagesc(T1_new(:,:,12), [50 3500]);  colorbar
subplot (3,5,13)
imagesc(T1_new(:,:,13), [50 3500]);  colorbar
subplot (3,5,14)
imagesc(T1_new(:,:,14), [50 3500]);  colorbar
subplot (3,5,15)
imagesc(T1_new(:,:,15), [50 3500]);  colorbar;
sgtitle('MSLOW0015: T1 Relaxationszeit, nachdem T2* Filterung');