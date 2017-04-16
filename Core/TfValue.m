function [ fValue ] = TfValue( turningFunction, xValue )

% turningFunctionValue will return the value of the theta function
% for any given value between 0 and 1

for i=1:1:(size(turningFunction,1)-1)
    if ((xValue<turningFunction(i+1,1)) && (xValue>=turningFunction(i,1)))
        fValue = turningFunction(i,2);
        break;
    end
    if ((xValue==turningFunction(i+1,1)) || (abs(turningFunction(i+1,1)-xValue)<0.000001))
        fValue = turningFunction(i+1,2);
        break;
    end
end

