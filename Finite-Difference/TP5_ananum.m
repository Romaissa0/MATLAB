problem = struct();
problem.f = @(x) x.^2 .* sin(x);       
problem.b = pi;                        
problem.Y0 = 1;        
problem.a = 0; 
problem.interval = [0;pi];
[D,er,l_er] = solveODE_FDM(problem)
% search for .mat to save variable
