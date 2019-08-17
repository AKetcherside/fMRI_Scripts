function firstLevelAnalysis_2c_flex(subjectRun)


cd(subjectRun);


%Concatenate motion files to form one big file
% run1file=dir('./run1/rp_f3T*.txt');
% run1=dlmread(fullfile(subjectRun, 'run1', run1file(1).name));
% run2file=dir('./run2/rp_f3T*.txt');
% run2=dlmread(fullfile(subjectRun, 'run2', run2file(1).name));
% run3file=dir('./run3/rp_f3T*.txt');
% run3=dlmread(fullfile(subjectRun, 'run3', run3file(1).name));
% 
% Motion3runs = [run1;run2;run3];
% 
% dlmwrite('Motion3runs.txt', Motion3runs);
% 




%Make Design matrix 

spm('defaults', 'FMRI');
spm_jobman('initcfg');

clear matlabbatch




matlabbatch{1}.spm.stats.fmri_spec.dir = {subjectRun};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 33;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
%%

%Call in the images
%all_images = cell(768, 1);

    images1 = cell(256, 1);
    files1 = dir('./run1/swarf3T*');
    for i=1:length(files1)
        images1{i} = strcat(fullfile(subjectRun,'run1',files1(i).name), ',1');
    end

    images2 = cell(256, 1);
    files2 = dir('./run2/swarf3T*');
    for i=1:length(files2)
        images2{i} = strcat(fullfile(subjectRun,'run2',files2(i).name), ',1');
    end

    images3 = cell(256, 1);
    files3 = dir('./run3/swarf3T*');
    for i=1:length(files3)
        images3{i} = strcat(fullfile(subjectRun,'run3',files3(i).name), ',1');
    end

   all_images = [images1; images2; images3];
    


%Call in timing files

    all_timeFiles = dir('./timingfiles/*TimingFile.csv');
    timingFile = fullfile('./timingfiles/', all_timeFiles(1).name);
    timingMatrix = dlmread(timingFile, ',');

%Concatenate Affect Onsets
    timingMatrixAffect = [timingMatrix(:,1);timingMatrix(:,2);timingMatrix(:,3)];
    %class=double

%Concatenate Faces Onsets
    timingMatrixFaces = [timingMatrix(:,1);timingMatrix(:,2);timingMatrix(:,3);timingMatrix(:,4)];
    %class=double


matlabbatch{1}.spm.stats.fmri_spec.sess.scans = all_images;
%%

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'Faces';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = timingMatrixFaces(:,1); 
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = repmat(2, 1, 80); 
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;



matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'Affect';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = timingMatrixAffect(:,1);
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = repmat(2, 1, 60);
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {'Motion2runs.txt'};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';


spm_jobman('run',matlabbatch);







%%

clear matlabbatch

designMatrixLocation = fullfile(subjectRun, 'SPM.mat');


matlabbatch{1}.spm.stats.fmri_est.spmmat = { designMatrixLocation };
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run', matlabbatch);

cd('..');
end
