clear all
close all
clc
%% 拟合空间直线
%% 输入数据

for i = 5:17
    if i <=9
%         plotn = i;
        
%         subplot(3,5,plotn)
        TitleName1 = ['MSLOW000',num2str(i),': R1 und S0, Slope Martrix, WM'];
        TitleName2 = ['MSLOW000',num2str(i),': R1 und S0, Offset Martrix, WM'];
        TitleName3 = ['MSLOW000',num2str(i),': R2 und S0, Slope Martrix, WM'];
        TitleName4 = ['MSLOW000',num2str(i),': R2 und S0, Offset Martrix, WM'];
        WM_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW000',num2str(i),'\Datei_JJia\WM_000',num2str(i),'.mat']);
        S0_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW000',num2str(i),'\Datei_JJia\S0_Map_000',num2str(i),'.mat']);
        T1_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW000',num2str(i),'\Datei_JJia\T1_After_Denoising_Raum_000',num2str(i),'.mat']);
        T2_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW000',num2str(i),'\Datei_JJia\T2_Stern_Map_000',num2str(i),'.mat']);

        na1 = fieldnames(WM_f);
        na2 = fieldnames(S0_f);
        na3 = fieldnames(T1_f);
        na4 = fieldnames(T2_f);
        WM = getfield(WM_f,char(na1));
        S0 = getfield(S0_f,char(na2));
        T1 = getfield(T1_f,char(na3));
        T2 = getfield(T2_f,char(na4));

        T1_Map       = T1 .* WM;
        S0_Map       = S0 .* WM;
        T2_Stern_Map = T2 .* WM;



        %% 用0代替inf
        R1=inf_0(T1_Map);
        R1=1/R1;
        [m1,n1,p1]=size(T1_Map);
            for i11=1:m1
                for j11=1:n1
                    for k11=1:p1
                        if isinf(R1(i11,j11,k11))
                            R1(i11,j11,k11)=0;  
                        end
                    end
                end
            end
        
        S0=inf_0(S0_Map);

        R2=inf_0(T2_Stern_Map);
        R2=1/R2;
            for i11=1:m1
                for j11=1:n1
                    for k11=1:p1
                        if isinf(R2(i11,j11,k11))
                            R2(i11,j11,k11)=0;  
                        end
                    end
                end
            end
        
        

            %% 
        n=5   %5*5像素点,为奇数
        [a,b,c]=size(R1);
        para1=zeros(a,b,c);%新建0矩阵，R1 与 S0 回归得到的斜率
        para2=zeros(a,b,c);%新建0矩阵，R1 与 S0 回归得到的截距
        para3=zeros(a,b,c);%新建0矩阵，R2 与 S0 回归得到的斜率
        para4=zeros(a,b,c);%新建0矩阵，R2 与 S0 回归得到的截距
        nn=(n-1)/2;
        yeah=0;
        for k=1:15
            for inn=nn+1:a-nn
                for j=nn+1:b-nn
                    x1=reshape(R1(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    x2=reshape(R2(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    y=reshape(S0(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    if sum(sum(x1~=0))>5
                        A=polyfit(x1,y,1); %斜率和截距 用R1 S0拟合
                        B=polyfit(x2,y,1);%斜率和截距 用R2 S0拟合
                        para1(inn,j,k)=A(1,1);%R1 与 S0 回归得到的斜率
                        para2(inn,j,k)=A(1,2);%R1 与 S0 回归得到的截距
                        para3(inn,j,k)=B(1,1);%R2 与 S0 回归得到的斜率
                        para4(inn,j,k)=B(1,2);%R2 与 S0 回归得到的截距
                        yeah=yeah+1;%用来统计有效点个数*********************************用来统计有效点个数**********************************注意看！！！！！！！！！
                    end
                 end
            end
        end
        
        
        
        
        figure ()
        subplot (351)
        imagesc(para1(:,:,1), [0 200000]); colormap(gray); colorbar
        subplot (352)
        imagesc(para1(:,:,2), [0 200000]); colormap(gray); colorbar
        subplot (353)
        imagesc(para1(:,:,3), [0 200000]); colormap(gray); colorbar
        subplot (354)
        imagesc(para1(:,:,4), [0 200000]); colormap(gray); colorbar
        subplot (355)
        imagesc(para1(:,:,5), [0 200000]); colormap(gray); colorbar
        subplot (356)
        imagesc(para1(:,:,6), [0 200000]); colormap(gray); colorbar
        subplot (357)
        imagesc(para1(:,:,7), [0 200000]); colormap(gray); colorbar
        subplot (358)
        imagesc(para1(:,:,8), [0 200000]); colormap(gray); colorbar
        subplot (359)
        imagesc(para1(:,:,9), [0 200000]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para1(:,:,10), [0 200000]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para1(:,:,11), [0 200000]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para1(:,:,12), [0 200000]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para1(:,:,13), [0 200000]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para1(:,:,14), [0 200000]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para1(:,:,15), [0 200000]); colormap(gray); colorbar;
        sgtitle(TitleName1);
        savename1 = ['MS,WM',num2str(i),'-1.jpg'];
        saveas(gcf,savename1)
        
        figure ()
        subplot (351)
        imagesc(para2(:,:,1), [0 500]); colormap(gray); colorbar
        subplot (352)
        imagesc(para2(:,:,2), [0 500]); colormap(gray); colorbar
        subplot (353)
        imagesc(para2(:,:,3), [0 500]); colormap(gray); colorbar
        subplot (354)
        imagesc(para2(:,:,4), [0 500]); colormap(gray); colorbar
        subplot (355)
        imagesc(para2(:,:,5), [0 500]); colormap(gray); colorbar
        subplot (356)
        imagesc(para2(:,:,6), [0 500]); colormap(gray); colorbar
        subplot (357)
        imagesc(para2(:,:,7), [0 500]); colormap(gray); colorbar
        subplot (358)
        imagesc(para2(:,:,8), [0 500]); colormap(gray); colorbar
        subplot (359)
        imagesc(para2(:,:,9), [0 500]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para2(:,:,10), [0 500]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para2(:,:,11), [0 500]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para2(:,:,12), [0 500]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para2(:,:,13), [0 500]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para2(:,:,14), [0 500]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para2(:,:,15), [0 500]); colormap(gray); colorbar;
        sgtitle( TitleName2);
        savename2 = ['MS,WM',num2str(i),'-2.jpg'];
        saveas(gcf,savename2)
        
        
        
        figure()
        subplot (351)
        imagesc(para3(:,:,1), [0 50000]); colormap(gray); colorbar
        subplot (352)
        imagesc(para3(:,:,2), [0 50000]); colormap(gray); colorbar
        subplot (353)
        imagesc(para3(:,:,3), [0 50000]); colormap(gray); colorbar
        subplot (354)
        imagesc(para3(:,:,4), [0 50000]); colormap(gray); colorbar
        subplot (355)
        imagesc(para3(:,:,5), [0 50000]); colormap(gray); colorbar
        subplot (356)
        imagesc(para3(:,:,6), [0 50000]); colormap(gray); colorbar
        subplot (357)
        imagesc(para3(:,:,7), [0 50000]); colormap(gray); colorbar
        subplot (358)
        imagesc(para3(:,:,8), [0 50000]); colormap(gray); colorbar
        subplot (359)
        imagesc(para3(:,:,9), [0 50000]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para3(:,:,10), [0 50000]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para3(:,:,11), [0 50000]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para3(:,:,12), [0 50000]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para3(:,:,13), [0 50000]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para3(:,:,14), [0 50000]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para3(:,:,15), [0 50000]); colormap(gray); colorbar;
        sgtitle(TitleName3);
        savename3 = ['MS,WM',num2str(i),'-3.jpg'];
        saveas(gcf,savename3)


        figure ()
        subplot (351)
        imagesc(para4(:,:,1), [0 400]); colormap(gray); colorbar
        subplot (352)
        imagesc(para4(:,:,2), [0 400]); colormap(gray); colorbar
        subplot (353)
        imagesc(para4(:,:,3), [0 400]); colormap(gray); colorbar
        subplot (354)
        imagesc(para4(:,:,4), [0 400]); colormap(gray); colorbar
        subplot (355)
        imagesc(para4(:,:,5), [0 400]); colormap(gray); colorbar
        subplot (356)
        imagesc(para4(:,:,6), [0 400]); colormap(gray); colorbar
        subplot (357)
        imagesc(para4(:,:,7), [0 400]); colormap(gray); colorbar
        subplot (358)
        imagesc(para4(:,:,8), [0 400]); colormap(gray); colorbar
        subplot (359)
        imagesc(para4(:,:,9), [0 400]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para4(:,:,10), [0 400]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para4(:,:,11), [0 400]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para4(:,:,12), [0 400]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para4(:,:,13), [0 400]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para4(:,:,14), [0 400]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para4(:,:,15), [0 400]); colormap(gray); colorbar;
        sgtitle(TitleName4);
        savename4 = ['MS,WM',num2str(i),'-4.jpg'];
        saveas(gcf,savename4)
        i


else
        TitleName1 = ['MSLOW000',num2str(i),': R1 und S0, Slope Martrix, WM'];
        TitleName2 = ['MSLOW000',num2str(i),': R1 und S0, Offset Martrix, WM'];
        TitleName3 = ['MSLOW000',num2str(i),': R2 und S0, Slope Martrix, WM'];
        TitleName4 = ['MSLOW000',num2str(i),': R2 und S0, Offset Martrix, WM'];
        
        WM_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW00',num2str(i),'\Datei_JJia\WM_00',num2str(i),'.mat']);
        S0_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW00',num2str(i),'\Datei_JJia\S0_Map_00',num2str(i),'.mat']);
        T1_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW00',num2str(i),'\Datei_JJia\T1_After_Denoising_Raum_00',num2str(i),'.mat']);
        T2_f = load(['C:\Users\Jannik Jia\OneDrive - rheinahrcampus.de\Bachelorarbeit\T1Optimisation\MSLOW00',num2str(i),'\Datei_JJia\T2_Stern_Map_00',num2str(i),'.mat']);

        na1 = fieldnames(WM_f);
        na2 = fieldnames(S0_f);
        na3 = fieldnames(T1_f);
        na4 = fieldnames(T2_f);
        WM = getfield(WM_f,char(na1));
        S0 = getfield(S0_f,char(na2));
        T1 = getfield(T1_f,char(na3));
        T2 = getfield(T2_f,char(na4));
     
        T1_Map       = T1 .* WM;
        S0_Map       = S0 .* WM;
        T2_Stern_Map = T2 .* WM;

        

        %% 用0代替inf
        R1=inf_0(T1_Map);
        R1=1/R1;
        [m1,n1,p1]=size(T1_Map);
            for i11=1:m1
                for j11=1:n1
                    for k11=1:p1
                        if isinf(R1(i11,j11,k11))
                            R1(i11,j11,k11)=0;  
                        end
                    end
                end
            end
        
        S0=inf_0(S0_Map);

        R2=inf_0(T2_Stern_Map);
        R2=1/R2;
            for i11=1:m1
                for j11=1:n1
                    for k11=1:p1
                        if isinf(R2(i11,j11,k11))
                            R2(i11,j11,k11)=0;  
                        end
                    end
                end
            end
        
        

            %% 
        n=5   %5*5像素点,为奇数
        [a,b,c]=size(R1);
        para1=zeros(a,b,c);%新建0矩阵，R1 与 S0 回归得到的斜率
        para2=zeros(a,b,c);%新建0矩阵，R1 与 S0 回归得到的截距
        para3=zeros(a,b,c);%新建0矩阵，R2 与 S0 回归得到的斜率
        para4=zeros(a,b,c);%新建0矩阵，R2 与 S0 回归得到的截距
        nn=(n-1)/2;
        yeah=0;
        for k=1:15
            for inn=nn+1:a-nn
                for j=nn+1:b-nn
                    x1=reshape(R1(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    x2=reshape(R2(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    y=reshape(S0(inn-nn:inn+nn,j-nn:j+nn,k),1,[]);
                    if sum(sum(x1~=0))>5
                        A=polyfit(x1,y,1); %斜率和截距 用R1 S0拟合
                        B=polyfit(x2,y,1);%斜率和截距 用R2 S0拟合
                        para1(inn,j,k)=A(1,1);%R1 与 S0 回归得到的斜率
                        para2(inn,j,k)=A(1,2);%R1 与 S0 回归得到的截距
                        para3(inn,j,k)=B(1,1);%R2 与 S0 回归得到的斜率
                        para4(inn,j,k)=B(1,2);%R2 与 S0 回归得到的截距
                        yeah=yeah+1;%用来统计有效点个数*********************************用来统计有效点个数**********************************注意看！！！！！！！！！
                    end
                 end
            end
        end
        
        
        
        
        figure ()
        subplot (351)
        imagesc(para1(:,:,1), [0 200000]); colormap(gray); colorbar
        subplot (352)
        imagesc(para1(:,:,2), [0 200000]); colormap(gray); colorbar
        subplot (353)
        imagesc(para1(:,:,3), [0 200000]); colormap(gray); colorbar
        subplot (354)
        imagesc(para1(:,:,4), [0 200000]); colormap(gray); colorbar
        subplot (355)
        imagesc(para1(:,:,5), [0 200000]); colormap(gray); colorbar
        subplot (356)
        imagesc(para1(:,:,6), [0 200000]); colormap(gray); colorbar
        subplot (357)
        imagesc(para1(:,:,7), [0 200000]); colormap(gray); colorbar
        subplot (358)
        imagesc(para1(:,:,8), [0 200000]); colormap(gray); colorbar
        subplot (359)
        imagesc(para1(:,:,9), [0 200000]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para1(:,:,10), [0 200000]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para1(:,:,11), [0 200000]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para1(:,:,12), [0 200000]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para1(:,:,13), [0 200000]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para1(:,:,14), [0 200000]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para1(:,:,15), [0 200000]); colormap(gray); colorbar;
        sgtitle(TitleName1);
        savename1 = ['MS,WM',num2str(i),'-1.jpg'];
        saveas(gcf,savename1)

        figure ()
        subplot (351)
        imagesc(para2(:,:,1), [0 500]); colormap(gray); colorbar
        subplot (352)
        imagesc(para2(:,:,2), [0 500]); colormap(gray); colorbar
        subplot (353)
        imagesc(para2(:,:,3), [0 500]); colormap(gray); colorbar
        subplot (354)
        imagesc(para2(:,:,4), [0 500]); colormap(gray); colorbar
        subplot (355)
        imagesc(para2(:,:,5), [0 500]); colormap(gray); colorbar
        subplot (356)
        imagesc(para2(:,:,6), [0 500]); colormap(gray); colorbar
        subplot (357)
        imagesc(para2(:,:,7), [0 500]); colormap(gray); colorbar
        subplot (358)
        imagesc(para2(:,:,8), [0 500]); colormap(gray); colorbar
        subplot (359)
        imagesc(para2(:,:,9), [0 500]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para2(:,:,10), [0 500]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para2(:,:,11), [0 500]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para2(:,:,12), [0 500]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para2(:,:,13), [0 500]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para2(:,:,14), [0 500]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para2(:,:,15), [0 500]); colormap(gray); colorbar;
        sgtitle( TitleName2);
        savename2 = ['MS,WM',num2str(i),'-2.jpg'];
        saveas(gcf,savename2)
        
        
        
        
        figure()
        subplot (351)
        imagesc(para3(:,:,1), [0 50000]); colormap(gray); colorbar
        subplot (352)
        imagesc(para3(:,:,2), [0 50000]); colormap(gray); colorbar
        subplot (353)
        imagesc(para3(:,:,3), [0 50000]); colormap(gray); colorbar
        subplot (354)
        imagesc(para3(:,:,4), [0 50000]); colormap(gray); colorbar
        subplot (355)
        imagesc(para3(:,:,5), [0 50000]); colormap(gray); colorbar
        subplot (356)
        imagesc(para3(:,:,6), [0 50000]); colormap(gray); colorbar
        subplot (357)
        imagesc(para3(:,:,7), [0 50000]); colormap(gray); colorbar
        subplot (358)
        imagesc(para3(:,:,8), [0 50000]); colormap(gray); colorbar
        subplot (359)
        imagesc(para3(:,:,9), [0 50000]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para3(:,:,10), [0 50000]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para3(:,:,11), [0 50000]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para3(:,:,12), [0 50000]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para3(:,:,13), [0 50000]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para3(:,:,14), [0 50000]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para3(:,:,15), [0 50000]); colormap(gray); colorbar;
        sgtitle(TitleName3);
        savename3 = ['MS,WM',num2str(i),'-3.jpg'];
        saveas(gcf,savename3)



        figure ()
        subplot (351)
        imagesc(para4(:,:,1), [0 400]); colormap(gray); colorbar
        subplot (352)
        imagesc(para4(:,:,2), [0 400]); colormap(gray); colorbar
        subplot (353)
        imagesc(para4(:,:,3), [0 400]); colormap(gray); colorbar
        subplot (354)
        imagesc(para4(:,:,4), [0 400]); colormap(gray); colorbar
        subplot (355)
        imagesc(para4(:,:,5), [0 400]); colormap(gray); colorbar
        subplot (356)
        imagesc(para4(:,:,6), [0 400]); colormap(gray); colorbar
        subplot (357)
        imagesc(para4(:,:,7), [0 400]); colormap(gray); colorbar
        subplot (358)
        imagesc(para4(:,:,8), [0 400]); colormap(gray); colorbar
        subplot (359)
        imagesc(para4(:,:,9), [0 400]); colormap(gray); colorbar
        subplot (3,5,10)
        imagesc(para4(:,:,10), [0 400]); colormap(gray); colorbar
        subplot (3,5,11)
        imagesc(para4(:,:,11), [0 400]); colormap(gray); colorbar
        subplot (3,5,12)
        imagesc(para4(:,:,12), [0 400]); colormap(gray); colorbar
        subplot (3,5,13)
        imagesc(para4(:,:,13), [0 400]); colormap(gray); colorbar
        subplot (3,5,14)
        imagesc(para4(:,:,14), [0 400]); colormap(gray); colorbar
        subplot (3,5,15)
        imagesc(para4(:,:,15), [0 400]); colormap(gray); colorbar;
        sgtitle(TitleName4);
        savename4 = ['MS,WM',num2str(i),'-4.jpg'];
        saveas(gcf,savename4)
        i
    end
end

