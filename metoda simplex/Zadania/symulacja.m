function [J] = symulacja(nastawy)

nastawy(nastawy<0) = 0.0001;
   assignin('base', 'P', nastawy(1));
   assignin('base', 'I', nastawy(2));
   assignin('base', 'D', nastawy(3));

    out = sim('Obiekt123.slx');
    e = out.e.Data;
    t = out.tout;
 J = trapz(t,e.^2);

end

