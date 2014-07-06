function y=like(x)
    if x<0 then
        error("het aantal likes moet positief zijn")
    end
    if x<=1000 then
        y=x
    elseif x<=5000
        y=1000+0.80*(x-1000)
    else
        y=1000+0.80*4000+1.20*(x-5000)
    end
endfunction

clf
x=0:7000
xgrid
plot(x,like)
