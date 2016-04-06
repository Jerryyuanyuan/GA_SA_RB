clear
clc
k = 2;
alfa = 0.8;
r = 3;
p = 0:0.01:0.2;% 通过参数p或者r变动来观测相变点！
N=[80,100];
maxgen=10; %进化代数
popsize=50; %种群规模
pcross=0.8; %交叉概率
pmutation=0.2; %变异概率
T0 = 97;
Tf = 3;
a = 0.75;

M = 100;

for N1 = N
    gaPP1 = zeros(length(p),M);
    gaTT1 = zeros(length(p),M);
    for pi = p
        for i = 1:M
            [C,Q] = RB_plusplus(k,N1,alfa,r,pi);
            tic;tic;[res,sol] = GA_SA_RB(C,Q,N1,alfa,pi,maxgen,popsize,pcross,pmutation,Tf,T0,a);
            gaTT1(p==pi,i) = toc;toc
            gaPP1(p==pi,i) = res;
            disp(['目前计算的p=',num2str(pi)]);
            disp(['目前计算到第',num2str(i),'组'])
            %save(['SA_GA_test1_data_N=',num2str(N1),'_p=',num2str(pi),'_i=',num2str(i)],'gaPP1','gaTT1');
        end
        datapath1 = ['SA_GA_test6_data_N=',num2str(N1),'_p=',num2str(pi),'.mat'];
        save(datapath1,'gaPP1','gaTT1');
    end
    datapath2 = ['SA_GA_test6_data_N=',num2str(N1),'.mat'];
    save(datapath2,'gaPP1','gaTT1');
end
dtpath = 'SA_GA_test6_data.mat';
save(dtpath,'gaPP1','gaTT1');
