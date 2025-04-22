function [y] = func(X)

  global mu J2 ER

  x = X(1);
  y = X(2);
  z = X(3);

  r = sqrt(x^2 + y^2 + z^2);

  ax = -mu/r^3*(1. + 3./2.*J2*ER^2/r^2*(1. - 5.*z^2/r^2));
  ay = ax;
  az = -mu/r^3*(1. + 3./2.*J2*ER^2/r^2*(3. - 5.*z^2/r^2));

  F = [
      [0,0,0,1,0,0];
      [0,0,0,0,1,0];
      [0,0,0,0,0,1];
      [ax,0,0,0,0,0];
      [0,ay,0,0,0,0];
      [0,0,az,0,0,0];
      ];

  A = A([x,y,z]);
  Phi = reshape(X(7:42),6,6);

  y1 = F*X(1:6);
  y2 = A*Phi;

  y = [y1;reshape(y2,1,36)'];

endfunction
