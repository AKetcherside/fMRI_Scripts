

clear all; 
clc;


data_path = 'S:\Collaboration\OwlData\faces_working\';



subj={'subj1','subj2','subj3'};






for s = 1:length(subj)
    
    display(subj{s})
    
cd(['S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur']);


%mkdir InsulaPPI
%copyfile('SPM.mat', 'InsulaPPI\SPM.mat')



%% Initialise SPM
spm('Defaults','fMRI');
spm_jobman('initcfg');


matlabbatch{1}.spm.stats.ppi.spmmat = cellstr(fullfile(data_path,subj{s},'\4secBlock_0secDur\SPM.mat'));
matlabbatch{1}.spm.stats.ppi.type.ppi.voi = cellstr(fullfile('S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur\VOI_Insula_NeutgrAff_m_1.mat'));
%matlabbatch{1}.spm.stats.ppi.type.ppi.voi = cellstr(fullfile('S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur\VOI_Insula_Aff_m_1.mat'));



%In this matrix, column 1 = sess.U number (1 = Neutral, 2= Affect), column
%2 = session number name (usually 1???) and column 3= contrast. For me,
%Neut<Affect = -1, 1 
matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                           2 1 -1];
matlabbatch{1}.spm.stats.ppi.name = 'Insula_NeutgrAff';
matlabbatch{1}.spm.stats.ppi.disp = 1;

% 
% %Affect Only
% matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1];
% matlabbatch{1}.spm.stats.ppi.name = 'Insula_Aff';
% matlabbatch{1}.spm.stats.ppi.disp = 1;
% 


spm_jobman('run',matlabbatch);


%Move to its own unique output directory

% copyfile('PPI_Insula_Aff.mat', 'InsulaPPI\PPI_Insula_Aff.mat');
% delete('PPI_Insula_Aff.mat');
% 
display('done');
end