function [arr,b]=extract_features(img)
    [row,col,plane]=size(img);
    k=1;
    v=zeros(row,col);
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);
    for i=1:row
        for j=1:col
                  if B(i,j) > 60
                     v(i,j)=1;
                  end
        end
    end
    b = logical(not(v));
    b=imfill(b,'holes');
    
  %%   
   %figure(1),imshow(img);
    pp=rgb2gray(img);
    figure(2),imshow(pp);
     for i=1:row
        for j=1:col
                  if b(i,j) == 0
                     pp(i,j) = 0;
                  end
        end
     end
     
    figure(3),imshow(pp);
    %%
%     res=graycoprops(pp,{'contrast','homogeneity','Correlation','Energy'});
%     arr(k,12)=res.Contrast;
%     arr(k,13)=res.Homogeneity;
%     arr(k,14)=res.Correlation;
%     arr(k,15)=res.Energy;
%     arr(k,16)=entropy(pp);
    results=regionprops(b,'Area','EulerNumber','Orientation','BoundingBox','Extent',...
        'Perimeter','Centroid','Extrema','PixelIdxList','ConvexArea',...
        'FilledArea','PixelList','ConvexHull','FilledImage','Solidity',...
        'ConvexImage','Image','SubarrayIdx','Eccentricity','MajorAxisLength',...
        'EquivDiameter','MinorAxisLength');
    [maxarea,index] = max([results.Area]);
    aspect_ratio = results(index).MajorAxisLength/results(index).MinorAxisLength;
    arr(k,1)=aspect_ratio;
    rectangularity =results(index).Area/aspect_ratio;
    arr(k,2)=rectangularity;
    convex_area_ratio=results(index).Area/results(index).ConvexArea;
    arr(k,3)=convex_area_ratio;
    eccentricity=results(index).Eccentricity;
    arr(k,4)=eccentricity;
    diameter=results(index).EquivDiameter;
    arr(k,5)=diameter;
    form_factor=(4*pi*results(index).Area)/(results(index).Perimeter).^2;
    arr(k,6)=form_factor;
    narrow_factor=diameter/results(index).MajorAxisLength;
    arr(k,7)=narrow_factor;
    perimeter_ratio_length_width=results(index).Perimeter/(results(index).MajorAxisLength+...
    results(index).MinorAxisLength);
    arr(k,8)=perimeter_ratio_length_width;
    Solidity=results(index).Solidity;
    arr(k,9)=Solidity;
    Circularity=results(index).Area/(results(index).Perimeter).^2;
    arr(k,10)=Circularity;
%     if results(index).BoundingBox(3) > results(index).BoundingBox(4)
%         encircle_radius=results(index).BoundingBox(3)/2;
%     else
%         encircle_radius=results(index).BoundingBox(4)/2;
%     end
%     [cir,incircle_radius]=incircle(results(index).ConvexHull(:,1),results(index).ConvexHull(:,2));
%     Irregularity=encircle_radius/incircle_radius;
%     arr(k,11)=Irregularity;
    
end