
clear
close all
%-------
scriptPath='/Users/taoxianming/Documents/face_3D/script23D/RBF_3dwarping_tao';
addpath(scriptPath);

%%%%%%datapath
sex='male';  %male
meanPath='/Users/taoxianming/Documents/face_3D/RS/3D/mean';
vFile=strcat(meanPath,'/',sex,'RD_vtx_g_IID_mat.mean.txt');
hsvFile=strcat(meanPath,'/',sex,'RD_hsv_mat.mean.txt');
faceFile=strcat(meanPath,'/face_structure.txt');

mean3D=dlmread(vFile,' ');
faceStruct=readFace(faceFile);
% %%%%%%%%%%%%really useful
fcolor=getColor(hsvFile);
%%%%%%%%%%%%%%%%%%%%lmIndex=[23788 23812 23863 24105 24898 17346 16342 16387 15121 12596 10823 9322 10291 10601 2999 14747 14993];
%%%%%later accurate: k i j l p o  m n q s r t v w z x y
lmIndex=[23786 23814 23860 23890 24265 17346 16834 16879 15121 12596 10823 9073 10292 10349 3206 14999 15245];
%k i j l p o  m n q s r t v w z x y
lm=mean3D(lmIndex,:,:);
%lm=lm(1:end-2,:);%%remove x y
%fcolor(lmIndex,:,:,1)=255;
lmTargetFile=strcat('/Users/taoxianming/Documents/face_3D/RS/mat/mat_vtx_g/RS_',sex,'_landmarks_mat.txt');
lmTarget0=dlmread(lmTargetFile,' ');
shift = 180;shift2 =360;%for plot
%%%%%%
for person=1:10
%person=5;
id=num2str(lmTarget0(person,1));
lmTarget1=lmTarget0(person,2:end);
lmTarget=[];
for i=1:length(lmIndex)
    lmTarget=[lmTarget;lmTarget1(1,i*3-2:i*3)];
end
%lmTarget=lmTarget(1:end-2,:);%%remove x y
%%%%%%%%%%%%real 3D
real3DFile=strcat('/Users/taoxianming/Documents/face_3D/RS/mat/mat_vtx_g/RS_',sex,'_',id,'.vtx_g.txt');
real3D=dlmread(real3DFile,' ');

%real figure display
figure,hold on,axis equal
%set green 
width=1000;height=1000;
left=200;%left down horizontal distance
bottem=100;%left down vertical distance
set(gcf,'position',[left,bottem,width,height])
patch('Vertices',real3D,'Faces',faceStruct,'FaceVertexCData',fcolor,...
 'FaceColor','interp','EdgeColor','none');
%%%landmarks
%plot3(lmTarget(:,1),lmTarget(:,2),lmTarget(:,3),'g*');

%%tps
%lm_tps = tps3d(lm,lm,lmTarget);
%mean3D_tps = tps3d(mean3D, lm, lmTarget);

%%%%%tps or gaussian method
r=20;
lm_tps = rbfwarp3d(lm,lm,lmTarget,'gau',r);
mean3D_tps = rbfwarp3d(mean3D, lm, lmTarget,'gau',r);

%%%%move and plot
%shift = 180;
mean3D_tps_plot=mean3D_tps;
mean3D_tps_plot(:,1)=mean3D_tps_plot(:,1)+shift;
%%%%plot
patch('Vertices',mean3D_tps_plot,'Faces',faceStruct,'FaceVertexCData',fcolor,...
 'FaceColor','interp','EdgeColor','none');

% %%%%%landmarks
% lm_tps_plot=lm_tps;
% lm_tps_plot(:,1)=lm_tps_plot(:,1)+shift;
% plot3(lm_tps_plot(:,1),lm_tps_plot(:,2),lm_tps_plot(:,3),'b*');

%%%%%%
%shift2 =360;
mean3D_plot=mean3D;
mean3D_plot(:,1)=mean3D_plot(:,1)+shift2;
patch('Vertices',mean3D_plot,'Faces',faceStruct,'FaceVertexCData',fcolor,...
 'FaceColor','interp','EdgeColor','none');
% %%%landmarks
% lm_plot=lm;
% lm_plot(:,1)=lm_plot(:,1)+shift2;
% plot3(lm_plot(:,1),lm_plot(:,2),lm_plot(:,3),'g*');
% lmTarget_plot=lmTarget;
% lmTarget_plot(:,1)=lmTarget_plot(:,1)+shift2;
% plot3(lmTarget_plot(:,1),lmTarget_plot(:,2),lmTarget_plot(:,3),'b*');

%xlabel('x')
text(-35,150,0,'Real shape','Fontsize',20)
text(135,150,0,'TPS shape','Fontsize',20)
text(315,150,0,'Mean shape','Fontsize',20)
title(['TPS face of ',id],'Fontsize',20)
axis off

%%%%save
saveas(gcf,strcat('/Users/taoxianming/Documents/face_3D/RS/3D/TPS/xiong/RS_',sex,'_',id,'.gau.',num2str(r),'.jpg'))
%saveas(gcf,strcat('/Users/taoxianming/Documents/face_3D/RS/3D/TPS/RS_',sex,'_',id,'noxy.tps.jpg'))
%mouse3d
%hold off
close all
end

