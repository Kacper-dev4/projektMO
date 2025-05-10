function [xsort, Jsort] = sortuj(x,J)
Jsort = sort(J);
xsort = x;
for i=1:4
    idx = J == Jsort(i);
    xsort(i,:) = x(idx,:); 
end
end

