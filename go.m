clear;

global mu ER J2;

mu = 3.986004418E+14; % m^3.s^-2
ER = 6378137.; % m
J2 = 1.08262668E-3;

options = odeset('RelTol',1e-13,'AbsTol',1e-13);

xi = [7020999.1,-1393251.1,5459.1779, 1889.9796,6409.0502,4536.9642];

x0 = xi(1:3); v0 = xi(4:6);
Phi0 = eye(6);
X0 = [x0,v0,reshape(Phi0,1,36)];

tspan = linspace(0,2.21*60*60,100);
[T,X] = ode45(@(t,X)func(X),tspan,X0,options);

dlmwrite('data.csv',X(:,1:6),',','append','off');
[y] = paintCentralBody();
[y] = paintTrajectory(X);

% First shoot
X0 = X(end,:);
x1 = X(37,1:3);
xd = 2.*x1/norm(x1,2)*ER;

tspan = linspace(0,1.*60*60,25); % required to adjust transition curve shape
[T,X] = shoot(X0,X(37,:),xd,tspan,options);

dlmwrite('data.csv',X(:,1:6),',','append','on');
[y] = paintTrajectory(X);

% Propagate new trajectory
X0 = X(end,:);
tspan = linspace(0,1.*60*60,100);
[T,X] = ode45(@(t,X)func(X),tspan,X0,options);

%%%dlmwrite('data.csv',X(:,1:6),',','append','on');
%[y] = paintTrajectory(X);

% Second shoot to rectify the new trajectory
x1 = X(end,1:3);
xd = 2.*x1/norm(x1,2)*ER;

tspan = linspace(0,1.*60*60,25);
[T,X] = shoot(X0,X(end,:),xd,tspan,options);

dlmwrite('data.csv',X(:,1:6),',','append','on');
[y] = paintTrajectory(X);

% Propagate new trajectory
X0 = X(end,:);
tspan = linspace(0,2.5*60*60,100);
[T,X] = ode45(@(t,X)func(X),tspan,X0,options);

dlmwrite('data.csv',X(:,1:6),',','append','on');
[y] = paintTrajectory(X);

