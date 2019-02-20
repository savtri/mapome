%{
  Title: Jacobian-Free Newton-Krylov method
  Author: Cheuk Lau
  Date: 1/20/2014
  Description: This function solves a system of non-linear equations using
               the Jacobian-Free Newton-Krylov (JFNK) method. The main
               advantage of using JFNK over the traditional Newton method
               is to avoid the need for generating and inverting the
               Jacobian matrix. Typically the Jacobian matrix is not
               analytically attainable and its numerical approximation
               (e.g., via finite-difference methods) is not easily
               invertible.
  Files required: (1) JFNK.m - Main function file
                  (2) JV_APPROX.m
  Reference: (1) Knoll D.A., Keyes D.E. "Jacobian-Free Newton-Krylov
                 methods: a survey of approaches and applications",
                 Journal of Computational Physics, August 2003.
  Input parameters: F = Function handle of nonlinear equations in their
                        residual form
                    x0 = Initial guess
                    epsilon = Error tolerance
                    max_iter = Maximum number of JFNK iterations
                    (See sample input for format)
  Output: x = Converged solution
          R = Residual using converged solution
  Sample input:
        F = @(x) [...
        % equation 1
        0.1309 * 1 / sqrt(3) * ...
        (1 / sqrt(1 / 3 + x(1) ^ 2 + x(1) ^ 2) + ...
         1 / sqrt(1 / 3 + x(2) ^ 2 + x(4) ^ 2) + ...
         1 / sqrt(1 / 3 + x(3) ^ 2 + x(3) ^ 2) + ...
         1 / sqrt(1 / 3 + x(4) ^ 2 + x(2) ^ 2)) - 0.4352;
        % equation 2
        0.1309 * ...
        (x(1) / sqrt(1 / 3 + x(1) ^ 2 + x(1) ^ 2) + ...
         x(2) / sqrt(1 / 3 + x(2) ^ 2 + x(4) ^ 2) + ...
         x(3) / sqrt(1 / 3 + x(3) ^ 2 + x(3) ^ 2) + ...
         x(4) / sqrt(1 / 3 + x(4) ^ 2 + x(2) ^ 2)) - 0.1751;
        % equation 3
        0.1309 * ...
        (x(1) / sqrt(1 / 3 + x(1) ^ 2 + x(1) ^ 2) + ...
         x(4) / sqrt(1 / 3 + x(2) ^ 2 + x(4) ^ 2) + ...
         x(3) / sqrt(1 / 3 + x(3) ^ 2 + x(3) ^ 2) + ...
         x(2) / sqrt(1 / 3 + x(4) ^ 2 + x(2) ^ 2)) - 0.1751;
        % equation 4
        0.1309 * 1 / sqrt(3) * ...
        (x(1) / (1 / 3 + x(1) ^ 2 + x(1) ^ 2) + ...
         x(2) / (1 / 3 + x(2) ^ 2 + x(4) ^ 2) + ...
         x(3) / (1 / 3 + x(3) ^ 2 + x(3) ^ 2) + ...
         x(4) / (1 / 3 + x(4) ^ 2 + x(2) ^ 2)) - 0.1395; ];
        
        x0 = [0.4330, 0.4330, 0.1443, 0.1443];

        epsilon = 1e-5;

        max_iter = 10;

  Output:
        x = [0.4151, 0.3863, 0.0976, 0.0818]

        R = 1.0e-6 * [-0.0367, -0.2264, -0.2264, -0.2882] 
%}

function [x, R] = JFNK(F, x0, epsilon, max_iter)

R = F(x0); % initial residual

x = x0; % initialize solution vector

counter = 1; % iteration counter

while norm(R, 2) > epsilon
    
    j_v_approx = @(v)JV_APPROX(v, F, x);
    
    %restartId=[];
    %tol=1e-6;
    %[v,flagId] = gmres(j_v_approx, R,restartId,tol,1); % solve for Krylov vector
    v = gmres(j_v_approx, R); % solve for Krylov vector
    
    x = x - v'; % updated solution
    
    R = F(x); % new residual
    
    if counter > max_iter
        
        error('JFNK method did not converge!');
        
    end
    
    counter = counter + 1; % update iteration counter
        
end

fprintf('The norm of the error is: %f', norm(R, 2)); % norm of the residual

end