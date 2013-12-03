function plotData(rawWindow,filterWindow,fftWindow,rawAxes,filterAxes,fftAxes, channelNumbers)

for i=1:length(channelNumbers)
    % Plot Raw
    plot(rawAxes(i),rawWindow(channelNumbers(i),:));
    %set(rawAxes(i),'XLim',[0 length(rawWindow(channelNumbers(i),:))]);
    
    % Plot Filtered
    plot(filterAxes(i),filterWindow(channelNumbers(i),:));
    set(filterAxes(i),'XLim',[0 length(filterWindow(channelNumbers(i),:))]);
    
    % Plot fft
    ft = fftWindow(channelNumbers(i),:);
    stem(fftAxes(i),ft); 
end
