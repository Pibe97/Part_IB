function [hcf,s] = Euclid(m,n)
%Euclid applies Euclid's Algortihm to 2 integers m,n, giving their hcf 
%and a linear combination of m and n equalling the hcf by running Euclid's
%Algorithm backwards.

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
        disp(s);
    else
        B_0=B(2)-Q(1)*A(3);
        s=['Linear Factorization: ' num2str(copya) '*(' num2str(A(3)) ') + ' num2str(copyb) '*(' num2str(B_0) ') = ' num2str(hcf)];
        disp(s);
    end
end

end

