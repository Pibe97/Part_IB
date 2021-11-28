function [xsol1,xsol2,xsol3]= omega(mu, xplot, yplot)
%Gives contour plots for omega. xplot and yplot are used for the x-range
%and the y-range.

x = linspace(-abs(xplot),abs(xplot));
y = linspace(-abs(yplot),abs(yplot));
[X,Y] = meshgrid(x,y);
Z = -0.5*mu*((X+1-mu).^2+Y.^2)-0.5*(1-mu)*((X-mu).^2+Y.^2)-mu*((X+1-mu).^2+Y.^2).^(-1/2)-(1-mu)*((X-mu).^2+Y.^2).^(-0.5);

contourf(X,Y,Z,-3.5:0.006:1);
xlabel('x coordinate');
ylabel('y coordinate');
hold on
plot(mu,0,'r*',mu-1,0,'g*');
title(['Contours of omega with mu=' num2str(mu)]);

fun2=@(x) (-x+mu*(x+1-mu)*abs(x+1-mu)^(-3)+(1-mu)*(x-mu)*abs(x-mu)^(-3));
xsol1=fzero(fun2,[-1.5 -1]);
xsol2=fzero(fun2,[mu-1+0.01 mu-0.01]);
xsol3=fzero(fun2,[0.6, 1.5]);

plot(mu-0.5,sqrt(3)/2,'-b*',mu-0.5,-sqrt(3)/2,'b*', xsol1,0,'b*', xsol2,0,'b*', xsol3,0,'b*');
end

