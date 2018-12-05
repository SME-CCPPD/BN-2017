close all
clear all

fc = 5000; 
pc = 1/fc;

dur = 0.5;

T = [0: pc: dur - pc];

amp = 1;
f = 150;
w = 2*pi*f;

y0 = 1 + amp*cos(w*T);

wsize = 761;
bsize = fc / wsize;
nq = fc/2;

F = [-nq - (bsize/2) : bsize: nq - (bsize/2)]; 

% Window Hanning

hf = fc / wsize;
hw = hf * 2 * pi;
h = 0.5 + (- 0.5*cos(hw * T(1:wsize)));

hy0 = y0(1:wsize).*h;

figure(1)
plot(T(1:wsize), hy0, T(1:wsize), h);

DFT = zeros(1, wsize);

for k = 1:length(F)
wa = F(k) * 2 * pi;
a = e.**(-i * wa * T(1:wsize));
ay = a.*hy0;
DFT(k) = sum(ay);
end

mDFT = (abs(DFT) / wsize) * 2; %si raddopia la magnitude per compensare la finestra di hanning 

figure(2)
stem(F, mDFT); 
