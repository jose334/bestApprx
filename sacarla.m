function [A] = sacarla(a,m,x,y)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    A = disc2cont(a,m,x,y);
    A = uint8(A);
    %imshow(A);
end