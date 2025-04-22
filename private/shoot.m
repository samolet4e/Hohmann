function [y1,y2] = shoot(X0,X1,xd,tspan,options)

  x0 = X0(1:3);
  v0 = X0(4:6);
  Phi0 = reshape(eye(6),1,36);%X0(7:42);

  x1 = X1(end,1:3);
  dx = xd - x1;
  err = norm(dx,2);
  eps = 1E-03;

  i = 1;
  while err > eps

    printf('i = %d err = %f\n',i,err);

    PhiRV = reshape(X1(7:42),6,6)(1:3,4:6);
    dv = inv(PhiRV)*dx';

    v0 += dv';
    X0 = [x0,v0,Phi0];

    [T,X] = ode45(@(t,X)func(X),tspan,X0,options);
    X1 = X(end,:);

    x1 = X1(1:3);
    dx = xd - x1;
    err = norm(dx,2);

    i += 1;
  endwhile

  y1 = T;
  y2 = X;
endfunction

