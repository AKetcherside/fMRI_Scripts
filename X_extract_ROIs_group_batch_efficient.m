
addpath C:\Users\kxk120830\documents\Spm12\toolbox\marsbar\

addpath C:\Users\kxk120830\Documents\spm12\toolbox\marsbar\spm2\

marsbar('on')

clear all 
clc









% % %Only have Run 1
spm_name = {'S:\Collaboration\OwlData\faces_working\subj1\4secBlock_0secDur\SPM.mat',
    'S:\Collaboration\OwlData\faces_working\subj2\4secBlock_0secDur\SPM.mat',
    'S:\Collaboration\OwlData\faces_working\subj3\4secBlock_0secDur\SPM.mat'};





roi_file = {'S:\Collaboration\OwlData\faces_working\Results\ResultsROIs_forMarsbar\ROI3_1vox_48_-22_14_roi.mat'}    


% 
%  my_roi = maroi(roi_filename);
% my_roi = spm_hold(my_roi, 0); % set NN resampling
% saveroi(my_roi, roi_filename);

for i = 1:length(roi_file)
   %roi = (roi_file{i});
    roi = maroi(roi_file{i});
    for j = 1:length(spm_name)
        if i == 1
%            eval(['D',int2str(j),' = (spm_name{j});']); 
            eval(['D',int2str(j),' = mardo(spm_name{j});']); 
        end
       
        %eval(['Y = get_marsy(roi, D',(j),', ''eigen1'');']);

        %test
        eval(['Y = get_marsy(roi, D',int2str(j),', ''mean'');']);
        
        %This works
        %eval(['Y = get_marsy(roi, D',int2str(j),', ''mean'');']);
        
            %get_marsy() returns summary data from the ROI in the form of 'mean',
            %'median', 'eigen1', or 'wtmean'
        
        temp = summary_data(Y);
        if i==1&&j==1
            result = temp;
        else
            result = [result,temp];
        end
    end
end


  