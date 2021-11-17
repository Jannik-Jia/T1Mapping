close all
clear all
clc


        x1 = 1:12;
        x2 = 1:13;
        %1
        y_CO_R1_GM_Slope    = [9795.51608 17175.3118 7977.40163 7757.75853 6694.94664 9795.40696 9802.33457 2352.18106 5291.93634 8840.0963 -5711.7463 5841.8557];
        y_MS_R1_GM_Slope    = [3862.342 6316.07013 6471.93949 14194.1684 9267.86458 37226.0738 5033.10686 9438.55307 8205.42621 3607.22627 4125.60875 20011.7828 17991.7632];
        %2
        y_CO_R1_GM_Offset   = [376.934349 358.567407 368.972843 365.722188 366.979527 354.841972 357.945558 369.941538 376.091218 367.44217 377.64564 356.19738 ];
        y_MS_R1_GM_Offset   = [385.069731 392.376279 378.531117 375.341893 377.608177 317.734558 375.058666 368.698096 372.482974 386.081395 390.247264 317.923152 364.235617];
        %3
        y_CO_R2_GM_Slope    = [4555.68731 3255.97873 2641.08544 3014.4008 2464.56765 2895.95527 2631.98749 3321.0627 3672.68158 2943.3419 1896.7763 2976.2088 ];
        y_MS_R2_GM_Slope    = [4383.40865 4659.27305 4619.15121 4757.1458 4327.51409 1676.52185 3454.19603 4517.2946 3434.44507 3084.70224 2893.19213 6453.46031 4619.98014];
        %4
        y_CO_R2_GM_Offset   = [349.81265 355.892161 356.737173 348.528151 353.804171 343.753585 348.830003 344.405731 352.472072 353.6607 351.97239 337.17629];
        y_MS_R2_GM_Offset   = [353.583395 358.869654 345.585538 351.375065 351.27882 362.621358 352.751899 343.150471 354.123661 363.657628 371.892894 291.968219 350.493505 ];
        
        y_CO_R1_WM_Slope    = [-8768.1026 -9312.2937 -8885.3363 -8318.0274 -7830.1034 -7670.309 -7793.3519 -7123.2586 -8228.0777 -7476.0252 -5652.3873 -7023.866 ];
        y_MS_R1_WM_Slope    = [-7705.31693 -8672.86573 -8050.31423 -10035.9875 -8212.12978 -10694.1044 -8359.50429 -7554.64183 -7755.18727 -7943.16197 -7923.26754 -8384.82252 -9286.84771 ];
        
        y_CO_R1_WM_Offset   = [398.36501 395.11073 391.24969 382.75319 380.74005 376.95394 377.80406 376.28293 390.79929 388.24783 367.54965 368.74586 ];
        y_MS_R1_WM_Offset   = [396.28271 408.055289 391.863349 405.575108 397.352448 390.251244 386.305264 388.526823 387.133714 394.479696 400.533626 360.952433 399.81555 ];
        
        y_CO_R2_WM_Slope    = [363.72354 382.75345 357.65161 351.84571 363.7272 365.78373 375.9429 347.4547 371.83999 358.14409 334.03773 340.05812 ];
        y_MS_R2_WM_Slope    = [2431.86497 1062.69421 66.2173192 185.198201 1293.51965 57.460974 -2829.82178 1353.01187 -1920.98838 -615.717008 422.459536 546.218822 -2071.57071 ];
        
        y_CO_R2_WM_Offset   = [-0.37667654 -0.45729458 -0.41888981 -0.42440256 -0.39984483 -0.39739378 -0.41115756 -0.37853355 -0.3923529 -0.38432422 -0.29165095 -0.3897624 ];
        y_MS_R2_WM_Offset   = [341.709506 360.488503 356.82056 360.668361 351.606254 347.130626 382.708467 341.727001 375.925655 368.488549 363.98578 320.078467 384.904195 ];
