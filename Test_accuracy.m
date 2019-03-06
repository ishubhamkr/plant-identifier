clc;
clear all;
close all;
%%
%%
Data_Path = [pwd,'\Test\'];
k=1;      
files = dir([Data_Path '\' '*.jpg']);
numFiles = numel(files);    
for i= 1:numFiles                                % here we need to place that one test image out of 100 images
    
    fileName = files(i).name;    
  
    ind=find(fileName=='.');

    num=str2num(fileName(1:ind-1));

    if(num<=11) 

      Tar(i)=1;  

    elseif((num>=17) & (num<=20))

      Tar(i)=2;    

    elseif((num>=26) & (num<=26))    

      Tar(i)=3;

    elseif((num>=32) & (num<=35))

      Tar(i)=4;      

    elseif((num>=36) & (num<=45))

       Tar(i)=5;  

    elseif((num>=47) & (num<=55))

       Tar(i)=6; 

    elseif((num>=61) & (num<=67))

       Tar(i)=7; 

    elseif((num>=73) & (num<=79))

       Tar(i)=8; 

    elseif((num>=85) & (num<=90))

       Tar(i)=9; 
       
    elseif((num>=91) & (num<=100))

       Tar(i)=10; 

    end
    imgFileName = strcat(Data_Path, '\', fileName); 
    img=imread(imgFileName);
    [feature_test,b]=extract_features(img); 
    feature_matrix_test_accu(k,:)=feature_test;
    k=k+1;    
end
disp(Tar(1));

disp(Tar(3));
disp(Tar(4));
Tar=Tar';
load('Train_KNN.mat');
[predict_label] = predict(mdl_knn,feature_matrix_test_accu);
cMat1 = confusionmat(predict_label,Tar);
[Acc] = Result(predict_label,Tar);
%%
fprintf('KNN Accuracy:=%f Percentage\n',Acc*100);
% fprintf('Sensitivity:=%f\n',sensitivity);   % Print the Results on the Command Window
% fprintf('Specificity:=%f\n',specificity);
for i=1:10
res(i)=cMat1(i,i);
y(i)=i;
end
figure(3),plot(y,res,'-ro');
grid on;
x=[length(find(Tar==1)),length(find(Tar==2)),length(find(Tar==3)),length(find(Tar==4)),length(find(Tar==5)),length(find(Tar==6)),length(find(Tar==7)),length(find(Tar==8)),length(find(Tar==9)),length(find(Tar==10))];
hold on;

hold off;
legend('KNN Accuracy','Ground Truth');