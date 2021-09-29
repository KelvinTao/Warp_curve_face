%clc
clear
close all
%-------
%scriptPath='D:\script23D\obj_display\obj_disp';
scriptPath='/Users/taoxianming/Documents/face_3D/script23D/imageProcess/RBF_3dwarping_tao';
addpath(scriptPath);


%%%%%%datapath
sex='male';  %male
meanPath='/Users/taoxianming/Documents/face_3D/RS/3D/mean';
vFile=strcat(meanPath,'/',sex,'RD_vtx_g_IID_mat.mean.txt');
hsvFile=strcat(meanPath,'/',sex,'RD_hsv_mat.mean.txt');
faceFile=strcat(meanPath,'/face_structure.txt');

points3D=dlmread(vFile,' ');
faceStruct=readFace(faceFile);
%%%%test landmark
lmIndex =1000:2000:30000;
lm=points3D(lmIndex,:);
%move some landmarks
lmTarget = lm;
lmTarget(end-5:end,2) = lmTarget(end-5:end,2)-20;
lmTarget(end-14:end,2) = lmTarget(end-14:end,2)+10;
%%%%display
figure(1),hold on,axis equal
trimesh(faceStruct,points3D(:,1),points3D(:,2), points3D(:,3));
plot3(lm(:,1),lm(:,2),lm(:,3),'k*');
plot3(lmTarget(:,1),lmTarget(:,2),lmTarget(:,3),'ro'); 
view(-150,-40);
title('Orininal mesh vs. warped mesh')
xlabel('x'),ylabel('y'),zlabel('z');
%legend('Point set','Source landmarks','Destination landmarks')

%%%%% TPS: landmarks and all 3D points
lm_tps = tps3d(lm,lm,lmTarget);
points3D_tps = tps3d(points3D, lm, lmTarget);
 
%figure(2),hold on,axis equal
shift = -180;
trimesh(faceStruct,points3D_tps(:,1)+shift,points3D_tps(:,2), points3D_tps(:,3));
plot3(lm_tps(:,1)+shift,lm_tps(:,2),lm_tps(:,3),'ro');
%set green 
width=1000;height=1000;
left=200;%left down horizontal distance
bottem=100;%left down vertical distance
set(gcf,'position',[left,bottem,width,height])
mouse3d

% 
% 
% 
% %%%%%%%%%%%%really useful
% fcolor=getColor(hsvFile);
% %%%plot
% figure;width=1000;height=1000;
% left=200;%left down horizontal distance
% bottem=100;%left down vertical distance
% patch('Vertices',points3D,'Faces',faceStruct,'FaceVertexCData',fcolor,...
% 'FaceColor','interp','EdgeColor','none');axis equal;axis off;
% set(gcf,'position',[left,bottem,width,height])%screen
% set(gca,'position',[0,0,1,1])%axis partion
% mouse3d
% %saveas(gcf,strcat(meanPath,'/RS_',sex,'.mean.png'));
% %close
% % view(0,90);saveas(gcf,strcat(meanPath,'/RS_',sex,'.front.jpg'));
% % view(90,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.left.jpg'));
% % view(-90,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.right.jpg'));
% % view(45,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.left45.jpg'));
% % view(-45,0);saveas(gcf,strcat(meanPath,'/RS_',sex,'.right45.jpg'));
% %close all