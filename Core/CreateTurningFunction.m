function [ TF, tfMat, itfMat ] = CreateTurningFunction( tp )
% function will take a list of turning points for the polygon or polyline
% and return a normalized vectors for the shape and the turning function
% 
% tp - the turning points for the shape
%
% tf - the turning function for that set of turning points
% itf - the turning function in for the inverted set of turning points

TF = [];
TF.Function = [];
TF.Function.y = [];
TF.Function.x = [];
TF.InvFunction = [];
TF.InvFunction.y = [];
TF.InvFunction.x = [];

nTurningPoints = size(tp, 1) - 1;

lineVec = nan(nTurningPoints, 2);
invLineVec = nan(nTurningPoints, 2);
perimeter = 0;

for i = 1:nTurningPoints
    
    % calculating current element in turning function
    lineVec(i,1) = tp(i+1, 1)-tp(i, 1);
    lineVec(i,2) = tp(i+1, 2)-tp(i, 2);
    
    % summing perimeter of the polygon
    perimeter = perimeter + norm(lineVec(i,:));
    
    % calculating current element in reverse turning function
    invLineVec(i,1) = tp(nTurningPoints+1-i, 1) - tp(nTurningPoints+2-i, 1);
    invLineVec(i,2) = tp(nTurningPoints+1-i, 2) - tp(nTurningPoints+2-i, 2);
end


% creating normalized segments of turning function
unitLineVec = nan(size(lineVec));
unitInvLineVec = nan(size(invLineVec));


for i = 1:size(lineVec,1)
    unitLineVec(i,:) = lineVec(i,:) / perimeter; %* (norm(lineVec(i,:)) / perimeter);
    unitInvLineVec(i,:) = invLineVec(i,:) / perimeter; %* (norm(invLineVec(i,:)) / perimeter);
end


% using dot products between unit vectors to create the turning functions y
%values
angles = nan(nTurningPoints, 1);
invAngles = nan(nTurningPoints, 1);


% calculating values of turning angles
angles(1) = acos(dot(unitLineVec(1,:), [1 0]));
invAngles(1) = acos(dot(unitInvLineVec(1,:), [1 0]));

for i = 2:nTurningPoints-1
    angles(i) = acos(dot(unitLineVec(i,:), unitLineVec(i+1,:))); 
    invAngles(i) = acos(dot(unitInvLineVec(i,:), unitInvLineVec(i+1,:))); 
end


% finally, adding the last angle between the last and first lines
angles(end) = acos(dot(unitLineVec(nTurningPoints, :), unitLineVec(1, :)));
invAngles(end) = acos(dot(unitInvLineVec(nTurningPoints, :), unitInvLineVec(1,:)));


% summing angles to create the turning function's y values
nAngles = length(angles);
TF.Function.y = nan(nAngles + 1, 1);
TF.InvFunction.y = nan(nAngles + 1, 1);
sum = 0;
invSum = 0;
for i = 1:nAngles
    sum = sum + angles(i); 
    invSum = invSum + invAngles(i);
    TF.Function.y(i) = sum;
    TF.InvFunction.y(i) = invSum;
end
TF.Function.y(end) = sum;
TF.InvFunction.y(end) = invSum;


% summing perimeter lengths for function's x values
TF.Function.x = nan(nAngles + 1, 1);
TF.InvFunction.x = nan(nAngles + 1, 1);
sum = 0;
invSum = 0;

TF.Function.x(1) = 0;
TF.InvFunction.x(1) = 0;

for i = 2:nAngles
   sum = sum + norm(unitLineVec(i,:));
   invSum = invSum + norm(unitInvLineVec(i,:));
   TF.Function.x(i) = sum;
   TF.InvFunction.x(i) = invSum;
end

% closing the function on total length 1
TF.Function.x(end) = 1;
TF.InvFunction.x(end) = 1;


% for interfacing purposes, matrix that hold xs and ys
tfMat = [TF.Function.x, TF.Function.y];
itfMat = [TF.InvFunction.x, TF.Function.y];

end