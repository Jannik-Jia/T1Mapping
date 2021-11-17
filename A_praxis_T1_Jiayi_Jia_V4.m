clear all
close all
clc
%% Required Input data
DicomDatei_Lowflip  = ['C:\Users\38367\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW0015\gre_lowflip\'];
DicomDatei_flipmap  = ['C:\Users\38367\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW0015\FlipMaps\'];
DicomDatei_Highflip = ['C:\Users\38367\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW0015\gre_highflip_orig\'];

%% Output Informations
The_Name_of_TargetData_T1_Info = ['T1_Roh.mat'];

%% Main Codes 
[greLow,iNoFiles,infoFirst]=loadDicomFolder(DicomDatei_Lowflip,-1,0);
FA1nom          = infoFirst.FlipAngle 
TR1             = infoFirst.RepetitionTime;

[flipmap,iNoFiles,infoFirst]=loadDicomFolder(DicomDatei_Lowflip,-1,0);

[greHigh,iNoFiles,infoFirst]=loadDicomFolder(DicomDatei_Highflip,-1,0);
FA2nom          = infoFirst.FlipAngle;
TR2             = infoFirst.RepetitionTime;

group_lowflip  = greLow (:,:,1:15);
group_highflip = greHigh(:,:,1:15);
group_flipmap  = flipmap(:,:,1:15);

ratio = zeros(size(group_lowflip));%verhaltnis zwischen S1 und S2;
ratio(:,:,:) = group_lowflip./group_highflip;

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
T1;


figure(1)
subplot (1,2,1)
imagesc(T1(:,:,1), [50 3500]),colorbar
title('Use T1 value as grayscale value')

imagesc(ratio(:,:,1), [0 5]),colorbar


subplot (1,2,2)
imagesc(group_lowflip(:,:,1), [0 2000]),colorbar 
title('a pic of Gre lowflip')

T1_Roh = T1;
group_lowflip_Roh = group_lowflip;
group_highflip_Roh = group_highflip;


figure (2)
subplot (351)
imagesc(T1(:,:,1), [50 3500]);  colorbar
subplot (352)
imagesc(T1(:,:,2), [50 3500]);  colorbar
subplot (353)
imagesc(T1(:,:,3), [50 3500]);  colorbar
subplot (354)
imagesc(T1(:,:,4), [50 3500]);  colorbar
subplot (355)
imagesc(T1(:,:,5), [50 3500]);  colorbar
subplot (356)
imagesc(T1(:,:,6), [50 3500]);  colorbar
subplot (357)
imagesc(T1(:,:,7), [50 3500]);  colorbar
subplot (358)
imagesc(T1(:,:,8), [50 3500]);  colorbar
subplot (359)
imagesc(T1(:,:,9), [50 3500]);  colorbar
subplot (3,5,10)
imagesc(T1(:,:,10), [50 3500]);  colorbar
subplot (3,5,11)
imagesc(T1(:,:,11), [50 3500]);  colorbar
subplot (3,5,12)
imagesc(T1(:,:,12), [50 3500]);  colorbar
subplot (3,5,13)
imagesc(T1(:,:,13), [50 3500]);  colorbar
subplot (3,5,14)
imagesc(T1(:,:,14), [50 3500]);  colorbar
subplot (3,5,15)
imagesc(T1(:,:,15), [50 3500]);  colorbar;
sgtitle('MSLOW0015: T1 Relaxationszeit, Ohne Rauschunterdrückung');
%未经过任何滤波的T1 弛豫时间图谱

figure (3)
subplot (351)
imagesc(group_lowflip(:,:,1), [0 2000]); colorbar
subplot (352)
imagesc(group_lowflip(:,:,2), [0 2000]); colorbar
subplot (353)
imagesc(group_lowflip(:,:,3), [0 2000]); colorbar
subplot (354)
imagesc(group_lowflip(:,:,4), [0 2000]); colorbar
subplot (355)
imagesc(group_lowflip(:,:,5), [0 2000]); colorbar
subplot (356)
imagesc(group_lowflip(:,:,6), [0 2000]); colorbar
subplot (357)
imagesc(group_lowflip(:,:,7), [0 2000]); colorbar
subplot (358)
imagesc(group_lowflip(:,:,8), [0 2000]); colorbar
subplot (359)
imagesc(group_lowflip(:,:,9), [0 2000]); colorbar
subplot (3,5,10)
imagesc(group_lowflip(:,:,10), [0 2000]); colorbar
subplot (3,5,11)
imagesc(group_lowflip(:,:,11), [0 2000]); colorbar
subplot (3,5,12)
imagesc(group_lowflip(:,:,12), [0 2000]); colorbar
subplot (3,5,13)
imagesc(group_lowflip(:,:,13), [0 2000]); colorbar
subplot (3,5,14)
imagesc(group_lowflip(:,:,14), [0 2000]); colorbar
subplot (3,5,15)
imagesc(group_lowflip(:,:,15), [0 2000]); colorbar;
sgtitle('MSLOW0015: Rohdaten einer vollständigen Gehirnprobe, die von Gre Lowflip entnommen wurde');

save(The_Name_of_TargetData_T1_Info,'T1')  % function form