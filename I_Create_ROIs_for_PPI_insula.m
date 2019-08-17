clear all; 
clc;


data_path = 'S:\Collaboration\OwlData\faces_working\';
cd S:\Collaboration\OwlData\faces_working\;




subj={'subj1','subj2','subj3'};


    



for s = 1:length(subj)
    
    display(subj{s})
    
cd S:\Collaboration\OwlData\faces_working\;



%% Initialise SPM
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);

% CHANGE WORKING DIRECTORY
%--------------------------------------------------------------------------
% clear matlabbatch
% matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(data_path);
% spm_jobman('run',matlabbatch);

% mkdir ='DCM';


% OUTPUT DIRECTORY
%--------------------------------------------------------------------------
% clear matlabbatch
% matlabbatch{1}.cfg_basicio.cfg_mkdir.parent = cellstr(data_path);
% matlabbatch{1}.cfg_basicio.cfg_mkdir.name = 'GLM';
% spm_jobman('run',matlabbatch);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOLUMES OF INTEREST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bb=1;

clear matlabbatch



%peak voxel from Aim 1: -30 -19 23
%peak voxel from Aim 2: -42 -10 2
%average between them: -36 -14.5 12.5 extention _m for "mean"


% EXTRACTING TIME SERIES: left posterior insula, AFFECTIVE > NEUTRAL FACES
%--------------------------------------------------------------------------
matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\SPM.mat'));
matlabbatch{1}.spm.util.voi.adjust = 5;  % Adjust for effects of interest - This is my F 
matlabbatch{1}.spm.util.voi.session = 1; % session 1 -- Session = block?
matlabbatch{1}.spm.util.voi.name = 'Insula_AffgrNeut_m';

%This is does not come from the default SPM output
matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 5;  % contrast 5: Neutral < Affect
matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{1}.spm.util.voi.roi{1}.sphere.centre = [-36 -15 13]; % % from pain (both groups)
matlabbatch{1}.spm.util.voi.roi{1}.sphere.radius = 5;
matlabbatch{1}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{1}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{1}.spm.util.voi.expression = 'i1';




% EXTRACTING TIME SERIES: left posterior insula, NEUTRAL > AFFECTIVE FACES
%--------------------------------------------------------------------------
matlabbatch{2}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\SPM.mat'));
matlabbatch{2}.spm.util.voi.adjust = 5;  % Adjust for effects of interest - This is my F 
matlabbatch{2}.spm.util.voi.session = 1; % session 1 -- Session = block?
matlabbatch{2}.spm.util.voi.name = 'Insula_NeutgrAff_m';

%This does not come from the default SPM output
matlabbatch{2}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{2}.spm.util.voi.roi{1}.spm.contrast = 5;  % contrast 5: Neutral < Affect
matlabbatch{2}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{2}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{2}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{2}.spm.util.voi.roi{1}.sphere.centre = [-36 -15 13]; % % from pain (both groups)
matlabbatch{2}.spm.util.voi.roi{1}.sphere.radius = 5;
matlabbatch{2}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{2}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{2}.spm.util.voi.expression = 'i1';



% EXTRACTING TIME SERIES: left posterior insula, AFFECTIVE FACES
%--------------------------------------------------------------------------
matlabbatch{3}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\SPM.mat'));
matlabbatch{3}.spm.util.voi.adjust = 5;  % This is my F contrast
matlabbatch{3}.spm.util.voi.session = 1; % session 1 % I only have one session
matlabbatch{3}.spm.util.voi.name = 'Insula_Aff_m';

%This is the extra stuff that was in Xiaosi's version
matlabbatch{3}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{3}.spm.util.voi.roi{1}.spm.contrast = 5;  % Neutral faces < Affective
matlabbatch{3}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{3}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{3}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{3}.spm.util.voi.roi{1}.sphere.centre = [-36 -15 13]; % % 
matlabbatch{3}.spm.util.voi.roi{1}.sphere.radius = 10;
matlabbatch{3}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max within this ROI sphere
matlabbatch{3}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{3}.spm.util.voi.expression = 'i1';



% EXTRACTING TIME SERIES: left posterior insula, NEUTRAL FACES
%--------------------------------------------------------------------------
matlabbatch{4}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\SPM.mat'));
matlabbatch{4}.spm.util.voi.adjust = 5;  % I only have one F contrast, the identity matrix for my conditions
matlabbatch{4}.spm.util.voi.session = 1; % I only have one session
matlabbatch{4}.spm.util.voi.name = 'Insula_Neut_m';

%This is the extra stuff that was in Xiaosi's version
matlabbatch{4}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{4}.spm.util.voi.roi{1}.spm.contrast = 5;  % Neutral < Affective
matlabbatch{4}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{4}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{4}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{4}.spm.util.voi.roi{1}.sphere.centre = [-36 -15 13]; % % 
matlabbatch{4}.spm.util.voi.roi{1}.sphere.radius = 5;
matlabbatch{4}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{4}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{4}.spm.util.voi.expression = 'i1';

spm_jobman('run',matlabbatch);







cd ..
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
