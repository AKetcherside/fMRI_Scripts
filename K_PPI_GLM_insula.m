clear all;
clc;

%List of subjects











subj={'subj1','subj2','subj3'};
% 


%%

for s = 1:length(subj)
    display(subj{s})
    display(datestr(now))
    
    
clear A
clear B
clear C
clear all_images    
clear designMatrixLocation
clear files1
clear files2
clear files3
clear images1
clear images2
clear images3
clear matlabbatch
clear PPI

    
    
cd (['S:\Collaboration\OwlData\faces_working\', subj{s}]);

%Call in the images
%all_images = cell(768, 1);

    images1 = cell(256, 1);
    files1 = dir('./run1/swarf3T*');
    for i=1:length(files1)
        images1{i} = strcat(fullfile('S:\Collaboration\OwlData\faces_working\', subj{s},'run1',files1(i).name), ',1');
    end

    images2 = cell(256, 1);
    files2 = dir('./run2/swarf3T*');
    for i=1:length(files2)
        images2{i} = strcat(fullfile('S:\Collaboration\OwlData\faces_working\', subj{s},'run2',files2(i).name), ',1');
    end

    images3 = cell(256, 1);
    files3 = dir('./run3/swarf3T*');
    for i=1:length(files3)
        images3{i} = strcat(fullfile('S:\Collaboration\OwlData\faces_working\', subj{s},'run3',files3(i).name), ',1');
    end

    all_images = [images1; images2; images3];
    % all_images = [images2; images3];
    %all_images = [images1];
    

 %load(['S:\Collaboration\OwlData\faces_working\', subj{s},'\4secBlock_0secDur\InsulaPPI\PPI_Insula_AffGrNeut.mat'])
load(['S:\Collaboration\OwlData\faces_working\', subj{s},'\4secBlock_0secDur\PPI_Insula_NeutgrAff.mat'])


 
 A=[PPI.ppi]; %PPI interaction
 B=[PPI.Y]; % ROI BOLD: from Insula
 C=[PPI.P]; %Psychological condition: Affect


% Specify directory
cd (['S:\Collaboration\OwlData\faces_working\', subj{s},'\4secBlock_0secDur\InsulaPPI']);

mkdir PPI_GLM_NeutgrAff


% Initialise SPM
%--------------------------------------------------------------------------
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);

matlabbatch{1}.spm.stats.fmri_spec.dir = {['S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur\InsulaPPI\PPI_GLM_NeutgrAff']};
%matlabbatch{1}.spm.stats.fmri_spec.dir = {['S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur\PPI_GLM_NeutgrAff']};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 33;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = all_images;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).name = 'PPI-interaction';
matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).val = A;

matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).name = 'Insula-BOLD';
matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).val = B;


matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).name = 'Psych_NeutgrAff';

%matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).name = 'Psych_Aff>Neut';
matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).val = C;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {['S:\Collaboration\OwlData\faces_working\',subj{s},'\Motion3runs.txt']};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';



matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;



%spm_jobman('run', matlabbatch);

%clear matlabbatch

designMatrixLocation = fullfile('S:\Collaboration\OwlData\faces_working\',subj{s},'\4secBlock_0secDur\InsulaPPI\PPI_GLM_NeutgrAff\SPM.mat');

matlabbatch{2}.spm.stats.fmri_est.spmmat = { designMatrixLocation };
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run', matlabbatch);


clear A
clear B
clear C

display('Done Design Matrix Specification for')
display(subj{s})
display(datestr(now))


end

