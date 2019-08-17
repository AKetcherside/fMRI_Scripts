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


% %%%%%%%%%%%%%%%%%%%%%%
% % Define Contrasts
% %%%%%%%%%%%%%%%%%%%%%%
% 
% clear matlabbatch
% matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(data_path,subj{s},'SPM.mat'));
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'All Faces';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 0];
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 1];
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'All Faces < Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [-1 1];
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'All Faces > Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [1 -1];
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
% %This deletes any previously existing contrasts
% matlabbatch{1}.spm.stats.con.delete = 1;
%spm_jobman('run',matlabbatch);
% 













%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOLUMES OF INTEREST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



bb=1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  EXTRACTING TIME SERIES: right Amygdala
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% EXTRACTING TIME SERIES: right Amygdala (rAmy), All Faces
%--------------------------------------------------------------------------
clear matlabbatch



% EXTRACTING TIME SERIES: right Amygdala (rAmy), All Faces < Affective Faces
%--------------------------------------------------------------------------
matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'SPM.mat'));
matlabbatch{1}.spm.util.voi.adjust = 0;  % I don't have any F contrasts
matlabbatch{1}.spm.util.voi.session = 1; % session 1 
matlabbatch{1}.spm.util.voi.name = 'rAmy';

%This is the extra stuff that was in Xiaosi's version
matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 3;  % "shock cue-1"  contrast number
matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{1}.spm.util.voi.roi{1}.sphere.centre = [16 -8 -16]; % % from pain (both groups)
matlabbatch{1}.spm.util.voi.roi{1}.sphere.radius = 5;
matlabbatch{1}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{1}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{1}.spm.util.voi.expression = 'i1';





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    EXTRACTING TIME SERIES: Posterior Superior Temporal Sulcus (pSTS)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EXTRACTING TIME SERIES: pSTS, All Faces < Affective Faces
%--------------------------------------------------------------------------
matlabbatch{2}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'SPM.mat'));
matlabbatch{2}.spm.util.voi.adjust = 0;  % I don't have any F contrasts
matlabbatch{2}.spm.util.voi.session = 1; % session 1 %
matlabbatch{2}.spm.util.voi.name = 'pSTS';

%This is the extra stuff that was in Xiaosi's version
matlabbatch{2}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{2}.spm.util.voi.roi{1}.spm.contrast = 3;  % "shock cue-1" contrast number
matlabbatch{2}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{2}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{2}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{2}.spm.util.voi.roi{1}.sphere.centre = [48 -48 10]; % 
matlabbatch{2}.spm.util.voi.roi{1}.sphere.radius = 10;
matlabbatch{2}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{2}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{2}.spm.util.voi.expression = 'i1';









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   EXTRACTING TIME SERIES:  medial orbitofrontal cortex (mOFC)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 

% EXTRACTING TIME SERIES: mOFC, All Faces < Affective Faces
%--------------------------------------------------------------------------
matlabbatch{3}.spm.util.voi.spmmat = cellstr(fullfile(data_path,subj{s},'SPM.mat'));
matlabbatch{3}.spm.util.voi.adjust = 0;  % I don't have any F contrasts
matlabbatch{3}.spm.util.voi.session = 1; % session 1 %
matlabbatch{3}.spm.util.voi.name = 'mOFC';

%This is the extra stuff that was in Xiaosi's version
matlabbatch{3}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
matlabbatch{3}.spm.util.voi.roi{1}.spm.contrast = 3;  % "shock cue-1" contrast number
matlabbatch{3}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{3}.spm.util.voi.roi{1}.spm.thresh = 0.1;
matlabbatch{3}.spm.util.voi.roi{1}.spm.extent = 0;
% 
matlabbatch{3}.spm.util.voi.roi{1}.sphere.centre = [-3 55 -18]; % % from pain (both groups)
matlabbatch{3}.spm.util.voi.roi{1}.sphere.radius = 5;
matlabbatch{3}.spm.util.voi.roi{1}.sphere.move.local.spm = 1; % local max
matlabbatch{3}.spm.util.voi.roi{1}.sphere.move.local.mask = ''; % none
matlabbatch{3}.spm.util.voi.expression = 'i1';



spm_jobman('run',matlabbatch);




%Is this supposed to be taking from the whole brain, or the contrast? 


cd ..
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
