function [p_res,q_res,phi,d] = Decrypt(n,e)
%This program takes as input n and e and finds the corresponding p,q and d

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need 'fact', hence this function is included here again%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [res] = fact(z)
    %fact factorizes a positive integer n
    lim=sqrt(z);
    res=' ';
    update=z;
    i=2;
    if floor(z)-z~=0 || z<=0 
        res='Must be a positive integer';
    elseif z==1
        res='1';    
    else
        while i<=z && update~=1
            if i>2 && mod(i,2)==0 
                i=i+1;
            elseif i>3 && mod(i,3)==0
                i=i+1;
            elseif i>5 && mod(i,5)==0
                i=i+1;
            elseif i>7 && mod(i,7)==0
                i=i+1;
            elseif mod(update,i)==0
                count=0;
                while mod(update,i)==0
                    count=count+1;
                    update=update/i;
                end
                if res==' '
                    res=strcat(num2str(i),'^',num2str(count));
                else
                    res=strcat(res,'*',num2str(i),'^',num2str(count));
                end
                i=i+1;
            else 
                i=i+1;
            end
        end
    end

    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need the 'Congruence', hence this function is included here again%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [ output_args ] = Congruence(a_,b_,m_)
        %This function solves the congruence a_x=b_ mod m_
        %The inputs variables have a '_' to avoid confusion with Euclid
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %We need 'Euclid', hence this function is included here again%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [hcf,s] = Euclid(m,n)
            %Euclid applies Euclid's Algortihm to 2 integers m,n, giving 
            %their hcf and a linear combination of m and n equalling the 
            %hcf by running Euclid's Algorithm backwards.
            
            if m>=n
                a=m;
                b=n;
            else
                a=n;
                b=m;
            end
            
            if mod(a,b)==0
                hcf=b;
                s=['Linear Factorization: ' num2str(a) '*(1) + ' num2str(b) '*(' num2str(-a/b+1) ') = ' num2str(hcf)];
            else
                copya=a;
                copyb=b;
                
                q=floor(a/b);
                r=mod(a,b);
                count=1;
                R=[r];
                Q=[q];
                
                while r~=0
                    a=b;
                    b=r;
                    q=floor(a/b);
                    r=mod(a,b);
                    count=count+1;
                    R=[R r];
                    Q=[Q q];
                end
                hcf=b;
                
                A=zeros(size(R));
                B=zeros(size(R));
                
                A(count)=-Q(count-1);
                B(count-1)=1;
                
                j=1;
                while count-1-2*j>0
                    A(count-2*j)=A(count-2*(j-1))*(1+Q(count-2-2*(j-1))*Q(count-2-2*(j-1)-1))-Q(count-2-2*(j-1)-1)*B(count-1-2*(j-1));
                    B(count-1-2*j)=B(count-1-2*(j-1))-Q(count-2-2*(j-1))*A(count-2*(j-1));
                    j=j+1;
                end
                
                if mod(count,2)==0
                    s=['Linear Factorization: ' num2str(copya) '*(' num2str(B(1)) ') + ' num2str(copyb) '*(' num2str(A(2)) ') = ' num2str(hcf)];
                else
                    B_0=B(2)-Q(1)*A(3);
                    s=['Linear Factorization: ' num2str(copya) '*(' num2str(A(3)) ') + ' num2str(copyb) '*(' num2str(B_0) ') = ' num2str(hcf)];
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %The function 'Congruence' starts here%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        [fact, LC]= Euclid(a_,m_);
        
        if fact==1
            plus=1;
            equals=1;
            while LC(plus)~='+' %to determine position of the plus sign
                plus=plus+1;
            end
            
            while LC(equals)~='=' %to determine position of the equals sign
                equals=equals+1;
            end
            
            inv_a_str=''; %gives inverse of a_ as string
            i=plus+1+length(num2str(a_))+2;
            while i<=equals-2
                inv_a_str=strcat(inv_a_str, LC(i));
                i=i+1;
            end
            inv_a=str2num(inv_a_str);
            
            sol=mod(inv_a*b_,m_);
            
            disp(['The solution is: ' num2str(sol) ' (mod ' num2str(m_) ')' ]);
            
        else
            if mod(b_,fact)==0
                a_n =a_/fact;
                b_n =b_/fact;
                m_n =m_/fact;
                Congruence(a_n,b_n,m_n);
            else
                disp('There are no solutions');
            end
        end
        
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The function 'Decrypt' starts here%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fact_n=fact(n);
pos_star=1;
while fact_n(pos_star)~='*'
    pos_star=pos_star+1;
end

p_string='';
k=1;
while k<=pos_star-3
    p_string=strcat(p_string,fact_n(k));
    k=k+1;
end

q_string='';
k=pos_star+1;
while k<=length(fact_n)
    q_string=strcat(q_string,fact_n(k));
    k=k+1;
end

p_res=str2num(p_string)
q_res=str2num(q_string)

phi=(p_res-1)*(q_res-1)
disp(['d is equal to: '])
Congruence(e,1,phi);

end

