function [ P ] = Intervals( )
%Intervals determines the intervals which contain eigenvalues.
    
    function [ x, y, z ] = SecondOrder_RK4( h,N,p,a )
    %SecondOrder_RK4 takes as input the step size h, the number of steps N 
    %to be done and the parameters p and a (=alpha) from the differential 
    %equation

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


count=0; %to count how many intervals have been found
p_1=1;  %left boundary
p_2=2;  %right boundary
P=1:10;  %vector which will contain all boundary values
[x1,y1,z1]=SecondOrder_RK4(0.01,100,p_1,8);
[x2,y2,z2]=SecondOrder_RK4(0.01,100,p_2,8);
yp1=y1(101);
yp2=y2(101);
while count<=8
    if yp1*yp2<0
        P(count+1)=p_1;
        P(count+2)=p_2;
        count=count+2;
    end
    yp1=yp2;
    p_1=p_1+1;
    p_2=p_2+1;
    [x2,y2,z2]=SecondOrder_RK4(0.01,100,p_2,8);
    yp2=y2(101);
end

end

