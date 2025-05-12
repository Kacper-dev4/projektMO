function [J] = symulacja4(nastawy)

nastawy(nastawy<0) = 0.0001;
   assignin('base', 'P', nastawy(1));
   assignin('base', 'I', nastawy(2));
   assignin('base', 'D', nastawy(3));

    out = sim('ObiektZ.slx');
    e = out.e.Data;
    t = out.tout;
    e = e(t>=20);
 J = mean(abs(e));

end

