function [ modepos ] = NewModeGss(f,a,b,d,delta)
    %NewModeGss gives the approximate position of the mode of a unimodal function 
    %using the golden section search method and also takes as inputs the
    %interval boundaries. THe function f is bivariate and we work on the first
    %variable.
    %   Detailed explanation goes here

    if b<=a
        error('Upper bound must be strictly bigger than lower bound');
    else
    
        if f(a,d)==f(b,d) && f(a,d)==f((a+b)/2,d)
            fprintf('The function is constant so as a result just take the middle value')
            disp(['The mode is: ' num2str((a+b)/2,d)])
            modepos=(a+b)/2;
        else
    
    %what follows is to determine whether the function is initially
    %increasing or decreasing
        k=1; 
        while f(a+k*100*eps,d)-f(a,d)==0
            k=k+1;        
        end
        cas=0;
        
        if f(a+k*100*eps,d)-f(a,d)>0 
            cas=1;
        elseif f(a+k*100*eps,d)-f(a,d)<0
            cas=2;
        end
        
        if cas==1
            f=@(x,d) f(x,d);
        elseif cas==2 
            f=@(x,d) (-1)*f(x,d);
        end
        
    %Now we are applying the Golden section search    
        phi = 0.5*(sqrt(5)-1);
        x = b-(b-a)*phi;
        y = a+(b-a)*phi;
    
        modepos=(a+b)/2;
        fx=f(x,d);
        fy=f(y,d);
        N=0;
        while b-a > 2*delta
            N=N+1;
            if fx >= fy
                b=y;
                y=x;
                fy=fx;
                x=b-(b-a)*phi;
                fx=f(x,d); 
                modepos=(a+b)/2;
            elseif fx < fy
                a=x;
                x=y;
                fx=fy;
                y=a+(b-a)*phi;
                fy=f(y,d);
                modepos=(a+b)/2;
            end
        end  
        end  
    end
    end