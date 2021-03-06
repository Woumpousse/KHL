function [maxFrom,maxTo,maxSum] = MaxSom(V)
    maxFrom = 1; maxSum = sum(V(1:3))
    n = length(V); s = maxSum

    for i = 2:n-2
        s = s - V(i-1) + V(i+2)
        
        if s > maxSum then
            maxSum = s; maxFrom = i
        end
    end
 
    maxTo = maxFrom + 2   
endfunction
