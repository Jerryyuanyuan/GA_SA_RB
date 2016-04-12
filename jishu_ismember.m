 function res=jishu_ismember(C,Q,sol,k,t)            %,N,alfa
%--------------------------------------------------------------------------
%   计算一个赋值sol违反约束的个数，利用ismember函数
%   C、Q分别为产生的RB模型实例
%--------------------------------------------------------------------------
%其他参数
 res = 0;
 for i = 1:t
     Ci = C(i,:);
     solvv = sol(Ci(1:k));
     Qi = Q(:,k*(i-1)+1:k*i);
     if is_exit(solvv,Qi)==1
         res = res + 1;
     end
 end
 end