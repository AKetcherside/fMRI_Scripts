clear all; 
clc;


data_path = 'S:\Collaboration\OwlData\faces_working\';
%cd S:\Collaboration\OwlData\faces_working\;




% subj={'subj1','subj2','subj3'};





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
matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(data_path,subj{s},'\ALLFaces4sB4sD\SPM.mat'));



%The DCM way

matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(data_path,subj{s},'\ALLFaces4sB4sD\SPM.mat'));
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'All Faces';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0 0 ];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'All Faces < Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [-1 1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'All Faces > Affective Faces';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [1 -1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
%This deletes any previously existing contrasts
matlabbatch{1}.spm.stats.con.delete = 1;
spm_jobman('run',matlabbatch);
















%The traditional way

% matlabbatch{1}.spm.stats.con.consess{1}.fcon.name = 'EffectsOfInterest';
% matlabbatch{1}.spm.stats.con.consess{1}.fcon.weights = [eye(2),zeros(2,6)];
% matlabbatch{1}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{2}.fcon.name = 'NeutFaces';
% matlabbatch{1}.spm.stats.con.consess{2}.fcon.weights = [1 0 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{3}.fcon.name = 'AffectFaces';
% matlabbatch{1}.spm.stats.con.consess{3}.fcon.weights = [0 1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'Neut>Affect';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [1 -1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'Neut<Affect';
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [-1 1 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.delete = 1; %delete the old crap





spm_jobman('run',matlabbatch);

cd ..
end
