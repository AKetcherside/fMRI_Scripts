%-----------------------------------------------------------------------
% Job saved on 05-Jul-2017 14:56:36 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------




spm('defaults','FMRI')
spm_jobman('initcfg');



matlabbatch{1}.spm.dcm.bms.inference.dir = {'S:\Collaboration\OwlData\faces_working\Results\Surg_Baseline'};
matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{1}.dcmmat = {
                                                           'S:\Collaboration\OwlData\faces_working\subj1\DCMmodels3\DCM_i1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj1\DCMmodels3\DCM_fwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj1\DCMmodels3\DCM_bwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj1\DCMmodels3\DCM_fb1.mat'
                                                           };
matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{2}.dcmmat = {
                                                           'S:\Collaboration\OwlData\faces_working\subj2\DCMmodels3\DCM_i1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj2\DCMmodels3\DCM_fwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj2\DCMmodels3\DCM_bwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj2\DCMmodels3\DCM_fb1.mat'
                                                           };
matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{3}.dcmmat = {
                                                           'S:\Collaboration\OwlData\faces_working\subj3\DCMmodels3\DCM_i1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj3\DCMmodels3\DCM_fwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj3\DCMmodels3\DCM_bwd1.mat'
                                                           'S:\Collaboration\OwlData\faces_working\subj3\DCMmodels3\DCM_fb1.mat'
                                                           };


% etc. -- continue with all subjects
                                                       
matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'FFX';
matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_no = 0;
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 1;




spm_jobman('run', matlabbatch);

