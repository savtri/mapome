function y = JV_APPROX(v, F, x)

% calculate perturbation
dim = size(x, 2);

if norm(v, 2) > eps
    
    sum = 0;
    
    for i = 1 : dim
        
        sum = sum + sqrt(eps) * (1 + x(i));
        
    end
    
    per = (1 / (dim * norm(v, 2))) * sum;
    
else
    
    sum = 0;
    
    for i = 1 : dim
        
        sum = sum + sqrt(eps) * (1 + x(i));
        
    end
    
    per = sum / dim;
    
end

R = F(x); % unperturbed residual

xper = x' + per * v; % perturbed vector

Rper = F(xper); % perturbed residual

y = (Rper - R) / per; % approximation of jacobian action on krylov vector

end