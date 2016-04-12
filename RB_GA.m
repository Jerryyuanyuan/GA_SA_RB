function [res,sol] = RB_GA(C,Q,N,alfa,pp,maxgen,popsize,pcross,pmutation)
%--------------------------------------------------------------------------
%  利用遗传算法求解RB模型！
%--------------------------------------------------------------------------
%maxgen=100; %进化代数
%popsize=100; %种群规模
%pcross=0.6; %交叉概率
%pmutation=0.2; %变异概率
%N是染色体的变量个数
%求最小值
%load cityP_data.mat
d = round(N^alfa);         %各个变量的值域
%t = round(r*N*log(N));     %约束的个数
%qq = round(p*d^k);          %不可兼容值的个数
n=N; % 城市个数,即染色体长度
fitfun=@(x)1/jishu_isexit(C,Q,x); %适应度函数-------越小越好，所以要取倒数
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
for i=1:maxgen
    % 选择操作、交叉操作、变异操作（调用函数）
    [pop,popfit]=Select(pop,popfit,popsize);%选择
    pop=Cross(pop,pcross);%交叉
    pop=Mutation(pop,pmutation,d);%变异
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
    % 最差的被最好的染色体代替
    [~,worstindex]=min(popfit);
    pop(worstindex,:)=bestchrom;
    popfit(worstindex)=bestfit;
    if(bestfit==Inf)%检查是否最优解满足约束
        res = 0;
        sol = bestchrom;
        disp(['最少不可满足约束的个数：',num2str(res)])
        disp(['最优解：',num2str(bestchrom)])
        return
    end
end
% 窗口显示结果
sol = bestchrom;
res = jishu_isexit(C,Q,sol);
disp(['最少不可满足约束的个数：',num2str(res)])
disp(['最优解：',num2str(bestchrom)])
end

