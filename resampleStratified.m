function [ indx ] = resampleStratified(w, N)
if nargin == 1
  N = length(w);
end
M = length(w);
w = w / sum(w);
Q = cumsum(w);
indx = zeros(1, N);
T = linspace(0, 1-1/N, N) + rand(1, N)/N;

i = 1;
j = 1;
while(i<= N && j<= M),
    while Q(j) < T(i)
        j = j + 1;
    end
    indx(i) = j;
    i = i + 1;
end


