%Model Check


subj = {'subj1','subj2','subj3'};


counter=1;


for s = 1:length(subj)

display(subj{s});
data_path = fullfile('S:\Collaboration\OwlData\faces_working\', subj{s},'DCMmodels3');



% CHANGE WORKING DIRECTORY             
spm('Defaults','fMRI');
spm_jobman('initcfg');
clear matlabbatch
matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(data_path);
spm_jobman('run',matlabbatch);



diagnostics{counter,1}=subj{s};


%Intrinsic Model
load('DCM_i1.mat');

spm_dcm_fmri_check(DCM);
diagnostics{counter,2}=ans.diagnostics;

clear DCM;
clear EP;
clear CP;
clear F;


%Forward model 
load('DCM_fwd1.mat');

spm_dcm_fmri_check(DCM);
diagnostics{counter,3}=ans.diagnostics;

clear DCM;
clear EP;
clear CP;
clear F;


%Reverse model 
load('DCM_bwd1.mat');

spm_dcm_fmri_check(DCM);
diagnostics{counter,4}=ans.diagnostics;

clear DCM;
clear EP;
clear CP;
clear F;


%Bidirectional
load('DCM_fb1.mat');

spm_dcm_fmri_check(DCM)
diagnostics{counter,5}=ans.diagnostics

clear DCM;
clear EP;
clear CP;
clear F;


counter=counter+1
end