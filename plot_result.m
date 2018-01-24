function plot_result(Accuracy,mark,file_path)
%PLOT_RESULT Summary of this function goes here
%   Detailed explanation goes here
% plot_result
%% Extract all variables from Accuracy
strNames = fieldnames(Accuracy);
for i = 1:length(strNames), eval([strNames{i} '= Accuracy.' strNames{i} ';']); end
figure(222);
hold on;
plot(X_range,accuracy_ours,'b-s',...
     'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',8);
axis([min(X_range),max(X_range) 0 1]);
legend('HOGMMNC','Location','SouthWest');
file_name='';
switch mark
    case 1
        xlabel('¦Ò');
        file_name='result_noise.jpg';
    case 2
        xlabel('correlation factor');
        file_name='result_scale.jpg';
    case 3
        xlabel('ratio of irrelevant samples');
        file_name='result_outliers.jpg';    
    otherwise
end
ylabel('Accuracy');
result_path=[file_path,file_name];
saveas(gcf,result_path);

end

