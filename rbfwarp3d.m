function p3do = rbfwarp3d( p3d, ps, pd, varargin )
% Radial basis function/Thin-plate spline 3D point set warping.
%   p3do = rbfwarp3d( p3d, ps, pd, varargin )
%   input:
%       p3d: 3d point set
%       ps:  3d source landmark [n*3]
%       pd:  3d destin landmark [n*3]
%       method:
%         'gau',r  - for Gaussian function   ko = exp(-|pi-pj|/r.^2);
%         'thin'   - for Thin-plate function ko = (|pi-pj|^2) * log(|pi-pj|^2)
%   output:
%       p3do: output point set
%
%   Bookstein, F. L. 
%   "Principal Warps: Thin Plate Splines and the Decomposition of Deformations."
%   IEEE Trans. Pattern Anal. Mach. Intell. 11, 567-585, 1989. 
%
%   Code by WangLin
%   wanglin193@hotmail.com

num_required_parameters = 3;
if nargin < num_required_parameters
    help rbfwarp3d.m
    return;
end

%% Initialize default parameters
r = 1;

%% Parse parameters
if nargin > num_required_parameters
    iVarargin = 1;
    while iVarargin <= nargin - num_required_parameters
        switch lower(varargin{iVarargin})
            case 'thin'
                method = 't';
            case 'gau'
                method = 'g';
                r = varargin{iVarargin+1};
                iVarargin = iVarargin + 1;
        end
        iVarargin = iVarargin + 1;
    end
end

%% Training 'w' with 'L'
num_center = size(pd,1);
nump = size(ps,1);
K = zeros(nump,num_center);

for i=1:num_center
    %Forward warping, different from image warping
    dx = ones(nump,1)*pd(i,:) - ps; 
    %use |dist|^2 as input
    K(:,i) = sum(dx.^2,2);
end

if( strcmpi(method,'g') )
    K = rbf(K,r);
elseif( strcmpi(method,'t') )
    K = ThinPlate(K);
end

% Y = L * w;
%  L: RBF matrix about source
%  Y: Points matrix about destination
% P = [1,ps] where ps are n landmark points (nx3)
P = [ones(nump,1), ps];
% L = [ K  P;
%       P' 0 ]
L = [K, P;
     P',zeros(4,4)];
% Y = [ pd;
%       0,0,0]; (n+3)x3
Y = [pd;zeros(4,3)];
%w = inv( L + 0.1*eye(num_center+4) )*Y;
w = L\Y;

%% Using 'w' 
nump = size( p3d,1 );
Kp = zeros( nump,num_center );
for i=1:num_center
    dx = p3d - ones( nump,1 )*pd( i,: );
    Kp(:,i) = sum( dx.^2,2 );
end
if( strcmpi(method,'g') )
    Kp = rbf(Kp,r);
elseif( strcmpi(method,'t') )
    Kp = ThinPlate(Kp);    
end
% Y = L * w;
L = [Kp,ones(nump,1),p3d];
p3do = L*w;

end

%% RBF functions
function ko = rbf(d,r) 
    ko = exp(-d/r.^2);
end

function ko = ThinPlate(ri)
    % k=(r^2) * log(r^2)
    r1i = ri;
    % k=(r^2) * log(r)
    % r1i = sqrt(ri);
    r1i(ri==0) = realmin; % Avoid log(0)=inf
    ko = (ri).*log(r1i);
end
