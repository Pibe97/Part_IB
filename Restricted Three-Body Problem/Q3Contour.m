function Q3Contour(mu,t,Y, J,xplot,yplot )
%Plots the trajectory and the forbidden region on the same plot. xplot and
%yplot are the x-range and y-range for the plot.

hold on
plot(Y(:,1),Y(:,3));
plot(mu,0,'r*',mu-1,0,'g*');

x = linspace(-abs(xplot),abs(xplot));
y = linspace(-abs(yplot),abs(yplot));
[X,Y] = meshgrid(x,y);
Z = -0.5*mu*((X+1-mu).^2+Y.^2)-0.5*(1-mu)*((X-mu).^2+Y.^2)-mu*((X+1-mu).^2+Y.^2).^(-1/2)-(1-mu)*((X-mu).^2+Y.^2).^(-0.5);

contourf(X,Y,Z,[J J]);
xlabel('x coordinate');
ylabel('y coordinate');
title('Trajectory and the forbidden region omega>J');

end

