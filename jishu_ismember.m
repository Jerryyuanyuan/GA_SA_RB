 function res=jishu_ismember(C,Q,sol,k,t)            %,N,alfa
%--------------------------------------------------------------------------
%   ����һ����ֵsolΥ��Լ���ĸ���������ismember����
%   C��Q�ֱ�Ϊ������RBģ��ʵ��
%--------------------------------------------------------------------------
%��������
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