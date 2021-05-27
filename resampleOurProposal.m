function [ indx ] = resampleResidual(w, N)
if nargin == 1
   N = length(w);
end
M = length(w);
w = w / sum(w);
indx = zeros(1, N);
% integer parts:
Ns = floor(N.* w);
R = sum(Ns);
% Draw the deterministic part:
i = 1;
j = 0;
while j < M
    j = j + 1;
    cnt = 1;
  while cnt <= Ns(j)
    indx(i) = j;  %update fuck indx from zero! the order starts from 1 not zero!
    i = i + 1; cnt = cnt + 1;
  end;
end;
% The fractions: Multinomial) resampling
N_rdn = N - R;
Ws =(N*w - Ns)/N_rdn;
Q = cumsum(Ws);
% while(i <= N)
%     sampl = rand;  %(0,1]
%     j = 1;
%     while(Q(j) < sampl),
%         j = j + 1;
%     end;
%     indx(i) = j;
%     i = i + 1;
% end
 
%the upgraded algorithm that I used:
w=indx/sum(indx);
q=cumsum(w);
while(i<=N)
    sampl=rand;
    j=1;
    while(q(j)<sampl)
        j=j+1;
    end;
    indx(i)=indx(j);
    i=i+1;
end

