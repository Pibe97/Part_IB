function [ x, Y ] = RK4( h,N )
%RK4 takes as input the step size h and the number of steps N to be
%done. It then calculates an approximate solution to a certain type of
%differential equation.

f=@(x,y) -16*y+15*exp(-x);
x=0:N;
Y=0:N;
x(1)=0;
Y(1)=0;
i=2;
while i<=N+1
    k1=h*f(x(i-1), Y(i-1));
    k2=h*f(x(i-1)+0.5*h, Y(i-1)+0.5*k1);
    k3=h*f(x(i-1)+0.5*h, Y(i-1)+0.5*k2);
    k4=h*f(x(i-1)+h, Y(i-1)+k3);
    
    Y(i)=Y(i-1)+(k1+2*k2+2*k3+k4)/6;
    x(i)=x(i-1)+h;     
    disp([' ']);
    disp(['x_' num2str(i-1) ' = ' num2str(x(i))]);
    disp(['Y_' num2str(i-1) ' = ' num2str(Y(i))]);
    i=i+1;
end

end

