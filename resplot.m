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
title('�㷨2���RBģ��ʵ����ʵ����')
xlabel('p')
ylabel('�ɽ�ĸ���P')
legend('N=20','N=40','N=60','N=80')