function [ J ] = CheckJ( mu,y )
%CheckJ outputs the vector J whose values are J evaluated at each point
%in the trajectory.

J=1:size(y,1);
i=1;
while i<=size(y,1)
    J(i)=0.5*y(i,2).^2+0.5*y(i,4).^2-0.5*mu*((y(i,1)+1-mu).^2+(y(i,3)).^2)-0.5*(1-mu)*((y(i,1)-mu).^2+(y(i,3)).^2)-mu*((y(i,1)+1-mu).^2+(y(i,3)).^2).^(-0.5)-(1-mu)*((y(i,1)-mu).^2+(y(i,3)).^2).^(-0.5);
    i=i+1;
end
end

