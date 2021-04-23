sfery=[-36.92 70.29 0.00;
-67.40 34.21 0.00;
-69.44 -13.55 0.00;
-45.05 -51.14 0.00;
0.68 -66.39 0.00;
44.38 -51.14 0.00;
71.81 -12.53 0.00;
70.80 34.21 0.00;
41.33 69.78 0.00;
-20.66 26.08 0.00;
-3.38 -20.66 0.00;
26.08 23.04 0.00;
%-66.31 63.61 0.00;
%1.09 54.13 0.00;
%2.27 7.91 0.00]

for i=1:size(sfery,1)
balagan=cell_rdir('./__tse_tra*2419_*.nii');
porzadek=sort_nat(balagan);
sfera=spm_summarise(porzadek,struct('def','sphere', 'spec',8, 'xyz',sfery(i,:)'),@mean);
ti=[30;60;90;120;150;200;300;400;500;700;900;1200;1500;2000;3000;4000;6000;9000];
%figure; plot(ti,sfera)

fitfun = @(a,b,c,x) abs(a.*(1-b.*exp(-x./c))); %	S(t) = |A (1 − B exp(−t/T1))|
fo = fitoptions('Method','NonlinearLeastSquares','StartPoint',[3000 2 1000]);
[f,goodness] = fit( ti, sfera, fitfun,fo);
coeffs = coeffvalues(f);
figure; plot(f,ti,sfera)

fprintf("Sfera %d; T1=%gms\n",i,coeffs(3))
end