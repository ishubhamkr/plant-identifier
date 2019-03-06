clc;
clear all;
close all;



Data_Path = [pwd,'\Training\'];
folders = dir(Data_Path);
numFolders = numel(folders);

k=1;
for pp = 3:numFolders    
    folderName=folders(pp).name;   
    imgFilepth = strcat(Data_Path, '\', folderName);      
    files = dir([imgFilepth '\' '*.jpg']);
    numFiles = numel(files);    
 for i= 1:5                                % here we need to place that one test image out of 100 images
    fileName = files(i).name;    
    imgFileName = strcat(imgFilepth, '\', fileName); 
    img=imread(imgFileName);
    [feature,b]=extract_features(img); 
    feature_matrix(k,:) = feature;
    feature_label(k,1)=str2num(folderName);
    k=k+1;    
 end

end


mdl_knn = fitcknn(feature_matrix,feature_label,'NumNeighbors',1);
save('Train_KNN.mat','mdl_knn','feature_matrix','feature_label');

mdl_nb = fitcnb(feature_matrix,feature_label);
save('Train_NB.mat','mdl_nb','feature_matrix','feature_label');
