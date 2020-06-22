function [A] = disc2cont(a,mo,x,y)
    s = length(a);
    A = zeros(size(a));
    for i=1:s
        A(i) = round(255*(a(i))/(mo-1));
    end
    A = reshape(A,x,y);
end