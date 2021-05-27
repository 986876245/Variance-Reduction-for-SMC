function [ indx ] = resampleMultinomial(w, N)
if nargin == 1
  N = length(w);
end
w = w / sum(w);
Q = cumsum(w);

indx = zeros(1, N);
i = 0;
while i < N
    i = i + 1;
    sampl = rand;  % ~(0,1]
    j = 1;
    while Q(j) < sampl
        j = j + 1;
    end;
    indx(i)= j;
end
