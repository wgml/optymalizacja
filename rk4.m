%{
Pseudoautorzy: Ciura, Gomu�ka i Prus
Opis: Funkcja chyba realizuj�ca algorytm Rungego Kutty 4. rz�du
%}

function [t,x] = rk4(x0,u,tf)
% x0 - stan pocz�tkowy
% u - macierz sterowa� - wiersze stanowi� wektory steorowa� dla kolejnych chwil czasu
% tf - 'final time'

nt = length(u(:,1));	%liczba w�z��w dyskretyzacji
n = length(x0);			%liczba zmiennych stanu
h = tf/nt;				%wielko�� kroku
x = zeros(nt,n);		%inicjalizacja 'macierzy stanu' (wiersze stanowi� wektory stanu dla kolejnych w�z��w dyskretyzacji)
x(1,:) = x0';			%pierwszy wiersz macierzy - warunek pocz�tkowy
xtmp = x0;				%zmienne stanu w kolejnych krokach dyskretyzacji
t = 0;					%czas pocz�tkowy

%inicjalizacja ki
k1 = zeros(n,1);
k2 = k1;
k3 = k1;
k4 = k1;

%g��wna cz�� obliczeniowa
for i = 1:nt
	k1 = rhs(t,xtmp,u(i,:));
	k2 = rhs(t+h/2,xtmp + h/2*k1,u(i,:));
	k3 = rhs(t+h/2,xtmp+h/2*k2,u(i,:));
	k4 = rhs(t+h,xtmp+h*k3,u(i,:));
	xtmp = xtmp + h/6*(k1+k4) + h/3*(k2+k3);
	x(i+1,:) = xtmp';
	t = t+h;
end

t = linspace(0,tf,nt+1)';	%zwracany wektor czasu