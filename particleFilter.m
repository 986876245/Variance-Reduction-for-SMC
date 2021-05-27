function[xHatFiltered, logLikelihood,BeforeResampling,AfterResampling,TT] = particleFilter(observations, parameters, noParticles, initialState)
  
  noObservations = length(observations) - 1;
  phi = parameters(1);
  sigmav = parameters(2);
  sigmae = parameters(3);  
  
  particles = zeros(noParticles, noObservations + 1);
  ancestorIndices = zeros(noParticles, noObservations + 1);
  weights = ones(noParticles, noObservations + 1);
  normalisedWeights = ones(noParticles, noObservations + 1) / noParticles;
  xHatFiltered = zeros(noObservations + 1, 1);
  
  logLikelihood = 0;
  ancestorIndices(:, 1)= 1:noParticles;  
  xHatFiltered(1) = initialState;
  particles(:, 1) = initialState;
  
  %AveragedWeights = zeros(noParticles, noObservations);
  %VarianceWeights = zeros(noParticles, noObservations);
  
  BeforeResampling=zeros(noParticles, noObservations);
  AfterResampling=zeros(noParticles, noObservations);
  TT=zeros(1,noObservations-1)
  
  for t = 2:noObservations
    % Resample (multinomial)
    if t==2
        BeforeResampling(:,t-1)=normalisedWeights(:,t - 1);
        newAncestors = randsample(noParticles, noParticles, true, normalisedWeights(:,t - 1)); 
        AfterResampling(:,t-1)=normalisedWeights(newAncestors,t - 1);

    else
        BeforeResampling(:,t-1)=normalisedWeights(:,t - 1);
        tic
        newAncestors = resampleOurProposal(normalisedWeights(:,t - 1),noParticles);
        TT(t-1)=toc
        AfterResampling(:,t-1)=normalisedWeights(newAncestors,t - 1);
    end
    ancestorIndices(:, 1:(t - 1)) = ancestorIndices(newAncestors, 1:(t - 1));
    ancestorIndices(:, t) = newAncestors;
    
    % Propagate
    part1 = ( sigmav^(-2) + sigmae^(-2) )^(-1);
    part2 = sigmae^(-2) .* observations(t);
    part2 = part2 + sigmav^(-2) .* phi .* particles(newAncestors, t - 1);
    particles(:, t) = part1 .* part2 + sqrt(part1) .* normrnd(0, 1, noParticles, 1);
    
    % Compute weights
    weights(:, t) = dnorm(observations(t + 1), phi .* particles(:, t), sqrt(sigmae^2 + sigmav^2));
    
    maxWeight = max(weights(:, t));
    weights(:, t) = exp(weights(:, t) - maxWeight);
    sumWeights = sum(weights(:, t));
    normalisedWeights(:, t) = weights(:, t) / sumWeights;    
    
    % Estimate the log-likelihood
    predictiveLikelihood = maxWeight + log(sumWeights) - log(noParticles);
    logLikelihood  = logLikelihood + predictiveLikelihood;
    
    % Estimate the state
    xHatFiltered(t) = mean(particles(:,t));
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helper for computing the logarithm of the Gaussian density
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[out] = dnorm(x, mu, sigma)
    out = -0.5 .* log(2 * pi) - 0.5 .* log(sigma.^2) - 0.5 ./ sigma.^2 .* (x - mu).^2;
end
