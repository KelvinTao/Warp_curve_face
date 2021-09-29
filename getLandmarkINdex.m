%clc
clear
close all
%-------
%scriptPath='D:\script23D\obj_display\obj_disp';
scriptPath='/Users/taoxianming/Documents/face_3D/script23D/imageProcess/RBF_3dwarping_tao';
addpath(scriptPath);

%%%%%%datapath
sex='female';  %male
meanPath='/Users/taoxianming/Documents/face_3D/RS/3D/mean';
vFile=strcat(meanPath,'/',sex,'RD_vtx_g_IID_mat.mean.txt');
hsvFile=strcat(meanPath,'/',sex,'RD_hsv_mat.mean.txt');
faceFile=strcat(meanPath,'/face_structure.txt');

points3D=dlmread(vFile,' ');
faceStruct=readFace(faceFile);
%  pointsNum=size(points3D,1);
% pointIndex=1:100:pointsNum;

%lm=points3D(10000,:);
% %%%%%%%%%%%%really useful
fcolor=getColor(hsvFile);
%14870 15373 15372 15370
lmIndex=[23786 23814 23860 23890 24265 17346 16834 16879 15121 12596 10823 9073 10292 10349 3206 14999 15245];
%         k      i     j     l      p    o     m     n      q    s     r     t    v     w     z    x     y

lm=points3D(lmIndex,:,:);
fcolor(lmIndex,:,:,1)=255;
%%plot
figure;hold on
width=1000;height=1000;
left=200;%left down horizontal distance
bottem=100;%left down vertical distance
patch('Vertices',points3D,'Faces',faceStruct,'FaceVertexCData',fcolor,...
'FaceColor','interp','EdgeColor','none');axis equal;%axis off;
set(gcf,'position',[left,bottem,width,height])%screen
%set(gca,'position',[0,0,1,1])%axis partion
% pointsNum=size(points3D,1);
% pointIndex=1:10:pointsNum;
% text(points3D(pointIndex,1),points3D(pointIndex,2),points3D(pointIndex,3),num2str(pointIndex))
%for i=1:size(points3D,1)
%    text(points3D(:,1),points3D(:,2),points3D(:,3),num2str(i))
%end
%view(0,90)
%view(180,180)
%set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);%get coordinate

%point=
%  figure(1),hold on,axis equal
%  trimesh(faceStruct,points3D(:,1),points3D(:,2), points3D(:,3));
%text(points3D(pointIndex,1),points3D(pointIndex,2),points3D(pointIndex,3),num2str(pointIndex))


 plot3(lm(:,1),lm(:,2),lm(:,3),'r*');
 xlabel('x'),ylabel('y'),zlabel('z');
% 
% set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);

% %saveas(gcf,strcat(meanPath,'/RS_',sex,'.mean.png'));
% %close
% % view(0,90);saveas(gcf,strcat(meanPath,'/RS_',sex,'.front.jpg'));
% % view(90,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.left.jpg'));
% % view(-90,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.right.jpg'));
% % view(45,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.left45.jpg'));
% % view(-45,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.right45.jpg'));
% %close all