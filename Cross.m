function newpop=Cross(pop,pcross)
% ��������ɽ������
[popsize,len]=size(pop);
newpop=pop;
for i=1:popsize
if rand>pcross,continue;end % ����0-pcross��Χ���н���
index=randsample(1:popsize,2); % ���ѡ������Ⱦɫ��
pos=randi(len); % ���ѡ�񽻲�λ�ø���
% ���濪ʼ
x1pos = randnorepeat(pos,len);
x2pos = randnorepeat(pos,len);
x1=newpop(index(1),:); x2=newpop(index(2),:);
newpop(index(1),x1pos)=x2(x2pos);
newpop(index(2),x2pos)=x1(x1pos);
end