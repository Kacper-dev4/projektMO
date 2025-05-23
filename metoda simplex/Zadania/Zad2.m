clear all 

% Nelder Mead metoda algorytm 
tic
% Początkowe punkty w simplexie%
x = [1,1,1; %0.957175925925926	1.54282407407407	1.24307500000000
    1,3,1;
     2,1,5;
     1,2,3];
%x = [3,1,6;  %4.12655779320988	2.48072445987654	1.56776614583333
 %    2,1,2;
  %   7,6,5;
   %  11,4,5];
%x = [0.001, 0.001, 0.001;
 %    1 ,0.001, 0.001;
  %   0.001,1,0.001;
   %   0.001,0.001,1];
J = zeros(1,4);
eps = 0.0001;
for i=1:4
    J(i) = symulacja2(x(i,:)); 
end

[xsort, Jsort] = sortuj(x,J);

%% Tutaj zaczyna się pętla programu 

for j=1:50

niepowodzenie = 0;
% Odbicie 
centroid = sum(xsort(1:3,:))/3;

odbicie = 2*centroid - xsort(4,:);

odbicie(odbicie<0) = 0.0001;
Jodbicie = symulacja2(odbicie);

% Przedlużenie 
if Jodbicie < Jsort(1)
    przedluzenie = odbicie + (centroid - xsort(4,:));
    przedluzenie(przedluzenie<0) = 0.0001;
    Jprzedluzenie = symulacja2(przedluzenie);
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
   ci(ci<0) = 0.0001;
   Jci = symulacja2(ci);
   co = xsort(4,:) + (3/4)*(odbicie-xsort(4,:));
   co(co<0) = 0.0001;
   Jco = symulacja2(co);
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
       Jsort(i) = symulacja2(xsort(i,:));
   end
end
[xsort, Jsort] = sortuj(xsort,Jsort);

Jnajlepsze(j) = Jsort(1);

if std(Jsort) < eps
    break;
end



end
toc

figure
plot(Jnajlepsze,'x','LineStyle','--')
xlabel('Iteracje')
ylabel('Najlepsza wartość wskaźnika jakości w iteracji')




