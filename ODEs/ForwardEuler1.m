function [ x, Y , E] = ForwardEuler1(h,N)
%ForwardEuler1 takes as input the step size h and the number of steps N to 
%be done. It then calculates an approximate solution to a certain type of
%differential equation.

f= @(x,y) -16*y+15*exp(-x);
x=0:N;
Y=0:N;
E=0:N;
x(1)=0;
Y(1)=0;
E(1)=0;
i=2;

while i<=N+1
  Y(i)=Y(i-1)+h*f(x(i-1),Y(i-1));
  x(i)=x(i-1)+h;
  yxn= exp(-x(i))-exp(-16*x(i));
  En=Y(i)-yxn;
  E(i)=abs(En);
  disp([' ']); % for neatness
  disp(['x_' num2str(i-1) ' = ' num2str(x(i))]); %detailed output
  disp(['Y_' num2str(i-1) ' = ' num2str(Y(i))]);
  disp(['y(x_' num2str(i-1) ') = ' num2str(yxn)]);
  disp(['E_' num2str(i-1) ' = ' num2str(En)]);
  i=i+1;
end

end

