function [y] = paintCentralBody()

  global ER

  [xx,yy,zz] = sphere(25);
  imData = imread('private/map.jpg');
  R = ER/1000.;
  s1 = surf(R*xx,R*yy,-R*zz);
  xlabel('X, km'); ylabel('Y, km'); zlabel('Z, km');
  %https://www.reddit.com/r/matlab/comments/25w7zf/how_would_i_put_an_image_on_a_sphere_in_matlab/
  set(s1,'facecolor','texturemap','cdata',imData,'edgecolor','none');
  axis equal
  hold on

  y = s1;

endfunction
