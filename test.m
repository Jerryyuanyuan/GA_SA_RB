clear
clc
k = 2;
alfa = 0.8;
r = 3;
pi = 0.2;% 通过参数p或者r变动来观测相变点！
N1=100;
d = round(N1^alfa); 
t = round(r*N1*log(N1));

x=floor(rand(1,N1)*d);

tic;[C1,Q1] = RB_plus(k,N1,alfa,r,pi);toc
tic;jishu_isexit(C1,Q1,x);toc
tic;[C,Q] = RB_plusplus(k,N1,alfa,r,pi);toc
tic;jishu_ismember(C,Q,x,k,t);toc