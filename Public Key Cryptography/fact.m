function [res] = fact(n)
%fact factorizes a positive integer n

lim=sqrt(n);
res=' ';
update=n;
i=2;
if floor(n)-n~=0 || n<=0 
    res='Must be a positive integer';
elseif n==1
    res='1';    
else
    while i<=n && update~=1
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

