function [res] = primecheck(n)
%primecheck checks whether the number n is prime or composite.

lim=sqrt(n);
res=true;
i=2;
if n<2 || floor(n)-n~=0 %to make sure we are working with an integer >=2
    res=false;
else
    while i<=lim && res==true
        if i>2 && mod(i,2)==0 
            i=i+1;
        elseif i>3 && mod(i,3)==0
            i=i+1;
        elseif i>5 && mod(i,5)==0
            i=i+1;
        elseif i>7 && mod(i,7)==0
            i=i+1;
        elseif mod(n,i)==0
            res=false;
        else 
            i=i+1;
        end
    end
end

end

