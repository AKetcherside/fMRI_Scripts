function run_preproc_job(varargin)


addpath('S:\Collaboration\OwlData\faces_working\')
addpath S:\Collaboration\OwlData\faces_working\gulabscripts

cd S:\Collaboration\OwlData\faces_working\;
root_folder = 'S:\Collaboration\OwlData\faces_working\';
analysis_folder = 'S:\Collaboration\OwlData\faces_working\';





subj = {'subj1','subj2','subj3'}



%%

for i=1:length(subj) 
      
    cd(['S:\Collaboration\OwlData\faces_working\',subj{i}]);
    

    epi = dir('run*');
    data_path = fullfile(analysis_folder,subj{i});  




%No. of slices = 38 Voxel size = 3.44mm TR = 2000ms TE = 25ms Flip angle = 90 Includes 5 dummy images

% execute batch_preproc jobs
    t1 = dir('structural*');
    t1 = t1.name;
    
   num_slices = 33;
   TR=1.5;
    % interleaved ascending order



    slice_order = [1   3   5   7   9  11  13  15  17  19  21  23  25  27  29  31  33   2   4   6   8  10  12  14  16  18  20  22  24  26  28  30  32];
    reference_slice = num_slices;


  
%% Initialise SPM defaults
spm('Defaults','fMRI');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPATIAL PREPROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select functional scans
%--------------------------------------------------------------------------
 
 for j=1:length(epi);
    %ff = spm_select('ExtList', fullfile(data_path,epi(j).name), '^3.*\.nii$');
   ff = spm_select('ExtList', fullfile(data_path,epi(j).name), '^f3T.*\.nii$');
    
    for m=1:length(ff);
    gg(m,:)= fullfile(data_path,epi(j).name,ff(m,:));
    end
    f{j} = gg;
    clear gg
 end

 
%%Select structural scan 
 
% f = spm_select('FPList', fullfile(data_path,epi.name), '^f.*\.nii$');
a = spm_select('FPList', fullfile(data_path,t1), '^3T.*\.nii$');






%% REALIGN: prefix = r
%--------------------------------------------------------------------------
%for i=1:length(epi)

% %
% Change number of files! 
%
matlabbatch{1}.spm.spatial{1}.realign.estwrite.data = {cellstr(f{1}),cellstr(f{2}),cellstr(f{3})};



% %% SLICE TIMING CORRECTION - prefix = a
%--------------------------------------------------------------------------


matlabbatch{2}.spm.temporal{1}.st.scans =  {cellstr(spm_file(f{1},'prefix','r')),cellstr(spm_file(f{2},'prefix','r')),cellstr(spm_file(f{3},'prefix','r'))};
matlabbatch{2}.spm.temporal{1}.st.nslices = num_slices; % change for different scanners
matlabbatch{2}.spm.temporal{1}.st.tr = TR;
matlabbatch{2}.spm.temporal{1}.st.ta = TR-TR/num_slices;  % change for different scanners
matlabbatch{2}.spm.temporal{1}.st.so = slice_order;
matlabbatch{2}.spm.temporal{1}.st.refslice = reference_slice;



%% COREGISTRATION  with the mean MPRAGE image
%--------------------------------------------------------------------------
matlabbatch{3}.spm.spatial{1}.coreg.estimate.ref = editfilenames(f{1}(1,:),'prefix','mean');
matlabbatch{3}.spm.spatial{1}.coreg.estimate.source = cellstr(a);
% 


%% SEGMENT
%--------------------------------------------------------------------------
matlabbatch{1}.spm.spatial.preproc.channel.vols  = cellstr(a);
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{1}.spm.spatial.preproc.warp.write    = [0 1];





%% NORMALIZE: prefix = w
%--------------------------------------------------------------------------


%
matlabbatch{1}.spm.spatial.normalise.write.subj.def      = cellstr(spm_file(a,'prefix','y_','ext','nii'));


%
% Change number of files!
%

matlabbatch{1}.spm.spatial.normalise.write.subj.resample = cellstr(char(spm_file(f{1},'prefix','ar'),spm_file(f{2},'prefix','ar'),spm_file(f{3},'prefix','ar'),spm_file(f{1}(1,:),'prefix','mean')));
%matlabbatch{1}.spm.spatial.normalise.write.subj.resample = cellstr(char(spm_file(f{1},'prefix','ar'),spm_file(f{2},'prefix','ar'),spm_file(f{1}(1,:),'prefix','mean')));
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox  = [3 3 3];

matlabbatch{2}.spm.spatial.normalise.write.subj.def      = cellstr(spm_file(a,'prefix','y_','ext','nii'));
matlabbatch{2}.spm.spatial.normalise.write.subj.resample = cellstr(spm_file(a,'prefix','m','ext','nii'));
matlabbatch{2}.spm.spatial.normalise.write.woptions.vox  = [1 1 1];


%% SMOOTHING: prefix = s
%--------------------------------------------------------------------------
%matlabbatch{3}.spm.spatial{4}.smooth.data = editfilenames(f{i},'prefix','war');
%
% Change number of files!
%
matlabbatch{3}.spm.spatial.smooth.data = cellstr(char(spm_file(f{1},'prefix','war'),spm_file(f{2},'prefix','war'),spm_file(f{3},'prefix','war')));
matlabbatch{3}.spm.spatial.smooth.fwhm = [8 8 8];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RUN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('batch_preprocessing.mat','matlabbatch');
%spm_jobman('interactive',jobs);
spm_jobman('run',matlabbatch);

clear gg
clear ff

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    cd ..
    clear matlabbatch;

end
    

end