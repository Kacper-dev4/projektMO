clear all 

% Nelder Mead metoda algorytm 
tic
% Początkowe punkty w simplexie
x = [1,1,1;
     1,3,1;
     2,1,5;
     1,2,3];
%x = [3,10,6;
 %    1,1,1; 
  %   7,3,5;
   %  6,4,3];
J = zeros(1,4);
eps = 0.0001;
for i=1:4
    J(i) = symulacja(x(i,:)); 
end

[xsort, Jsort] = sortuj(x,J);

%% Tutaj zaczyna się pętla programu 

for j=1:30

niepowodzenie = 0;
% Odbicie 
centroid = sum(xsort(1:3,:))/3;

odbicie = 2*centroid - xsort(4,:);

Jodbicie = symulacja(odbicie);

% Przedłużenie 
if Jodbicie < Jsort(1)
    przedluzenie = odbicie + (centroid - xsort(4,:));
    Jprzedluzenie = symulacja(przedluzenie);
    if Jprzedluzenie < Jodbicie
        Jsort(4) = Jprzedluzenie;
        xsort(4,:) = przedluzenie;
    else
        Jsort(4) = Jodbicie;
        xsort(4,:) = odbicie;
    end
end

% Wstawianie
if Jsort(1) < Jodbicie && Jodbicie < Jsort(3)
    Jsort(4) = Jodbicie;
    xsort(4,:) = odbicie;
end

% Pomiędzy 
if Jsort(3) < Jodbicie
   ci = xsort(4,:) + (1/4)*(odbicie-xsort(4,:));
   Jci = symulacja(ci);
   co = xsort(4,:) + (3/4)*(odbicie-xsort(4,:));
   Jco = symulacja(co);
    if Jci < Jco && Jci < Jsort(3)
        Jsort(4) = Jci;
        xsort(4,:) = ci;
    elseif Jco < Jsort(3)
        Jsort(4) = Jco;
        xsort(4,:) = co;
    else
    niepowodzenie = 1;
    end
end

% Zmniejszanie
if Jsort(3) < Jodbicie && niepowodzenie
   for i=2:4
       xsort(i,:) = xsort(i,:) + (1/2)*(xsort(1,:) - xsort(i,:));
       Jsort(i) = symulacja(xsort(i,:));
   end
end
[xsort, Jsort] = sortuj(xsort,Jsort);
Jnajlepszy(j) = Jsort(1);

if std(Jsort) < eps
    break;
end

end

figure
plot(Jnajlepszy,'x','LineStyle','--')
xlabel('Iteracje')
ylabel('Najlepsza wartość wskaźnika jakości w iteracji')

toc




