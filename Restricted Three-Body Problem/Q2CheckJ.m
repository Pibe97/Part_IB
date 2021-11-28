function [J ] = Q2CheckJ(y )
%Similar to CheckJ but with the approximations from Question 2.

J=1:size(y,1);
i=1;
while i<=size(y,1)
    J(i)=0.5*y(i,2).^2+0.5*y(i,4).^2-0.5/(y(1,1)-0.5);
    i=i+1;
end
end