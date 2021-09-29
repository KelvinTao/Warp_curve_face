function warps3D = tps3d(all3Dpoints, landmarks_ori, landmarks_target )
% thin-plate spline 3D x y z
% p3d: 3d point set;  ps:  3d source landmark [n*3]; pd:  3d destin landmark [n*3]
%% get w
num_center = size(landmarks_target,1);
nump = size(landmarks_ori,1);
K = zeros(nump,num_center);

for i=1:num_center
    dx = ones(nump,1)*landmarks_target(i,:) - landmarks_ori; 
    K(:,i) = sum(dx.^2,2);
end
    K = ThinPlate(K);
P = [ones(nump,1), landmarks_ori];
L = [K, P;
     P',zeros(4,4)];
Y = [landmarks_target;zeros(4,3)];
w = L\Y;

%% warp by w
nump = size( all3Dpoints,1 );
Kp = zeros( nump,num_center );
for i=1:num_center
    dx = all3Dpoints - ones( nump,1 )*landmarks_target( i,: );
    Kp(:,i) = sum( dx.^2,2 );
end
L = [ThinPlate(Kp),ones(nump,1),all3Dpoints];
warps3D = L*w;

end

%% TPS function
function k = ThinPlate(r0)
    r1 = r0;
    r1(r0==0) = realmin; % log(0)=inf
    k = (r0).*log(r1);
end
