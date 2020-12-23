clc;
close all;
clear all;

%Inputs
b = 0.05;
g = 9.81;
l = 1;
m = 1;

%Initial Condition
theta_0 = [0;3]; % initial value of displacement & velocity

%Time span
t_span = linspace(0,20,200); %time range of oscillation

%Solve 2nd order ODE 
[t,results] = ode45(@(t,theta) first(t,theta,b,g,l,m), t_span, theta_0);
figure(1)
plot(t, results(:,1))
hold on
plot(t, results(:,2))
xlabel('time')
ylabel('plot')
legend('displacement', 'velocity')

figure(2)
grid on

%counter
ct = 1;

for i=1:length(results)
    THETA = results(i,1);
    x0 = 0;
    y0 = 0;
    x1 = l*sin(THETA);
    y1 = -l*cos(THETA);
    plot([x0,x1],[y0,y1], 'LineWidth', 3)
    hold on
    plot(x1,y1, 'o', 'MarkerSize', 20, 'MarkerFaceColor', 'r', 'Linewidth', 3)
    pause(0.3)
    axis([-2 2 -2 0])
    M(ct) = getframe(gcf);
    ct = ct+1;
    hold off
end

movie(M);
videofile = VideoWriter('simple_pendulum.avi', 'uncompressed AVI');
open(videofile)
writeVideo(videofile,M)
close(videofile)


%% Function

function[dtheta_dt] = first(t,theta, b, g, l, m)
theta1 = theta(1);
theta2 = theta(2);
dtheta1_dt = theta2;
dtheta2_dt = -(b/m)*theta2-(g/l)*sin(theta1);
dtheta_dt = [dtheta1_dt; dtheta2_dt];
end



    
    

