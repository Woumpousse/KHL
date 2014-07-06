function y=f(x)
  y=60*x^2+5*x+1
endfunction

function y=g(x)
  y=66*x^2
endfunction

function y=k(x)
  y=60*x^2
endfunction

clf;
x=50:60;
plot(x,f(x),'k');
plot(x,g(x),'b');
plot(x,k(x),'k--');
a=gca(); // Handle on axes entity
//a.x_location = "origin"; 
//a.y_location = "origin";
a.tight_limits="on";
a.data_bounds=[55,57,181500,210000];

function y=a(x)
  y=(x^2+x)/2
endfunction

function y=b(x)
  y=x^2
endfunction

function y=c(x)
  y=x
endfunction

function y=d(x)
  y=x^2/4
endfunction

clf;
x=0:100;
plot(x,a(x),'k');
plot(x,b(x),'k-.');
plot(x,c(x),'k');
plot(x,d(x),'k--');
gr=gca(); // Handle on axes entity
gr.x_location = "origin"; 
gr.y_location = "origin";
gr.tight_limits="on";
gr.data_bounds=[0,100,0,500];


    