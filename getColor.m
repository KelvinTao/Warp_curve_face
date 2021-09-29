function rgb=getColor(hsvFile)
f0=dlmread(hsvFile,' ');
rgb=hsv2rgb(f0);