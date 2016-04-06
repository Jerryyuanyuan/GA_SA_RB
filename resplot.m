p=0:0.01:0.2;
N = 20:20:80;
i = 1;
P = zeros(4,21);
for n = N
    load(['SA_GA_test2_data_N=',num2str(n),'.mat'])
    P(i,:)=sum(gaPP1'==0)/100;
    i= i + 1;
end
% PP=(gaPP1==0);
% PP = sum(PP,2);
% PP = PP/100;
plot(p,P(1,:),':*',p,P(2,:),':^',p,P(3,:),':d',p,P(4,:),':s');
title('算法2求解RB模型实例的实验结果')
xlabel('p')
ylabel('可解的概率P')
legend('N=20','N=40','N=60','N=80')