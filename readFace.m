function f=readFace(faceFile)
fid=fopen(faceFile, 'r' );
%--get face: vertex/texture/normal vector (point1NO point2NO point3NO): 
% for single picture every three NO of three points are the same
f0 = textscan(fid,'f %d/%d/%d %d/%d/%d %d/%d/%d');
fclose(fid);
f=[f0{1,1} f0{1,4} f0{1,7}]; %--get vetex NO