% 
        min_y_CO_R2_WM_Slope  = min( y_CO_R2_WM_Slope)
        min_y_MS_R2_WM_Slope  = min( y_MS_R2_WM_Slope)
        min_y_CO_R2_WM_Offset = min( y_CO_R2_WM_Offset)
        min_y_MS_R2_WM_Offset = min( y_MS_R2_WM_Offset)
      
        max_y_CO_R2_WM_Slope  = max( y_CO_R2_WM_Slope)
        max_y_MS_R2_WM_Slope  = max( y_MS_R2_WM_Slope)
        max_y_CO_R2_WM_Offset = max( y_CO_R2_WM_Offset)
        max_y_MS_R2_WM_Offset = max( y_MS_R2_WM_Offset)



        figure(1)
        subplot(221)
        h1 = histogram(y_CO_R1_GM_Slope,'BinWidth',4000);
        hold on
        h2 = histogram(y_MS_R1_GM_Slope,'BinWidth',4000);
        xlabel('Wert')
        ylabel('Slope')
        legend('CO','MS')
         set(gca,'XLim',[-10000 50000]);%X轴的数据显示范围
        set(gca,'YLim',[0 6]);%
        subtitle('R1 - Slope')
        sgtitle('Slope und Offset Vergleich: GM')




        subplot(222)
        h1 = histogram(y_CO_R1_GM_Offset,'BinWidth',8);
        hold on
        h2 = histogram(y_MS_R1_GM_Offset,'BinWidth',8);
        xlabel('Wert')
        ylabel('Offset')
        set(gca,'XLim',[300 420]);
        set(gca,'YLim',[0 5]);%
        legend('CO','MS')
        subtitle('R1 - Offset')


        subplot(223)
        h1 = histogram(y_CO_R2_GM_Slope,'BinWidth',400);
        hold on
        h2 = histogram(y_MS_R2_GM_Slope,'BinWidth',400);
        xlabel('Wert')
        ylabel('Slope')
        set(gca,'XLim',[1000 8000]);
        set(gca,'YLim',[0 6]);%
        legend('CO','MS')
        subtitle('R2 - Slope')



        subplot(224)
        h1 = histogram(y_CO_R2_GM_Offset,'BinWidth',8);
        hold on
        h2 = histogram(y_MS_R2_GM_Offset,'BinWidth',8);
        xlabel('Wert')
        ylabel('Offset')
        set(gca,'XLim',[270 400]);
        set(gca,'YLim',[0 6]);%
        legend('CO','MS')
        subtitle('R2 - Offset')


% 



        figure(2)
        subplot(221)
        h1 = histogram(y_CO_R1_WM_Slope,'BinWidth',200);
        hold on
        h2 = histogram(y_MS_R1_WM_Slope,'BinWidth',200);
        xlabel('Wert')
        ylabel('Slope')
        legend('CO','MS')
        set(gca,'YLim',[0 2.5]);%
        subtitle('R1 - Slope')
        sgtitle('Slope und Offset Vergleich: WM')




        subplot(222)
        h1 = histogram(y_CO_R1_WM_Offset,'BinWidth',4);
        hold on
        h2 = histogram(y_MS_R1_WM_Offset,'BinWidth',4);
        xlabel('Wert')
        ylabel('Offset')
        set(gca,'YLim',[0 4]);%
        legend('CO','MS')
        subtitle('R1 - Offset')


        subplot(223)
        h1 = histogram(y_CO_R2_WM_Slope,'BinWidth',200);
        hold on
        h2 = histogram(y_MS_R2_WM_Slope,'BinWidth',200);
        xlabel('Wert')
        ylabel('Slope')
        set(gca,'YLim',[0 4]);%
        legend('CO','MS')
        subtitle('R2 - Slope')



        subplot(224)
        h1 = histogram(y_CO_R2_WM_Offset,'BinWidth',20);
        hold on
        h2 = histogram(y_MS_R2_WM_Offset,'BinWidth',20);
        xlabel('Wert')
        ylabel('Offset')
        set(gca,'YLim',[0 8]);%
        legend('CO','MS')
        subtitle('R2 - Offset')



%        figure(2)
%         subplot(221)
%         h1 = histogram(y_CO_R1_WM_Slope);
%         hold on
%         h2 = histogram(y_MS_R1_WM_Slope);
%         xlabel('Wert')
%         ylabel('Slope')
%         legend('CO','MS')
%         subtitle('R1 - Slope')
%         sgtitle('Slope und Offset Vergleich: WM')
% 
% 
% 
% 
%         subplot(222)
%         h1 = histogram(y_CO_R1_WM_Offset);
%         hold on
%         h2 = histogram(y_MS_R1_WM_Offset);
%         xlabel('Wert')
%         ylabel('Offset')
%         legend('CO','MS')
%         subtitle('R1 - Offset')
% 
% 
%         subplot(223)
%         h1 = histogram(y_CO_R2_WM_Slope);
%         hold on
%         h2 = histogram(y_MS_R2_WM_Slope);
%         xlabel('Wert')
%         ylabel('Slope')
%         legend('CO','MS')
%         subtitle('R2 - Slope')
% 
% 
% 
%         subplot(224)
%         h1 = histogram(y_CO_R2_WM_Offset);
%         hold on
%         h2 = histogram(y_MS_R2_WM_Offset);
%         xlabel('Wert')
%         ylabel('Offset')
%         legend('CO','MS')
%         subtitle('R2 - Offset')




