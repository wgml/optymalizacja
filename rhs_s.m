function [o] = rhs_s(t,x,u)
u1_lim = [-27 5];
u2_lim = [-537.428732104031 362.571267895969];
H1 = 1.49362966945975;
H2 = -3.91188722953745;
H3 = -14.88295277783112;
A1 = 30.82851637764932;
A2 = 86.688;
ER = [9758.298854998557, 9758.298854998557, 8559.992302511306];
ZC = 273.15;
k0 = [27.88333504454254 27.88333504454254 22.92525681470475];
% x0 = [3.466354387179 0.80 106.757396218858 100.557821512970];
u0 = [30 100.557821512970];
% z0 = [5.1 104.9078585593333];
v1= u(1)+u0(1);
v2=u(2)+u0(2);
tmp=x(3)+ZC;
x32a=tmp*tmp;
k = exp(k0 - ER/tmp);
dk = ER ./ k / x32a;

A11 = -(v1+k(1))-2*k(3)*x(1);
A12 = k(1);
A13 = -(k(1)*H1+2*k(3)*H3*x(1));

A22 = -(v1+k(2));
A23 = -k(2)*H2;

A31 = -dk(1)*x(1)-dk(3)*x(1)*x(1);
A32 =  dk(1)*x(1)-dk(2)*x(2);
A33 = -v1-(dk(1)*x(1)*H1+dk(2)*x(2)*H2+dk(3)*x(1)*x(1)*H3)-A1;
A34 =  A2;
A43 =  A1;
A44 = -A2;

A = [A11, A12, A13, 0;
    0, A22, A23, 0;
    A31, A32, A33, A34;
    0, 0, A43, A44];
o = -A * x;
end