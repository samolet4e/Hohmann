function [y] = A(X)

  global mu J2 ER;

  x = X(1);
  y = X(2);
  z = X(3);

  r = sqrt(x^2 + y^2 + z^2);
  ax = -mu*x/r^3*(1 + 3/2*J2*ER^2/r^2*(1 - 5*z^2/r^2));

  daxdx = mu/r^5*(3*x^2 - r^2 - 3/2*J2*ER^2 + 15/2*J2*ER^2/r^2*(x^2 + z^2) - 105/2*J2*ER^2/r^4*x^2*z^2);
  daxdy = 3*mu*x*y/r^5*(1 + 5/2*J2*ER^2/r^2 - 35/2*J2*ER^2/r^4*z^2);
  daxdz = 3*mu*x*z/r^5*(1 +15/2*J2*ER^2/r^2 - 35/2*J2*ER^2/r^4*z^2);

  daydx = daxdy;
  daydy = y/x*daxdy + ax/x;
  daydz = y/x*daxdz;
  dazdx = daxdz;
  dazdy = daydz;
  dazdz = mu/r^5*(-r^2 + 3*(z^2 - 3/2*J2*ER^2 + 15*J2*ER^2/r^2*z^2 - 35/2*J2*ER^2/r^4*z^4));

  dadr = [
         [daxdx,daxdy,daxdz];
         [daydx,daydy,daydz];
         [dazdx,dazdy,dazdz];
         ];

  A = [[zeros(3),eye(3)];[dadr,zeros(3)]];

  y = A;
endfunction
