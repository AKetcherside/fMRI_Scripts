clear all; 
clc;


data_path = 'S:\Collaboration\OwlData\faces_working\';
%cd S:\Collaboration\OwlData\faces_working\;




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
 
clear matlabbatch
matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(data_path,subj{s},'\AffGrNeut\SPM.mat'));



matlabbatch{1}.spm.stats.con.consess{1}.fcon.name = 'EffectsOfInterest';
matlabbatch{1}.spm.stats.con.consess{1}.fcon.weights = [eye(2),zeros(2,6)];
matlabbatch{1}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Neut>Affect';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [1 -1 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Neut<Affect';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [-1 1 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 1; %delete the old crap




spm_jobman('run',matlabbatch);

cd ..
end
