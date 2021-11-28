function [ t,y ,J] = Question2NonCircle( tmax, x0,y0,xdot0,ydot0 )
%Gives the non circular solution from Question 2.

    function dydt=rhs(t,y)
        dydt_1=y(2);
        dydt_2= 2*y(4)-0.5*(y(1)-0.5)*((y(1)-0.5)^2+y(3)^2)^(-3/2);
        dydt_3=y(4);
        dydt_4=-2*y(2)-0.5*y(3)*((y(1)-0.5)^2+y(3)^2)^(-3/2);
        
        dydt=[dydt_1; dydt_2; dydt_3; dydt_4];
    end

options=odeset('RelTol', 1e-9);
[t,y]=ode45( @rhs,[0 tmax], [x0; xdot0; y0; ydot0],options);

J=1:size(y,1);
i=1;
while i<=size(y,1)
    J(i)=0.5*y(i,2)^2+0.5*y(i,4)^2-0.5*((y(i,1)-0.5)^2+y(i,3)^2)^(-1/2);
    i=i+1;
end

end

