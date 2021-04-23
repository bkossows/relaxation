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
26.08 23.04 0.00]

balagan=cell_rdir('./__se_multiecho*2419_*.nii');
porzadek=sort_nat(balagan);

for i=1:size(sfery,1)
sfera=spm_summarise(porzadek,struct('def','sphere', 'spec',3, 'xyz',sfery(i,:)'),@mean);
te=[15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240,255,270,285,300,315,330,345,360,375,390,405,420,435,450,465,480]';
%figure; plot(ti,sfera)

fitfun = @(a,b,c,x) a.*exp(-x./b)+c;
fo = fitoptions('Method','NonlinearLeastSquares','StartPoint',[3000 200 100]);
[f,goodness] = fit( te, sfera, fitfun,fo);
coeffs = coeffvalues(f);
figure; plot(f,te,sfera)

fprintf("Sfera %d; T2=%gms\n",i,coeffs(2))
end
