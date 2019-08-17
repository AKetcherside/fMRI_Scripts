%-----------------------------------------------------------------------
% Job saved on 28-Jul-2017 12:49:21 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

spm('defaults', 'FMRI');
spm_jobman('initcfg');

clear matlabbatch



matlabbatch{1}.spm.stats.factorial_design.dir = {'S:\Collaboration\OwlData\faces_working\AimIGroupLevel\LeanVObese_AffGrNeut_BL_4sB0sD_insulaPPI'};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac.name = 'Group';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac.variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject.scans = {
'S:\Collaboration\OwlData\faces_working\subj1\4secBlock_0secDur\InsulaPPI\PPI_GLM\con_0001.nii,1' %lacking all 3 runs
'S:\Collaboration\OwlData\faces_working\subj2\4secBlock_0secDur\InsulaPPI\PPI_GLM\con_0001.nii,1'
'S:\Collaboration\OwlData\faces_working\subj3\4secBlock_0secDur\InsulaPPI\PPI_GLM\con_0001.nii,1'
%etc. make sure the factor conditions (below) are the same length as the number of subjects

};


%matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject.conds = [1];
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject.conds = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2]; 

matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% %Estimate Design Matrix
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % 
% % % 
designMatrixLocation = fullfile('S:\Collaboration\OwlData\faces_working\AimIGroupLevel\LeanVObese_AffGrNeut_BL_4sB0sD_insulaPPI\SPM.mat');

matlabbatch{2}.spm.stats.fmri_est.spmmat = { designMatrixLocation };
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

 spm_jobman('run', matlabbatch);
% 
% 
% cd('..');
% 
