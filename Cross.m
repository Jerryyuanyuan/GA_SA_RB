function newpop=Cross(pop,pcross)
% 本函数完成交叉操作
[popsize,len]=size(pop);
newpop=pop;
for i=1:popsize
if rand>pcross,continue;end % 即在0-pcross范围进行交叉
index=randsample(1:popsize,2); % 随机选择两个染色体
pos=randi(len); % 随机选择交叉位置个数
% 交叉开始
x1pos = randnorepeat(pos,len);
x2pos = randnorepeat(pos,len);
x1=newpop(index(1),:); x2=newpop(index(2),:);
newpop(index(1),x1pos)=x2(x2pos);
newpop(index(2),x2pos)=x1(x1pos);
end