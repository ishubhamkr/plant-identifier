clear all;
close all;
clc;
%%


Labels={'Pubescent Bamboo Plant','Orchid Tree Plant','Peepal Plant','Lemon Plant','Tamarind Plant','Hibiscus Plant',...
'Vinca Rosea Plant','Jackfruit Plant','Waterplant Plant','Chinese Redbud Plant'};
p=1;
[file,path] = uigetfile('*.jpg','Pick an Image File');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    img=imread([path file]);
    
    indx=find(file=='.');

    num=str2num(file(1:indx-1));
    
    figure(1),imshow(img),title('Input Image');
 %   web('Untitled.html');
end


if(num>=1 & num<=11)
    LName='Pubescent Bamboo Plant';
elseif((num>=17) & (num<=20))
    LName='Orchid Tree Plant';
elseif(num==26)
    LName='Peepal Plant';
elseif((num>=32) & (num<=35))
    LName='Lemon Plant';
elseif((num>=36) & (num<=45))
    LName='Tamarind Plant';
elseif((num>=47) & (num<=55))
    LName='Hibiscus Plant';
elseif((num>=61) & (num<=67))
    LName='Vinca Rosea Plant';
elseif((num>=73) & (num<=79))
    LName='Jackfruit Plant';
elseif((num>=85) & (num<=90))
    LName='Waterplant Plant';
elseif((num>=91) & (num<=100))
    LName='Chinese Redbud Plant';
end
    
[feature_test,bw]=extract_features(img);

bw = bwmorph(bw,'dilate');
bw = bwareaopen(bw,200);
bw = imfill(bw,'holes');
[L,count]=bwlabel(bw);
    if(count>=2)
    errordlg('Please Select the Leaf Image with clear Background');
    error('Please Select the Leaf Image with clear Background');
    end
%%
load('Train_KNN.mat');
[predict_label] = predict(mdl_knn,feature_test);
%%disp('KNN');
%%disp(strcat('Matching with:=  ', Labels{predict_label})); 
strng=['KNN Matching with:=  ', Labels{predict_label} newline]; 

KNNPred=0;
if(strcmp(Labels{predict_label},LName))
    KNNPred=1;
end
    

%%
load('Train_NB.mat');
[predict_label] = predict(mdl_nb,feature_test);
%%disp('NB');
%%disp(strcat('Matching with:=  ', Labels{predict_label})); 

NBPred=0;
if(strcmp(Labels{predict_label},LName))
    NBPred=1;
end

if(NBPred==1 & KNNPred==1)
    Corct='Both Classifiers are Right';
elseif(NBPred==1)
    Corct='Only NB is Right';
elseif(KNNPred==1)
    Corct='Only KNN is Right';
else
    Corct='Both Classifiers are wrong';
end

msgbox({strng;['NB Matching with:=  ', Labels{predict_label}];Corct},'RESULT'); 
%%
