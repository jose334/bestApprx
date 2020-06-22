modulo = 3;

fotos = 3;

fn = 'niga.jpg';
fo = imread(fn);
fn = size(fo);
x = round(fn(1));
y = round(fn(2));
fn = x*y;
A = zeros(fn,fotos);
u = cargar('niga2.jpg',modulo);
v = cargar('niga3.jpg',modulo);
w = cargar('niga.jpg',modulo);
u1 = cargar('niga5.jpg',modulo);
A(:,1) = u;
A(:,2) = v;
A(:,3) = w;
A(:,4) = u1;
b = cargar('niga4.jpg',modulo);

at=A';
aat=at*A;
for i=1:fotos^2
    aat(i)=mod(aat(i),modulo);
end

inversa=gj(aat,modulo);
pseudo=mmm(inversa,at,modulo);
x1=mmm(pseudo,b,modulo);
aproximacion=mmm(A,x1,modulo);

ozuna = sacarla(aproximacion,modulo,x,y);
foto1 = sacarla(u, modulo,x,y);
foto2 = sacarla(v, modulo,x,y);
foto3 = sacarla(w, modulo,x,y);
foto4 = sacarla(u1,modulo,x,y);
b = sacarla(b, modulo, x,y);

subplot(2,3,3), imshow(foto1), title('Foto 1')
subplot(2,3,4), imshow(foto2), title('Foto 2')
subplot(2,3,5), imshow(foto3), title('Foto 3')
subplot(2,3,6), imshow(foto4), title('Foto 4')
subplot(2,3,1), imshow(b), title('Original')
subplot(2,3,2), imshow(ozuna), title('Aproximacion')

%suma modular

function [y] = sm(z,x,m)
    y = zeros(size(z));
    for n=1:length(z)
        a=z(n);
        b=x(n);
        y(n)=mod(a+b,m);
    end
end

%productoEscalar
function [p] = prod(v,s,m)
    p = zeros(size(v));
    for i=1:length(v)
        p(i)=mod(s*v(i),m);
    end
end

% inverso multiplicativo

function [im] = f(s,m)
    for i=1:(m-1)
        if mod(i*s,m) == 1
           im=i;
        end
    end
end
         
% eliminacion de gauss jordan y convertir a matriz identidad

function [inv] = gj(a,m)
    s=size(a);
    s=s(1);
    e=eye(s);
    p=horzcat(a,e);
    for i=1:s
        for k=i:s
            if p(k,i)~=0
                x = p(k,:);
                y = p(i,:);
                p(i,:) = x;
                p(k,:) = y;
                break
            end
        end
        im = f(p(i,i),m);
        p(i,:) = prod(p(i,:),im,m); 
        for k=i+1:s
            if p(k,i)~=0
                x = p(k,i);
                y = -1*prod(p(i,:),x,m);
                p(k,:) = sm(p(k,:),y,m);
            end
        end
        for k=1:i-1
            if p(k,i) ~= 0
                x = p(k,i);
                y = -1*prod(p(i,:),x,m);
                p(k,:) = sm(p(k,:),y,m);
            end
        end
    end
    inv = p(:,s+1:2*s);
end             

function [y]=mmm(m,n,mo)
    y=m*n;
    s=size(y);
    s=s(1)*s(2);
    for i=1:s
        y(i)=mod(y(i),mo);
    end
end

function [A] = avalorespng(aproximacion,mo,x,y)
    A = disc2cont(aproximacion,mo,x,y);
end


function [ozuna] = crearfoto(i)
    i=i';
    s = length(i);
    h = zeros(s,s,3);
    for y=1:3
        h(:,:,y)=i;
    end
    ozuna=uint8(h);
end
