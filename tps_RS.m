
clear
close all
%-------
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
% %%%%%%%%%%%%really useful
fcolor=getColor(hsvFile);
%%%%
lmIndex=[23788 23812 23863 24105 24898 17346 16342 16387 15121 12596 10823 9322 10291 10601 2999 14747 14993];
%k i j l p o  m n q s r t v w z x y
lm=points3D(lmIndex,:,:);
%fcolor(lmIndex,:,:,1)=255;

%%%%%%
person=100;
lmTargetFile='/Users/taoxianming/Documents/face_3D/RS/mat/mat_vtx_g/RS_male_landmarks_mat.txt';
lmTarget0=dlmread(lmTargetFile,' ');
lmTarget0=lmTarget0(person,2:end);
lmTarget=[];
for i=1:length(lmIndex)
    lmTarget=[lmTarget;lmTarget0(1,i*3-2:i*3)];
end

%%%%%%%%%%%%
%origin display
figure(1),hold on,axis equal
patch('Vertices',points3D,'Faces',faceStruct,'FaceVertexCData',fcolor,...
 'FaceColor','interp','EdgeColor','none');
plot3(lm(:,1),lm(:,2),lm(:,3),'g*');
plot3(lmTarget(:,1),lmTarget(:,2),lmTarget(:,3),'ro');
%%tps
lm_tps = tps3d(lm,lm,lmTarget);
points3D_tps = tps3d(points3D, lm, lmTarget);
%%%%move and plot
shift = -180;
points3D_tps(:,1)=points3D_tps(:,1)+shift;
lm_tps(:,1)=lm_tps(:,1)+shift;
%%%%plot
patch('Vertices',points3D_tps,'Faces',faceStruct,'FaceVertexCData',fcolor,...
 'FaceColor','interp','EdgeColor','none');
plot3(lm_tps(:,1),lm_tps(:,2),lm_tps(:,3),'ro');
mouse3d

% %%%%%%%%%%%%%%%%
% %%origin display
% figure(1),hold on,axis equal
% trimesh(faceStruct,points3D(:,1),points3D(:,2), points3D(:,3));
% plot3(lm(:,1),lm(:,2),lm(:,3),'g*');
% plot3(lmTarget(:,1),lmTarget(:,2),lmTarget(:,3),'ro'); 
% view(-150,-40);
% title('Orininal mesh vs. warped mesh')
% xlabel('x'),ylabel('y'),zlabel('z');
% 
% %%%%%landmarks and all 3D points TPS
% lm_tps = tps3d(lm,lm,lmTarget);
% points3D_tps = tps3d(points3D, lm, lmTarget);
%  
% %figure(2),hold on,axis equal
% shift = -180;
% trimesh(faceStruct,points3D_tps(:,1)+shift,points3D_tps(:,2), points3D_tps(:,3));
% plot3(lm_tps(:,1)+shift,lm_tps(:,2),lm_tps(:,3),'ro');
% %set green 
% width=1000;height=1000;
% left=200;%left down horizontal distance
% bottem=100;%left down vertical distance
% set(gcf,'position',[left,bottem,width,height])
% mouse3d
% 
% 
% 
% 
% 
