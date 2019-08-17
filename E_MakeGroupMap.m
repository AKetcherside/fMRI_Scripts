%-----------------------------------------------------------------------
% Job saved on 14-Jun-2017 14:37:58 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------





allimages={
'img1dir\con_001.nii'
'img2dir\con_001.nii'
'img3dir\con_001.nii'    
%etc 

}




%%
spm('defaults', 'FMRI');
spm_jobman('initcfg');

clear matlabbatch
%%





matlabbatch{1}.spm.stats.factorial_design.dir = {'S:\Collaboration\OwlData\faces_working'};
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = allimages;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;


spm_jobman('run', matlabbatch);

cd('..');
