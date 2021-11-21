function [ dpos,xpos, phimin, phimax,theta ] = DeltaPhiMin( phi )
%DeltaPhiMin is a function which minimises deltaPhi from Q6

    function [ modepos ] = NewModeGss(f,a,b,d,delta)
    %NewModeGss is a variation of modegss in that it uses a bivariate
    %function as input, but only works on the first variable. It works
    %similar to modegss. This is only to simplify coding.

    if b<=a
        error('Upper bound must be strictly bigger than lower bound');
    elseif f(a,d)==f(b,d) && f(a,d)==f((a+b)/2,d)
            fprintf('The function is constant so as a result just take the middle value')
            disp(['The mode is: ' num2str((a+b)/2,d)])
            modepos=(a+b)/2;
        else
    
    %what follows is to determine whether the function is initially
    %increasing or decreasing w.r.t. the first variable.
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
        golden = 0.5*(sqrt(5)-1);
        x = b-(b-a)*golden;
        y = a+(b-a)*golden;
    
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
                x=b-(b-a)*golden;
                fx=f(x,d); 
                modepos=(a+b)/2;
            elseif fx < fy
                a=x;
                x=y;
                fx=fy;
                y=a+(b-a)*golden;
                fy=f(y,d);
                modepos=(a+b)/2;
            end
        end  
    end  
    end

%Here starts the relevant part for Q6
dmin=17.5;
dmax=24;
dpos=(dmax+dmin)/2;
xmin=6.5;
xmax=16;
golden=0.5*(sqrt(5)-1);

delta_x=input('Enter required accuracy for x: ');
delta_d=input('Enter required accuracy for d: ');

d1=dmax-(dmax-dmin)*golden;
d2=dmin+(dmax-dmin)*golden;
%note that phi(x,d) for fixed d in [17.5,24] is unimodal with a minimum (see
%graphs). So will need to consider -phi(x,d):
minusphi= @(x,d) -phi(x,d);

while dmax-dmin>2*delta_d 
    
    xmin1=NewModeGss(minusphi,xmin,xmax,d1,delta_x);
        %Gives relevant x for d=d1
    xmin2=NewModeGss(minusphi,xmin,xmax,d2,delta_x);
        %Gives relevant x for d=d2
    
    %the max is always on a boundary point:    
    if phi(xmin,d1)>= phi(xmax,d1)
        xmax1=xmin;
    elseif phi(xmin,d1)<phi(xmax,d1)
        xmax1=xmax;
    end
    
    if phi(xmin,d2)>= phi(xmax,d2)
        xmax2=xmin;
    elseif phi(xmin,d2)<phi(xmax,d2)
        xmax2=xmax;
    end
    %DeltaPhi is unimodal with a minimum (see graphs) so take -DeltaPhi:
    deltaphi1= -phi(xmax1,d1) + phi(xmin1,d1); 
    deltaphi2= -phi(xmax2,d2) + phi(xmin2,d2);
    
    if deltaphi1>=deltaphi2
        phimin=phi(xmin1,d1);
        phimax=phi(xmax1,d1);
        dmax=d2;
        d2=d1;
        d1=dmax-(dmax-dmin)*golden;
        dpos=(d1+d2)/2;       
    elseif deltaphi1<deltaphi2
        phimin=phi(xmin2,d2);
        phimax=phi(xmax2,d2);
        dmin=d1;
        d1=d2;
        d2=dmin+(dmax-dmin)*golden;
        dpos=(d1+d2)/2;
    end
end
   theta=0.5*(phimin+phimax);
   disp([' ']); %For neater output
   disp(['Optimal d is: ' num2str(dpos)]);
   disp(['For this d, the minimum of phi is: ' num2str(phimin) ' and the maximum: ' num2str(phimax)]);
   disp(['Optimal theta is: ' num2str(theta) ' (rad)']);
end

