function [ ps,iter ] = Evalue( p_1,p_2,acc,h,a )
%Evalue searches for an eigenvalue within the interval [p_1, p_2] the 
%linear interpolant. As stepsize for the internal RK4 function it takes
%the input h. acc is the input which determines when the function stops
%searching, referred to as epsilon in the manual. a (alpha) is the
%parameter in the differential equation.

    function [ x, y, z ] = SecondOrder_RK4( h,N,p,a )
    %This is the exact same second order RK4 function as before, but inside
    %Evalue so it can be used.

    f1=@(x,y,z) z;
    f2=@(x,y,z) -p^2*(1+x)^(-a)*y;

    x=0:N; %these will be the output
    y=0:N;
    z=0:N;

    x(1)=0; %initial conditions
    y(1)=0;
    z(1)=1;

    i=2;
    while i<=N+1
        p1=h*f1(x(i-1), y(i-1), z(i-1)); %the k_i are now 2D vectors, k=[p q]
        q1=h*f2(x(i-1), y(i-1), z(i-1));
        p2=h*f1(x(i-1)+0.5*h, y(i-1)+0.5*p1, z(i-1)+0.5*q1);
        q2=h*f2(x(i-1)+0.5*h, y(i-1)+0.5*p1, z(i-1)+0.5*q1);
        p3=h*f1(x(i-1)+0.5*h, y(i-1)+0.5*p2, z(i-1)+0.5*q2);
        q3=h*f2(x(i-1)+0.5*h, y(i-1)+0.5*p2, z(i-1)+0.5*q2);
        p4=h*f1(x(i-1)+h, y(i-1)+p3, z(i-1)+q3);
        q4=h*f2(x(i-1)+h, y(i-1)+p3, z(i-1)+q3);
    
        y(i)=y(i-1)+(1/6)*(p1+2*p2+2*p3+p4);
        z(i)=z(i-1)+(1/6)*(q1+2*q2+2*q3+q4);
        x(i)=x(i-1)+h;
    
        disp([' ']); %detailed step by step output
        disp(['x_' num2str(i-1) ' = ' num2str(x(i))]);
        disp(['y_' num2str(i-1) ' = ' num2str(y(i))]);
        disp(['z_' num2str(i-1) ' = ' num2str(z(i))]);
        i=i+1;
        end
        end

iter=0:100; %to save all iterations later on for the eigenvalue ps

[x1,y1,z1]=SecondOrder_RK4(h,round(1/h),p_1,a);
[x2,y2,z2]=SecondOrder_RK4(h,round(1/h),p_2,a);

yp1=y1(round(1/h)+1); %this is y_p1(1)
yp2=y2(round(1/h)+1); %this is y_p2(1)

ps=(yp2*p_1-yp1*p_2)/(yp2-yp1); %new eigenvalue
[xs,ys,zs]=SecondOrder_RK4(h,round(1/h),ps,a);
yps=ys(round(1/h)+1); %this is y_ps(1)
iter(1)=ps; %saving the first ps
j=2; %index
while abs(yps)>=acc
    if yps*yp1>0 %to determine which interval we continue with
        p_1=ps;  %to redefine interval boundaries
    elseif yps*yp2>0
        p_2=ps;
    end
    [x1,y1,z1]=SecondOrder_RK4(h,round(1/h),p_1,a);
    [x2,y2,z2]=SecondOrder_RK4(h,round(1/h),p_2,a);

    yp1=y1(round(1/h)+1);
    yp2=y2(round(1/h)+1);

    ps=(yp2*p_1-yp1*p_2)/(yp2-yp1); %new eigenvalue
    [xs,ys,zs]=SecondOrder_RK4(h,round(1/h),ps,a);
    yps=ys(round(1/h)+1);
    iter(j)=ps; %saving ps again
    j=j+1; %index
end

end

