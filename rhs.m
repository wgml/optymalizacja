function dx = rhs(t,x,u)

%t nieuzywane
if(length(u)<2)
	error('Zly wektor sterowan reaktora');
elseif(length(x)<4)
	error('Zly wektor stanu reaktora')
end

%inicjalizacja stałych
z1 = 8;			%cA0			!!!
z2 = 300;			%T0				!!!
H1 = 1.49362966945975;
H2 = -3.91188722953745;
H3 = -14.88295277783112;
A1 = 30.82851637764932;
A2 = 86.688;
k1 = exp(27.8833-9758.3/x(3));
k2 = exp(27.8833-9758.3/x(3));
k3 = exp(22.9253-8560/x(3));

dx = zeros(length(x),1);
dx(1) =  u(1)*(z1-x(1)) - k1*x(1) - k3*x(1)^2;
dx(2) = -u(1)*x(2) + k1*x(1) - k2*x(2);
dx(3) = u(1)*(z2 - x(3)) - (k1*x(1)*H1 + k2*x(2)*H2 + k3*x(1)^2*H3) + A1*(x(4)-x(3));
dx(4) = -u(2) + A2*(x(3)-x(4));
