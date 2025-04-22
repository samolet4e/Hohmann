function [y] = paintSatellite(X)

  global mu;

  set(gcf,'Position',[100,75,1600,900]);

  % Specific mechanical energy, Bate et al., p.16, (1.4-2)
  r = sqrt(X(:,1).^2 + X(:,2).^2 + X(:,3).^2);
  v2 = X(:,4).^2 + X(:,5).^2 + X(:,6).^2;

  r /= 1E+03;
  v2 /= 1E+06;

  Ek = v2./2;
  Ep = -mu./r;
  Et = v2./2 - mu./r; % vis-viva

  subplot(3,2,2);
  [j1] = plot(Ek(1),'LineWidth',2); grid on; hold on
  ylabel('Kinetic energy, km^2/s^2');
  set(gca,'FontSize',14);
  subplot(3,2,4);
  [j2] = plot(Ep(1),'LineWidth',2); grid on; hold on
  ylabel('Potential energy, km^2/s^2');
  set(gca,'FontSize',14);
  subplot(3,2,6);
  [j3] = plot(Et(1),'LineWidth',2); grid on; hold on
  ylabel('Total energy, km^2/s^2');
  set(gca,'FontSize',14);

  subplot(1,2,1);
  [h0] = paintCentralBody();
  [h1] = paintTrajectory(X(1:100,1:3));
  [h2] = paintTrajectory(X(101:125,1:3));
  [h3] = paintTrajectory(X(126:150,1:3));
  [h4] = paintTrajectory(X(151:250,1:3));

  x = X(1,1)/1E+03;
  y = X(1,2)/1E+03;
  z = X(1,3)/1E+03;

  [h] = plot3(x,y,z,'Marker','o','MarkerFaceColor','Black','MarkerSize',9);
%  [h] = scatter3(x,y,z,'Marker','o','MarkerFaceColor','Black');
  set(gca,'FontSize',14);
  axis equal
  hold on

  for i = 1:250
%    subplot(1,2,1);
    x = X(i,1)/1E+03;
    y = X(i,2)/1E+03;
    z = X(i,3)/1E+03;
    set(h,'XData',x,'YData',y,'ZData',z);
    pause(1/(2*sqrt(v2(i))));
%    pause(1E-02);

    ek = Ek(1:i);
    ep = Ep(1:i);
    et = Et(1:i);
    set(j1,'XData',1:i,'YData',ek);
    set(j2,'XData',1:i,'YData',ep);
    set(j3,'XData',1:i,'YData',et);

    rotate(h0,[0,0,1],0.35);
  endfor

  y = [h;j1;j2;j3];
endfunction
