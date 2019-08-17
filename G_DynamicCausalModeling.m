



% Originated from Wellcome Trust Centre for Neuroimaging 2010 
% Adapted by Ariel Ketcherside





% Specify directory
cd S:\Collaboration\OwlData\faces_working\;



subj = {'subj1','subj2','subj3'};


for s = 1:length(subj)
    
    display(subj{s})
    data_path = fullfile('S:\Collaboration\OwlData\faces_working\', subj{s});

    mkdir(['S:\Collaboration\OwlData\faces_working\', subj{s},'\DCMmodels']);





% Initialise SPM
%--------------------------------------------------------------------------
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);



% CHANGE WORKING DIRECTORY
%--------------------------------------------------------------------------
clear matlabbatch
matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(data_path);
spm_jobman('run',matlabbatch);




bb=1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DYNAMIC CAUSAL MODELLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear DCM

% SPECIFICATION DCM "
% --------------------------------------------------------------------------
%load(fullfile(data_path,'ASP_indiv_fixed_mp_ns_dcm_2014','SPM.mat'));
load(fullfile(data_path,'SPM.mat'));


%load(fullfile(data_path,'ASP_indiv_fixed_mp_ns_dcm_2014',['VOI_RCZp_1.mat']),'xY');
load(fullfile(data_path,['VOI_pSTS_1.mat']),'xY');
DCM.xY(1) = xY;
load(fullfile(data_path,['VOI_rAmy_1.mat']),'xY');
DCM.xY(2) = xY;
load(fullfile(data_path,['VOI_mOFC_1.mat']),'xY');
DCM.xY(3) = xY;


DCM.n = length(DCM.xY);      % number of regions
DCM.v = length(DCM.xY(1).u); %total number of time points (768)
DCM.Y.dt  = SPM.xY.RT; %Repetition time, 1.5 s
DCM.Y.X0  = DCM.xY(1).X0; %What is this? It's 768x19







for i = 1:DCM.n
    DCM.Y.y(:,i)  = DCM.xY(i).u; %768x3
    DCM.Y.name{i} = DCM.xY(i).name; %1x3
end




DCM.Y.Q    = spm_Ce(ones(1,DCM.n)*DCM.v); %three cells, each 2304x2304

DCM.U.dt   =  SPM.Sess(bb).U(1).dt; %this = TE = 0.0455


%This is where I put in the betas for my regressors. 
tt = [SPM.Sess(bb).U.name]; %Conditions included
DCM.U.name = [tt(1),tt(2)];
DCM.U.u    = [SPM.Sess(bb).U(1).u(33:end,1) ...  % all faces (regressor 1)
              SPM.Sess(bb).U(2).u(33:end,1) ...  % affective faces (regressor 2)
             ];

        

        
        
        
%DCM.delays = repmat(SPM.xY.RT,5,1); % Change to the correction session number
                                    % This makes an N x 1 matrix of TR.
                                    % It's set to 5 here, for Xiaosi's
                                    % previous 5 regions. I'm setting
                                    % it to 3 for my 3 regions. 

DCM.delays = repmat(SPM.xY.RT,3,1)




DCM.TE     = 0.04;

DCM.options.nonlinear  = 0;
DCM.options.two_state  = 0;
DCM.options.stochastic = 0;
DCM.options.centre  = 0;
%DCM.options.endogenous = 0;
%DCM.options.nograph    = 1;


%% If you want to use the posterior estimates from good subjects' models to 
%re-initiate as prior in the new estimation, uncomment the following and
%change to appropriate file: 

    %load D:\Lab-old\MSSM-data\07_0699\indiv\1002\ASP_indiv_fixed_mp_ns_dcm_2014\BMS.mat;
    %DCM.options.P = BMS.DCM.ffx.bma.mEp; 

    
%%


%Specify intrinsic matrix. dimensions = [#regions x #regions]
DCM.a = [1 1 1 ; 1 1 1; 1 1 1];



DCM.c = [1,0;1,0;0,0]; % [region1 direct input, 0 ; region2 direct input, 0; region 3 direct input, 0]
%DCM.c = [1;1;0]; % [region1 direct input, 0 ; region2 direct input, 0; region 3 direct input, 0]


%DCM.d = zeros(3,3,0); % Change this to be the matrix of (# regions, # regions, 0)
DCM.d = zeros(3,3); % Change this to be the matrix of (# regions, # regions, 0)


%%


% %%FAMILY 1, only intrinsic modulation
% DCM.b = zeros(3,3,2);  % Change this to be the matrix of (# regions, # regions, # conditions)
% DCM.b(:,:,2) = [0 0 0; 0 0 0; 0 0 0]; % Affect modulatory effect: None
% save(fullfile(data_path,'DCMmodels',['DCM_i1.mat']),'DCM'); %i is for intrinsic only
% 
% %%FAMILY 1, intrinsic + fwd
% DCM.b = zeros(3,3,2);  % Change this to be the matrix of (# regions, # regions, # conditions)
% DCM.b(:,:,2) = [0 0 0; 0 0 1; 0 0 0]; %  Affect modulatory effect: Amygdala to OFC
% save(fullfile(data_path,'DCMmodels',['DCM_fwd1.mat']),'DCM'); %forward direction only
% 
% %%FAMILY 1. intrinsic + bwd
% DCM.b = zeros(3,3,2);  % Change this to be the matrix of (# regions, # regions, # conditions)
% DCM.b(:,:,2) = [0 0 0; 0 0 0; 0 1 0]; %  Affect modulatory effect: OFC to Amygdala
% save(fullfile(data_path,'DCMmodels',['DCM_bwd1.mat']),'DCM'); %backward direction only
% 
% %%FAMILY 1, intrinsic + fb
% DCM.b = zeros(3,3,2);  % Change this to be the matrix of (# regions, # regions, # conditions)
% DCM.b(:,:,2) = [0 0 0; 0 0 1; 0 1 0]; %  Affect modulatory effect: Amygdala OFC bidirectonal
% save(fullfile(data_path,'DCMmodels',['DCM_fb1.mat']),'DCM'); %forward and backward


 
%%FAMILY 1, only intrinsic modulation
DCM.b = zeros(3,3);  % Change this to be the matrix of (# regions, # regions, # conditions)
DCM.b(:,:) = [0 0 0; 0 0 0; 0 0 0]; % Affect modulatory effect: None
save(fullfile(data_path,'DCMmodels',['DCM_i1.mat']),'DCM'); %i is for intrinsic only

%%FAMILY 1, intrinsic + fwd
DCM.b = zeros(3,3);  % Change this to be the matrix of (# regions, # regions, # conditions)
DCM.b(:,:) = [0 0 0; 0 0 1; 0 0 0]; %  Affect modulatory effect: Amygdala to OFC
save(fullfile(data_path,'DCMmodels',['DCM_fwd1.mat']),'DCM'); %forward direction only

%%FAMILY 1. intrinsic + bwd
DCM.b = zeros(3,3);  % Change this to be the matrix of (# regions, # regions, # conditions)
DCM.b(:,:) = [0 0 0; 0 0 0; 0 1 0]; %  Affect modulatory effect: OFC to Amygdala
save(fullfile(data_path,'DCMmodels',['DCM_bwd1.mat']),'DCM'); %backward direction only

%%FAMILY 1, intrinsic + fb
DCM.b = zeros(3,3);  % Change this to be the matrix of (# regions, # regions, # conditions)
DCM.b(:,:) = [0 0 0; 0 0 1; 0 1 0]; %  Affect modulatory effect: Amygdala OFC bidirectonal
save(fullfile(data_path,'DCMmodels',['DCM_fb1.mat']),'DCM'); %forward and backward




%%
DCM_i1 = spm_dcm_estimate(fullfile(data_path,'DCMmodels',['DCM_i1.mat']));
DCM_fwd1 = spm_dcm_estimate(fullfile(data_path,'DCMmodels',['DCM_fwd1.mat']));
DCM_bwd1 = spm_dcm_estimate(fullfile(data_path,'DCMmodels',['DCM_bwd1.mat']));
DCM_fb1 = spm_dcm_estimate(fullfile(data_path,'DCMmodels',['DCM_fb1.mat']));

%%
% BAYESIAN MODEL COMPARISON




spm('defaults', 'FMRI');
spm_jobman('initcfg');

clear matlabbatch


matlabbatch{1}.spm.dcm.bms.inference.dir = {['S:\Collaboration\OwlData\faces_working\',subj{s},'\DCMmodels']};
matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{1}.dcmmat = {
                                                           ['S:\Collaboration\OwlData\faces_working\',subj{s},'\DCMmodels\DCM_i1.mat'] 
                                                           ['S:\Collaboration\OwlData\faces_working\',subj{s},'\DCMmodels\DCM_fwd1.mat']
                                                           ['S:\Collaboration\OwlData\faces_working\',subj{s},'\DCMmodels\DCM_bwd1.mat']
                                                           ['S:\Collaboration\OwlData\faces_working\',subj{s},'\DCMmodels\DCM_fb1.mat']
                                                           };
matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'FFX';
matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_no = 0;
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 1;




spm_jobman('run', matlabbatch);








cd ..
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINISH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
