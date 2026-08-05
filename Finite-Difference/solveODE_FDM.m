function [Y,global_error,local_error] = solveODE_FDM(problem)
 
 % she said to change the way of the loop but this works too
    for N = 3:100
        
        h = (problem.b - problem.a) / (N - 1);
        x = linspace(problem.a, problem.b, N);
        
        %f(x) evaluated at each point
        fx = problem.f(x);

        
        A = zeros(N, N);
        b = zeros(N, 1);
        
        % Initial condition: Y(1) = problem.Y0
        A(1,1) = 1;
        b(1) = problem.Y0;

        % Use Euler for 2nd point to seed the method
        A(2,1) = -1;
        A(2,2) = 1;
        b(2) = h * fx(1);

        % Fill the system using backward difference from i = 3
        for i = 3:N
            A(i,i-2) = 1;
            A(i,i-1) = -4;
            A(i,i)   = 3;
            b(i) = 2*h * fx(i);
        end
        
        % Solve the linear system using \ not / which is over
        Y = A \ b;
        
        
        local_error = zeros(N,1);
        for i = 3:N
            derivative_numerical = (3*Y(i) - 4*Y(i-1) + Y(i-2)) / (2*h);
            derivative_exact = fx(i);
            local_error(i) = abs(derivative_numerical - derivative_exact);
        end

        %  Global Error (compared to exact solution)
        Y_exact = zeros(N,1);
        for i = 1:N
            Y_exact(i) = integral(@(t) t.^2 .* sin(t), 0, x(i)) + problem.Y0;
        end
        global_error = abs(Y - Y_exact);

        z = 0:0.1:pi;
        % Step 5: Plot exact and numerical solution
        figure(1); clf;
        plot(x, Y, 'r*-', 'LineWidth', 1.5); hold on;% use x to plot at each point
        plot(x, Y_exact, 'b--', 'LineWidth', 1.5);%use an interval [0:0.1:pi]
        legend('Numerical (FDM)', 'Exact');
        title(['N = ', num2str(N), '  |  Approx vs. Exact']);
        xlabel('x'); ylabel('Y(x)');
        grid on;
        %ylim([0 max(Y_exact)+0.5]);%she did not talk abt this
        pause(0.05);
        
    end
   

end

