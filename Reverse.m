function [bestchrom,bestfit]=Reverse(chrom,fitfun)
len=length(chrom);
bestchrom=chrom; bestfit=fitfun(chrom);
for i=1:len
x=chrom;
pos=randsample(1:len,2);
if pos(1)>pos(2)
a=pos(1);pos(1)=pos(2);pos(2)=a;
end
x(pos(1):pos(2))=x(pos(2):-1:pos(1)); %逆序操作
fit=fitfun(x); % 重新计算适应度
if fit>bestfit, bestchrom=x;bestfit=fit; end
end