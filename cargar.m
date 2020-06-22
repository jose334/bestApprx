function [c]=cargar(ima,m)   
    % cargar y convertir a z la base de imagenes
    v=imread(ima);
    v=v(:,:,3);
    v=v(:);
    c = cont2disc(v,m);
end