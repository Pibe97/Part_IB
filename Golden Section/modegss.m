function [ modepos ] = modegss(f)
%modegss gives the approximate position of the mode of a  strictly unimodal 
%function using the golden section search method

    a=input('Enter the lower bound of the interval:  ');
    b=input('Enter the upper bound of the interval:  ');
    if b<=a
        error('Upper bound must be strictly bigger than lower bound');
    else
        delta=input('Enter the required accuracy:  ');
    
        if f(a)==f(b) && f(a)==f((a+b)/2)
            fprintf('The function is constant so as a result just take the middle value. ')
            disp(['The mode is: ' num2str((a+b)/2)])
            modepos=(a+b)/2;
        else
    
    %what follows is to determine whether the function is initially
    %increasing or decreasing
        k=1; 
        while f(a+k*100*eps)-f(a)==0
            k=k+1;        
        end
        
        if f(a+k*100*eps)-f(a)>0 
            cas=1;
        elseif f(a+k*100*eps)-f(a)<0
            cas=2;
        end
        
        if cas==1
            f=@(x) f(x);
        elseif cas==2 
            f=@(x) (-1)*f(x);
        end
        
    %Now we are applying the Golden section search    
        phi = 0.5*(sqrt(5)-1);
        x = b-(b-a)*phi;
        y = a+(b-a)*phi;
    
        modepos=(a+b)/2;
        fx=f(x);
        fy=f(y);
        N=0;
        while b-a > 2*delta
            N=N+1;
            if fx >= fy
                b=y;
                y=x;
                fy=fx;
                x=b-(b-a)*phi;
                fx=f(x); 
                modepos=(a+b)/2;
            elseif fx < fy
                a=x;
                x=y;
                fx=fy;
                y=a+(b-a)*phi;
                fy=f(y);
                modepos=(a+b)/2;
            end
        end          
        disp(['The mode is located at: ' num2str(modepos) ', and the value is: ' num2str(f(modepos))])
        disp(['Number of iterations: ' int2str(N)])
        end  
    end
end

