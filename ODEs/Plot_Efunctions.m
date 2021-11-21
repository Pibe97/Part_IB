function [ output_args ] = Plot_Efunctions( evalue )
%Plots the normalized eigenfunctions


    function [ x, y, z ] = SecondOrder_RK4( h,N,p,a )
    %SecondOrder_RK4 takes as input the step size h, the number of steps N to
    %be done and the parameters p and a (=alpha) from the differential 
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

[x,Y,Z]=SecondOrder_RK4(0.01,100,evalue,8);
Ym=1./((1+x).^8).*((Y).^2);
c=evalue^2*trapz(x,Ym);
y=Y/sqrt(c);
plot(x,y)

end

