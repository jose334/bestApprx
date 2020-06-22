function [A] = cont2disc(a,m)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    A = zeros(size(a));
    s = length(A);
    for i=1:s
        A(i) = round((m-1)*double(a(i))/255);
    end
end