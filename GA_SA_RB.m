function [res,sol]=GA_SA_RB(C,Q,N,alfa,~,maxgen,popsize,pcross,pmutation,Tf,T0,a)
    %----------------------------------------------------------------------
    %�����Ŵ��㷨��ģ���˻��㷨�Ĳ������RBģ��
    %----------------------------------------------------------------------
%maxgen=100; %��������
%popsize=100; %��Ⱥ��ģ
%pcross=0.6; %�������
%pmutation=0.2; %�������
%N��Ⱦɫ��ı�������
%����Сֵ
%load cityP_data.mat
d = round(N^alfa);%����������ֵ��
[t,k] = size(C);%Լ���ĸ���
%qq = round(p*d^k);          %���ɼ���ֵ�ĸ���
n=N; % ���и���,��Ⱦɫ�峤��
fitfun=@(x)(1/jishu_ismember(C,Q,x,k,t)); %��Ӧ�Ⱥ���-------ԽСԽ�ã�����Ҫȡ����
% ��ʼ����Ⱥ
pop=floor(rand(popsize,n)*d);%��0��d-1�������ֵ
popfit=zeros(popsize,1);
% �����ʼ��
for i=1:popsize
    popfit(i)=fitfun(pop(i,:)); %������Ӧ��
end
%����õ�Ⱦɫ��
[bestfit,index]=max(popfit);
bestchrom=pop(index,:);
if(bestfit==Inf)%����Ƿ����Ž�����Լ��
    res = 0;
    sol = bestchrom;
    disp(['���ٲ�������Լ���ĸ�����',num2str(res)])
    disp(['���Ž⣺',num2str(bestchrom)])
    return
end
% bestfit_all = bestfit;%��¼ȫ�����Ž�
% bestchrom_all = bestchrom;%��¼���й��̵����Ÿ���
% bestfit_current = bestfit;%��ǰ���Ž�
% bestchrom_current = bestchrom;%��ǰ���Ÿ���
%��ʼ�˻𲢿�ʼ����
history_n = 0;
T = T0;
while T>=Tf
    now_maxgen = maxgen + history_n*maxgen;
    for i=1:now_maxgen
        % ѡ����������������������������ú�����
        [pop,popfit]=Select(pop,popfit,popsize);%ѡ��
        pop=Cross(pop,pcross);%����
        pop=Mutation_plus(pop,pmutation,d,t,k,T,C,Q,bestchrom);%����
        % ���¼�����Ӧ�ȣ����������Ӧ�Ⱥ����Ⱦɫ��
        for j=1:popsize
            popfit(j)=fitfun(pop(j,:));
        end
        p=bestfit;
        q=max(popfit);
        if q>p
            [bestfit,index]=max(popfit);
            bestchrom=pop(index,:);
        end
        %����ȫ������
        if(bestfit==Inf)%����Ƿ����Ž�����Լ��
            res = 0;
            sol = bestchrom;
            disp(['���ٲ�������Լ���ĸ�����',num2str(res)])
            disp(['���Ž⣺',num2str(bestchrom)])
            return
        end
    end
    T = T*a;
    history_n = history_n+1;
end
res = 1/bestfit;
if res ~= 0
    disp('��ʼģ���˻��㷨')
    assignment = bestchrom;
    tf = 3;
    t0 = 97;
    a = 0.8;
    Lk = 1000;
    [res,sol]=SA_RB_with_init(C,Q,N,alfa,t,k,a,t0,tf,Lk,assignment);
end
disp(['���ٲ�������Լ���ĸ�����',num2str(res)])
disp(['���Ž⣺',num2str(bestchrom)])
end