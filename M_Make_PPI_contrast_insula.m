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





% %%%%%%%%%%%%%%%%%%%%%%
% % Define Contrasts
% %%%%%%%%%%%%%%%%%%%%%%
 
clear matlabbatch
matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\InsulaPPI\PPI_GLM_NeutgrAff\SPM.mat'));



matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'PPI_InsulaxNeutgrAff';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.delete = 1; %delete the old contrasts, 1=yes 0=no





spm_jobman('run',matlabbatch);

cd ..
end
