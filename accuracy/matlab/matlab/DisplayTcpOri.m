function DisplayTcpOri(fig,X,Y,Z,Xx,Xy,Xz,Yx,Yy,Yz,Zx,Zy,Zz,dis_ori,do_clf)
    figure (fig)
    if(do_clf)
      clf
    end
     hold on;
     grid on;
     plot3(X,Y,Z,'. -');


   step_num = size(X,2);
%    display_period = 1:fix(step_num/100):step_num;
   display_period=1:1:step_num;

   if dis_ori
       quiver3(X(display_period),Y(display_period),Z(display_period),Xx(display_period),Xy(display_period),Xz(display_period))
       quiver3(X(display_period),Y(display_period),Z(display_period),Yx(display_period),Yy(display_period),Yz(display_period))
       quiver3(X(display_period),Y(display_period),Z(display_period),Zx(display_period),Zy(display_period),Zz(display_period))
   end

     axis equal;
    title('Trajectory')
end
