function [y] = paintTrajectory(X)

  h = plot3(X(:,1)/1000.,X(:,2)/1000.,X(:,3)/1000.,'LineWidth',2);
  grid on
  xlabel('X,km'); ylabel('Y,km'); zlabel('Z,km');
  axis equal
  hold on

  y = h;

endfunction
