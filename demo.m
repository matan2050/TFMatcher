% define shapes using their turning points
points1 = [0 0; 0 1; 1 1; 1 0; 0 0];
points2 = [0 0; 0 5; 5 5; 5 0; 0 0];
points3 = 100*rand(10,2); points3 = [points3; points3(1,:)];
%points3 = 100*rand(1000, 2); points3 = [points3; points3(1,:)];

% create turning functions
tfSquare1 = CreateTurningFunction(points1);
tfSquare2 = CreateTurningFunction(points2);
tfRand    = CreateTurningFunction(points3);


% compare shapes
shapeDifference_square2square   = TfDistance(tfSquare1, tfSquare2);
shapeDifference_square2rand     = TfDistance(tfSquare1, tfRand); 

% plot turning functions
PlotTurningFunction(tfSquare1);
PlotTurningFunction(tfSquare2);
PlotTurningFunction(tfRand);
PlotTurningFunction(tfSquare1, tfRand);