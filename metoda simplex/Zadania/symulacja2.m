function [J] = symulacja2(nastawy)

nastawy(nastawy<0) = 0.0001;
   assignin('base', 'P', nastawy(1));
   assignin('base', 'I', nastawy(2));
   assignin('base', 'D', nastawy(3));

    out = sim('Obiekt123.slx');
    e = out.e.Data;
    t = out.tout;
    e = e(t>=20);
    t = t(t>=20);
 J = trapz(t,e.^2);

end



