function newpop=Mutation_plus(pop,pmutation,d,tt,k,t,C,Q,bestchrom)
% 本函数完成变异操作
% 补充：变异函数所有语句
[popsize,n]=size(pop);
newpop=pop;
%其他参数
qw = 1:k;
dw = 0:d-1;
sol_best = bestchrom;
for i=1:popsize
    if rand>pmutation
        continue;
    end
    randrr = rand;
    if (randrr<3/t) %随机决定是进行那种交换
        sol_new = sol_best;%对最优解进行扰动
        jcsx=randperm(tt);%随机不重复选取出检验顺序
        ci = 0;
        for ti = jcsx
            Cti = C(ti,:);%取出约束变量集中的第ti个约束,即Cti中存放的是约束变量
            Qti = Q(:,k*(ti-1)+1:k*ti);
            solvv = sol_new(Cti(1:k));
            if is_exit(solvv,Qti)==1
                ci = ti;
                break;
            end
        end
        if ci~=0
            %那么就相当于随机找到一个不满足的约束。
            Ci = C(ci,:);
            Qi = Q(:,k*(ci-1)+1:k*ci);
            indr = randi(k);%取出一个随机的位置
            cindr = (qw~=indr);
            vr = Ci(indr);%取出indr对应的变量
            cvr = Ci(cindr);
            sol_cvr = sol_new(cvr);
            loc = (Qi(:,cindr)==sol_cvr);
            iicQ = Qi(loc,indr);%全部的vr不能取得值
            ocQ = setdiff(dw,iicQ);
            sol_new(vr)=ocQ(floor(rand()*length(ocQ)+1));%对解进行修正
        end
        newpop(i,:) = sol_new;
    else
        nn = randi(n);
        if rand<0.5
            newpop(i,1:nn) = floor(rand(1,nn)*d);
        else
            newpop(i,nn:n) = floor(rand(1,n-nn+1)*d);
        end
    end
end