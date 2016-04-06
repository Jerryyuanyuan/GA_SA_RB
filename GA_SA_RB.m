function [res,sol]=GA_SA_RB(C,Q,N,alfa,~,maxgen,popsize,pcross,pmutation,Tf,T0,a)
    %----------------------------------------------------------------------
    %利用遗传算法和模拟退火算法的策略求解RB模型
    %----------------------------------------------------------------------
%maxgen=100; %进化代数
%popsize=100; %种群规模
%pcross=0.6; %交叉概率
%pmutation=0.2; %变异概率
%N是染色体的变量个数
%求最小值
%load cityP_data.mat
d = round(N^alfa);%各个变量的值域
[t,k] = size(C);%约束的个数
%qq = round(p*d^k);          %不可兼容值的个数
n=N; % 城市个数,即染色体长度
fitfun=@(x)(1/jishu_ismember(C,Q,x,k,t)); %适应度函数-------越小越好，所以要取倒数
% 初始化种群
pop=floor(rand(popsize,n)*d);%从0到d-1中随机赋值
popfit=zeros(popsize,1);
% 个体初始化
for i=1:popsize
    popfit(i)=fitfun(pop(i,:)); %个体适应度
end
%找最好的染色体
[bestfit,index]=max(popfit);
bestchrom=pop(index,:);
if(bestfit==Inf)%检查是否最优解满足约束
    res = 0;
    sol = bestchrom;
    disp(['最少不可满足约束的个数：',num2str(res)])
    disp(['最优解：',num2str(bestchrom)])
    return
end
% bestfit_all = bestfit;%记录全局最优解
% bestchrom_all = bestchrom;%记录所有过程的最优个体
% bestfit_current = bestfit;%当前最优解
% bestchrom_current = bestchrom;%当前最优个体
%开始退火并开始进化
history_n = 0;
T = T0;
while T>=Tf
    now_maxgen = maxgen + history_n*maxgen;
    for i=1:now_maxgen
        % 选择操作、交叉操作、变异操作（调用函数）
        [pop,popfit]=Select(pop,popfit,popsize);%选择
        pop=Cross(pop,pcross);%交叉
        pop=Mutation_plus(pop,pmutation,d,t,k,T,C,Q,bestchrom);%变异
        % 重新计算适应度，更新最大适应度和最好染色体
        for j=1:popsize
            popfit(j)=fitfun(pop(j,:));
        end
        p=bestfit;
        q=max(popfit);
        if q>p
            [bestfit,index]=max(popfit);
            bestchrom=pop(index,:);
        end
        %更新全局最优
        if(bestfit==Inf)%检查是否最优解满足约束
            res = 0;
            sol = bestchrom;
            disp(['最少不可满足约束的个数：',num2str(res)])
            disp(['最优解：',num2str(bestchrom)])
            return
        end
    end
    T = T*a;
    history_n = history_n+1;
end
res = 1/bestfit;
if res ~= 0
    disp('开始模拟退火算法')
    assignment = bestchrom;
    tf = 3;
    t0 = 97;
    a = 0.8;
    Lk = 1000;
    [res,sol]=SA_RB_with_init(C,Q,N,alfa,t,k,a,t0,tf,Lk,assignment);
end
disp(['最少不可满足约束的个数：',num2str(res)])
disp(['最优解：',num2str(bestchrom)])
end