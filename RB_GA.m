function [res,sol] = RB_GA(C,Q,N,alfa,pp,maxgen,popsize,pcross,pmutation)
%--------------------------------------------------------------------------
%  �����Ŵ��㷨���RBģ�ͣ�
%--------------------------------------------------------------------------
%maxgen=100; %��������
%popsize=100; %��Ⱥ��ģ
%pcross=0.6; %�������
%pmutation=0.2; %�������
%N��Ⱦɫ��ı�������
%����Сֵ
%load cityP_data.mat
d = round(N^alfa);         %����������ֵ��
%t = round(r*N*log(N));     %Լ���ĸ���
%qq = round(p*d^k);          %���ɼ���ֵ�ĸ���
n=N; % ���и���,��Ⱦɫ�峤��
fitfun=@(x)1/jishu_isexit(C,Q,x); %��Ӧ�Ⱥ���-------ԽСԽ�ã�����Ҫȡ����
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
for i=1:maxgen
    % ѡ����������������������������ú�����
    [pop,popfit]=Select(pop,popfit,popsize);%ѡ��
    pop=Cross(pop,pcross);%����
    pop=Mutation(pop,pmutation,d);%����
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
    % ���ı���õ�Ⱦɫ�����
    [~,worstindex]=min(popfit);
    pop(worstindex,:)=bestchrom;
    popfit(worstindex)=bestfit;
    if(bestfit==Inf)%����Ƿ����Ž�����Լ��
        res = 0;
        sol = bestchrom;
        disp(['���ٲ�������Լ���ĸ�����',num2str(res)])
        disp(['���Ž⣺',num2str(bestchrom)])
        return
    end
end
% ������ʾ���
sol = bestchrom;
res = jishu_isexit(C,Q,sol);
disp(['���ٲ�������Լ���ĸ�����',num2str(res)])
disp(['���Ž⣺',num2str(bestchrom)])
end

