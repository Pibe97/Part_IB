function [ m ] = Decode( c,p,q,d )
%Transforms a coded number c into its original form

n=p*q;
phi=(p-1)*(q-1);
d_bin=dec2bin(d);
max=length(num2str(d_bin));

powers=zeros(1,max);
powers(1)=mod(c,n);

i=2;
while i<=max
    powers(i)=mod(powers(i-1)^2,n); 
    i=i+1;
end
i=max;

m=1;
s=num2str(d_bin);

while i>=1
    if s(i)=='1'
        m=mod(m*powers(max-i+1),n);
    end
    i=i-1;
end

end

