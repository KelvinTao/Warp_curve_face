
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
person=1;
lmTargetFile=strcat('/Users/taoxianming/Documents/face_3D/RS/mat/mat_vtx_g/RS_',sex,'_landmarks_mat.txt');
lmTarget0=dlmread(lmTargetFile,' ');
lmTarget0=lmTarget0(person,2:end);
lmTarget=[];
for i=1:length(lmIndex)
    lmTarget=[lmTarget;lmTarget0(1,i*3-2:i*3)];
end

%%%%%%%%%%%%
%real figure display



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