%         histogram(y_CO_R1_GM_Slope)
% %         boxplot(y_CO_R1_GM_Slope)
%         data = [y_CO_R1_GM_Slope', y_MS_R1_GM_Slope'];
% 
%         u=mean(y_CO_R1_GM_Slope);
%         v=std(y_CO_R1_GM_Slope);%计算期望方差
%         h=max(y_CO_R1_GM_Slope)-min(y_CO_R1_GM_Slope); %计算极差
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%以下做频率图%%%%%%%
%         d=h/10; %将数据范围等分成十个区间，计算小区间的长度
%         [n,x]=hist(y_CO_R1_GM_Slope,10);%计算每个小区间内的频数及区间中点值
%         f=n/length(y_CO_R1_GM_Slope);
%         %计算频率
%         f1=f/d;
%         %频率除以分割区间的长度
%         bar(x,f1)
%         %画出频率的柱状图
%         hold on 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%以下做密度函数图像%%%%%
%         x1=min(y_CO_R1_GM_Slope):0.1:max(y_CO_R1_GM_Slope);
%         y=normpdf(x1,u,v);
%         plot(x1,y,'r','LineWidth',5)%叠加正态分布密度函数

%         
%        figure(1);
%        e2 = std(y_MS_R1_GM_Slope)*ones(size(x2));
%        bar(y_MS_R1_GM_Slope,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R1_GM_Slope,e2,'red')
%        hold on
%        e1 = std(y_CO_R1_GM_Slope)*ones(size(x1));
%        bar(y_CO_R1_GM_Slope,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R1_GM_Slope,e1,'blue')       
%        legend('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Slope')
%        title('R1 VS S0, GM, Slope')
% 
% 
%        figure(2);
%        e2 = std(y_MS_R1_GM_Offset)*ones(size(x2));
%        bar(y_MS_R1_GM_Offset,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R1_GM_Offset,e2,'red')
%        hold on
%        e1 = std(y_CO_R1_GM_Offset)*ones(size(x1));
%        bar(y_CO_R1_GM_Offset,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R1_GM_Offset,e1,'blue')       
%        legend ('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Offset')
%        title  ('R1 VS S0, GM, Offset')
% 
%        figure(3);
%        e2 = std(y_MS_R2_GM_Slope)*ones(size(x2));
%        bar(y_MS_R2_GM_Slope,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R2_GM_Slope,e2,'red')
%        hold on
%        e1 = std(y_CO_R2_GM_Slope)*ones(size(x1));
%        bar(y_CO_R2_GM_Slope,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R2_GM_Slope,e1,'blue')       
%        legend('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Slope')
%        title  ('R2 VS S0, GM, Slope')
% 
%        
%        figure(4);
%        e2 = std(y_MS_R2_GM_Offset)*ones(size(x2));
%        bar(y_MS_R2_GM_Offset,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R2_GM_Offset,e2,'red')
%        hold on
%        e1 = std(y_CO_R2_GM_Offset)*ones(size(x1));
%        bar(y_CO_R2_GM_Offset,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R2_GM_Offset,e1,'blue')       
%        legend ('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Offset')
%        title  ('R2 VS S0, GM, Offset')
% 
%        figure(5);
%        e2 = std(y_MS_R1_WM_Slope)*ones(size(x2));
%        bar(y_MS_R1_WM_Slope,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R1_WM_Slope,e2,'red')
%        hold on
%        e1 = std(y_CO_R1_WM_Slope)*ones(size(x1));
%        bar(y_CO_R1_WM_Slope,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R1_WM_Slope,e1,'blue')       
%        legend('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Slope')
%        title('R1 VS S0, WM, Slope')
% 
% 
%        figure(6);
%        e2 = std(y_MS_R1_WM_Offset)*ones(size(x2));
%        bar(y_MS_R1_WM_Offset,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R1_WM_Offset,e2,'red')
%        hold on
%        e1 = std(y_CO_R1_WM_Offset)*ones(size(x1));
%        bar(y_CO_R1_WM_Offset,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R1_WM_Offset,e1,'blue')       
%        legend ('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Offset')
%        title  ('R1 VS S0, WM, Offset')
% 
%        figure(7);
%        e2 = std(y_MS_R2_WM_Slope)*ones(size(x2));
%        bar(y_MS_R2_WM_Slope,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R2_WM_Slope,e2,'red')
%        hold on
%        e1 = std(y_CO_R2_WM_Slope)*ones(size(x1));
%        bar(y_CO_R2_WM_Slope,0.4,'blue','grouped')
%        hold on
%        errorbar(x1,y_CO_R2_WM_Slope,e1,'blue')       
%        legend('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Slope')
%        title  ('R2 VS S0, WM, Slope')
% 
%        
%        figure(8);
%        e1 = std(y_CO_R2_WM_Offset)*ones(size(x1));
%        bar(y_CO_R2_WM_Offset,0.4,'blue','grouped')
%        hold on
%        e2 = std(y_MS_R2_WM_Offset)*ones(size(x2));
%        bar(y_MS_R2_WM_Offset,0.6,'red','grouped')
%        hold on
%        errorbar(x2,y_MS_R2_WM_Offset,e2,'red')
%        hold on
%        errorbar(x1,y_CO_R2_WM_Offset,e1,'blue')       
%        legend ('CO','Standardabweichung der CO','MS','Standardabweichung der MS')
%        xlabel ('Probe')
%        ylabel ('Offset')
%        title  ('R2 VS S0, WM, Offset')
% 
