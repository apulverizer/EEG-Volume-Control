function [prediction] = classifyVolume(rawData, model)
    % loop over channels?
    rawData = rawData';
    features = [];
    for i=1:4
        features = [features extractFeatures(rawData(:,i))];
    end
    features(isinf(features)) = 0;
    features(isnan(features)) = 0;
    prediction = rbfnPredictRealTime(features,model,1,2);
end