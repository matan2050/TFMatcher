function [ difference ] = TfDistance( tfL, tfR )
% function will calculate the metric distance between the two turning
% functions

if isstruct(tfL)
    tfL = [tfL.Function.x, tfL.Function.y];
    tfR = [tfR.Function.x, tfR.Function.y];
end

m = size(tfL,1);
n = size(tfR,1);

% building the xEventOrder vector that holds the x values of each point
% where there is a change in the turning function y value
xEventOrder = tfL(:,1);
xEventOrder = [xEventOrder; tfL(size(tfL,1),1)];
xEventOrder = [xEventOrder; tfR(:,1)];
xEventOrder = [xEventOrder; tfR(size(tfR,1),1)];
xEventOrder = sort(xEventOrder);
xEventOrder = unique(xEventOrder);

difference = 0;

for i=2:1:length(xEventOrder)
    stripLength = xEventOrder(i) - xEventOrder(i-1);
    difference = difference + ((TfValue(tfL,xEventOrder(i)) - ...
                 TfValue(tfR,xEventOrder(i)))^2)*stripLength;
end

end

