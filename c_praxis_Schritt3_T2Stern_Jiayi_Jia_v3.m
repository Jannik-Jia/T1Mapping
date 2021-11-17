clear all
close all
clc
        [M_lowflip]         = loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_lowflip\',-1,0);
        [curDS,curNoFiles,infoFirst,DcmInfoList] =loadDicomFolder('C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Praxisphase\T1Optimisation\MSLOW0015\gre_lowflip\',-1,0);
        group_lowflip_1    = M_lowflip(:,:, 1:15);

        i = 1;
        for group = 1:15:420;
            TE_group(1,i) = DcmInfoList{group,1}.EchoTime;
            i = i+1;
        end

%T2 herausfinden
        [x,y,z_M]               = size(M_lowflip);
        Signal_Voxel            = zeros();
        Signal_Voxel_polyfit    = zeros();
        Ln_Signal_Voxel_polyfit = zeros();
        T2_Stern_Map            = zeros(192,144,15);
        

        for d = 1:15                                    % Das ganze Gehirn wird in 15 Schichten geschnitten
                for a = 2:1:x                           % Zeilen
                    for b = 2:1:y                       % Spalten
                        e = 1;                          
                            for c = d:15:z_M            % Gleiches Voxel unter verschiedenen TE
                                Signal_Voxel(d,a,b,e) = M_lowflip(a,b,c) ; 
                                e = e+1;
                            end
                    end
                
                end
        d = d+1;
        end


        noise_lowfilp               = group_lowflip_1 (7:11,7:11,1); 
        NoiseLevel_lowflip          = mean(noise_lowfilp(:));
        noise_Verstaerkung          = 5;
        denoise_parameter_low       = NoiseLevel_lowflip * noise_Verstaerkung;

        for d = 1:15   
            for a = 2:1:x
                for b = 2:1:y
                    if  M_lowflip(a,b,d) > denoise_parameter_low
                        Signal_Voxel_polyfit    = permute(Signal_Voxel(d,a,b,:),[1 4 2 3]);
                        Ln_Signal_Voxel_polyfit = log(Signal_Voxel_polyfit);
                            for g = 1:28
                                if  Ln_Signal_Voxel_polyfit(1,g) <0
                                    Ln_Signal_Voxel_polyfit(1,g) = 0;
                                end
                                    p                    = polyfit(TE_group,Ln_Signal_Voxel_polyfit,1);
                                    R2_Stern             = abs(p(1,1));%为啥有负值, 没理解
                                    T2_Stern             = 1/R2_Stern;
                                    T2_Stern_Map(a,b,d)  = T2_Stern;
                                    f                    = polyval(p,TE_group);
                            end
                    end
                end
            end
        d = d+1
        end

figure (1)
imagesc(T2_Stern_Map(:,:,3),[0 600]),colorbar
title('a pic of T2* map after denoising');

figure (2)
plot(TE_group,Ln_Signal_Voxel_polyfit,'o')
hold on
plot(TE_group,f,'r--')
axis([0  70  0  10])
xlabel('TE(ms)') 
ylabel('ln(Signal)') 
legend('ln(S(TE))','Angepasste Gerade')
title('Lineare Regression mit 28 Datenpunkten zur Anpassung an T2*');

%figure (3)
% subplot 741
% imagesc(Signal_Voxel(:,:,1)),colorbar
% 
% subplot 742
% imagesc(Signal_Voxel(:,:,2)),colorbar
% 
% subplot 743
% imagesc(Signal_Voxel(:,:,3)),colorbar
% 
% subplot 744
% imagesc(Signal_Voxel(:,:,4)),colorbar
% 
% subplot 745
% imagesc(Signal_Voxel(:,:,5)),colorbar
% 
% subplot 746
% imagesc(Signal_Voxel(:,:,6)),colorbar
% 
% subplot 747
% imagesc(Signal_Voxel(:,:,7)),colorbar
% 
% subplot 748
% imagesc(Signal_Voxel(:,:,8)),colorbar
% 
% subplot 749
% imagesc(Signal_Voxel(:,:,9)),colorbar
% 
% subplot (7,4,10)
% imagesc(Signal_Voxel(:,:,11)),colorbar
% 
% subplot (7,4,11)
% imagesc(Signal_Voxel(:,:,11)),colorbar
% 
% subplot (7,4,12)
% imagesc(Signal_Voxel(:,:,12)),colorbar
% 
% subplot (7,4,13)
% imagesc(Signal_Voxel(:,:,13)),colorbar
% 
% subplot (7,4,14)
% imagesc(Signal_Voxel(:,:,14)),colorbar
% 
% subplot (7,4,15)
% imagesc(Signal_Voxel(:,:,15)),colorbar
% 
% subplot (7,4,16)
% imagesc(Signal_Voxel(:,:,16)),colorbar
% 
% subplot (7,4,17)
% imagesc(Signal_Voxel(:,:,17)),colorbar
% 
% subplot (7,4,18)
% imagesc(Signal_Voxel(:,:,18)),colorbar
% 
% subplot (7,4,19)
% imagesc(Signal_Voxel(:,:,19)),colorbar
% 
% subplot (7,4,20)
% imagesc(Signal_Voxel(:,:,20)),colorbar
% 
% subplot (7,4,21)
% imagesc(Signal_Voxel(:,:,21)),colorbar
% 
% subplot (7,4,22)
% imagesc(Signal_Voxel(:,:,22)),colorbar
% 
% subplot (7,4,23)
% imagesc(Signal_Voxel(:,:,23)),colorbar
% 
% subplot (7,4,24)
% imagesc(Signal_Voxel(:,:,24)),colorbar
% 
% subplot (7,4,25)
% imagesc(Signal_Voxel(:,:,25)),colorbar
% 
% subplot (7,4,26)
% imagesc(Signal_Voxel(:,:,26)),colorbar
% 
% subplot (7,4,27)
% imagesc(Signal_Voxel(:,:,27)),colorbar
% 
% subplot (7,4,28)
% imagesc(Signal_Voxel(:,:,28)),colorbar

load ('T2Sternmap.mat')
figure (3)
subplot (351)
imagesc(T2_Stern_Map(:,:,1), [0 600]); colorbar
subplot (352)
imagesc(T2_Stern_Map(:,:,2), [0 600]); colorbar
subplot (353)
imagesc(T2_Stern_Map(:,:,3), [0 600]); colorbar
subplot (354)
imagesc(T2_Stern_Map(:,:,4), [0 600]); colorbar
subplot (355)
imagesc(T2_Stern_Map(:,:,5), [0 600]); colorbar
subplot (356)
imagesc(T2_Stern_Map(:,:,6), [0 600]); colorbar
subplot (357)
imagesc(T2_Stern_Map(:,:,7), [0 600]); colorbar
subplot (358)
imagesc(T2_Stern_Map(:,:,8), [0 600]); colorbar
subplot (359)
imagesc(T2_Stern_Map(:,:,9), [0 600]); colorbar
subplot (3,5,10)
imagesc(T2_Stern_Map(:,:,10), [0 600]); colorbar
subplot (3,5,11)
imagesc(T2_Stern_Map(:,:,11), [0 600]); colorbar
subplot (3,5,12)
imagesc(T2_Stern_Map(:,:,12), [0 600]); colorbar
subplot (3,5,13)
imagesc(T2_Stern_Map(:,:,13), [0 600]); colorbar
subplot (3,5,14)
imagesc(T2_Stern_Map(:,:,14), [0 600]); colorbar
subplot (3,5,15)
imagesc(T2_Stern_Map(:,:,15), [0 600]); colorbar;
sgtitle('MSLOW0015:  T2 Stern Relaxationszeit');