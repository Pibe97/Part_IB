function [ t,y ] = Task1( mu, tmax, x0,y0,xdot0,ydot0)
%Task1 takes as input mu, tmax and the initial conditions, then plots the 
%resulting trajectory and gives as output the specific times, and
%the position vector and its derivative in one 4-vector.

options=odeset('RelTol', 1e-6);
[t,y]=ode45( @rhs,[0 tmax], [x0; xdot0; y0; ydot0], options);

    function dydt=rhs(t,y)
        dydt_1=y(2);
        dydt_2= 2*y(4)+y(1)-mu*(y(1)+1-mu)*((y(1)+1-mu)^2+y(3)^2)^(-3/2)-(1-mu)*(y(1)-mu)*((y(1)-mu)^2+y(3)^2)^(-3/2);
        dydt_3=y(4);
        dydt_4=-2*y(2)+y(3)*(1-mu*((y(1)+1-mu)^2+y(3)^2)^(-3/2)-(1-mu)*((y(1)-mu)^2+y(3)^2)^(-3/2));
        
        dydt=[dydt_1; dydt_2; dydt_3; dydt_4];
    end

plot(y(:,1),y(:,3));
grid on
hold on
plot(mu,0,'r*',mu-1,0,'g*');
xlabel('x coordinate');
ylabel('y coordinate');

end

