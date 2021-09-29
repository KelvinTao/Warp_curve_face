
%clear all
close all
%%%%%%
points3D = load('BustPointWO.txt');
faceStruct = load('BustMeshWO.txt');
faceStruct = faceStruct(:,2:4)+1;



landmarks68 = load('BustPoint_68lmk.txt');

lmIndex = [ 1:27,28,31,34,37,49,52,55,58,43];
pback = [-12,28,5;
          12,28,5;
          0,42.82,-6.454];
lm = landmarks68(lmIndex,:);
lm = [pback;lm];
%move some landmarks
lmTarget = lm;
lmTarget(end-3:end,3) = lmTarget(end-3:end,3)-3;
%%%%display
figure(1),hold on,axis equal
trimesh(faceStruct,points3D(:,1),points3D(:,2), points3D(:,3));
plot3(lm(:,1),lm(:,2),lm(:,3),'g*');
plot3(lmTarget(:,1),lmTarget(:,2),lmTarget(:,3),'ro'); 
view(-150,-40);
title('Orininal mesh vs. warped mesh')
xlabel('x'),ylabel('y'),zlabel('z');
%legend('Point set','Source landmarks','Destination landmarks')

%%%%%landmarks and all 3D points TPS
lm_tps = tps3d(lm,lm,lmTarget);
points3D_tps = tps3d(points3D, lm, lmTarget);
 
%figure(2),hold on,axis equal
shift = -30;
trimesh(faceStruct,points3D_tps(:,1)+shift,points3D_tps(:,2), points3D_tps(:,3));
plot3(lm_tps(:,1)+shift,lm_tps(:,2),lm_tps(:,3),'ro');
%set green 
width=1000;height=1000;
left=200;%left down horizontal distance
bottem=100;%left down vertical distance
set(gcf,'position',[left,bottem,width,height])
mouse3d