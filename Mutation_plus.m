function newpop=Mutation_plus(pop,pmutation,d,tt,k,t,C,Q,bestchrom)
% ��������ɱ������
% ���䣺���캯���������
[popsize,n]=size(pop);
newpop=pop;
%��������
qw = 1:k;
dw = 0:d-1;
sol_best = bestchrom;
for i=1:popsize
    if rand>pmutation
        continue;
    end
    randrr = rand;
    if (randrr<3/t) %��������ǽ������ֽ���
        sol_new = sol_best;%�����Ž�����Ŷ�
        jcsx=randperm(tt);%������ظ�ѡȡ������˳��
        ci = 0;
        for ti = jcsx
            Cti = C(ti,:);%ȡ��Լ���������еĵ�ti��Լ��,��Cti�д�ŵ���Լ������
            Qti = Q(:,k*(ti-1)+1:k*ti);
            solvv = sol_new(Cti(1:k));
            if is_exit(solvv,Qti)==1
                ci = ti;
                break;
            end
        end
        if ci~=0
            %��ô���൱������ҵ�һ���������Լ����
            Ci = C(ci,:);
            Qi = Q(:,k*(ci-1)+1:k*ci);
            indr = randi(k);%ȡ��һ�������λ��
            cindr = (qw~=indr);
            vr = Ci(indr);%ȡ��indr��Ӧ�ı���
            cvr = Ci(cindr);
            sol_cvr = sol_new(cvr);
            loc = (Qi(:,cindr)==sol_cvr);
            iicQ = Qi(loc,indr);%ȫ����vr����ȡ��ֵ
            ocQ = setdiff(dw,iicQ);
            sol_new(vr)=ocQ(floor(rand()*length(ocQ)+1));%�Խ��������
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