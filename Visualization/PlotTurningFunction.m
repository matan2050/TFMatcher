function [ handle ] = PlotTurningFunction( TF1, TF2 )

handle = figure;
stairs(TF1.Function.x, TF1.Function.y);

if nargin == 2
    hold on;
    stairs(TF2.Function.x, TF2.Function.y, 'color', 'red');
end

title('Turning Function');
xlabel('Relative shape length [-]');
ylabel('Cumulative angle [rad]');

end