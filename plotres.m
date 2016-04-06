load('SA_GA_test6_data_N=80_p=0.19.mat')
N80=gaPP1;
load('SA_GA_test0_data_N=100_p=0.18.mat')
N100=gaPP1;
PP1=sum(N80'==0)/100;
PP2=sum(N100'==0)/100;
p=0:0.01:0.2;

plot(p,PP1,':*',p,PP2,':^')