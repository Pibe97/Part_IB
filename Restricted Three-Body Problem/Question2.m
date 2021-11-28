function [ t,y ] = Question2( tmax, x0,y0,xdot0,ydot0)
%Similar to Task1 but for the given approximation from Question 2.

    function dydt=rhs(t,y)
        dydt_1=y(2);
        dydt_2= 2*y(4);
        dydt_3=y(4);
        dydt_4=-2*y(2);
        
        dydt=[dydt_1; dydt_2; dydt_3; dydt_4];
    end
options=odeset('RelTol', 1e-5);
[t,y]=ode45( @rhs,[0 tmax], [x0; xdot0; y0; ydot0],options);

plot(y(:,1),y(:,3));
hold on
plot(0.5,0,'r*');
grid on
xlabel('x coordinate');
ylabel('y coordinate');

end

