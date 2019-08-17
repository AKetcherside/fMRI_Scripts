
clear all 
clc



%Extract parameter estimates for the A, B, and C matrices. 




%       subj = {'subj1','subj2','subj3'};




counter=1;
%PEs= zeros(3,97);

for s = 1:length(subj)
    
    display(subj{s});
    data_path = fullfile('S:\Collaboration\OwlData\faces_working\', subj{s},'DCMmodels3');

             
            
% CHANGE WORKING DIRECTORY             
spm('Defaults','fMRI');
spm_jobman('initcfg');
clear matlabbatch
matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(data_path);
spm_jobman('run',matlabbatch);
       
      

  

   % subj{s} = 'Subject'

    %PEs{counter,1)=subj{s} 
       PEs{counter,1}=subj{s};
       
       
       

    %Intrinsic Model
        load('DCM_i1.mat');

            PEs{counter,2}=DCM.Ep.A(1,1);
            PEs{counter,3}=DCM.Ep.A(1,2);
            PEs{counter,4}=DCM.Ep.A(1,3);
            PEs{counter,5}=DCM.Ep.A(2,1);
            PEs{counter,6}=DCM.Ep.A(2,2);
            PEs{counter,7}=DCM.Ep.A(2,3);
            PEs{counter,8}=DCM.Ep.A(3,1);
            PEs{counter,9}=DCM.Ep.A(3,2);
            PEs{counter,10}=DCM.Ep.A(3,3);

%             PEs{counter,11}=DCM.Ep.B(1,1,2);
%             PEs{counter,12}=DCM.Ep.B(1,2,2);
%             PEs{counter,13}=DCM.Ep.B(1,3,2);
%             PEs{counter,14}=DCM.Ep.B(2,1,2);
%             PEs{counter,15}=DCM.Ep.B(2,2,2);
%             PEs{counter,16}=DCM.Ep.B(2,3,2);
%             PEs{counter,17}=DCM.Ep.B(3,1,2);
%             PEs{counter,18}=DCM.Ep.B(3,2,2);
%             PEs{counter,19}=DCM.Ep.B(3,3,2);
%             
            
            
            PEs{counter,11}=DCM.Ep.B(1,1);
            PEs{counter,12}=DCM.Ep.B(1,2);
            PEs{counter,13}=DCM.Ep.B(1,3);
            PEs{counter,14}=DCM.Ep.B(2,1);
            PEs{counter,15}=DCM.Ep.B(2,2);
            PEs{counter,16}=DCM.Ep.B(2,3);
            PEs{counter,17}=DCM.Ep.B(3,1);
            PEs{counter,18}=DCM.Ep.B(3,2);
            PEs{counter,19}=DCM.Ep.B(3,3);


            PEs{counter,20}=DCM.Ep.C(1,1);
            PEs{counter,21}=DCM.Ep.C(2,1);
            PEs{counter,22}=DCM.Ep.C(3,1);

        clear DCM;
        clear EP;
        clear CP;
        clear F;
           
       
    
       

    %Forward model 
       load('DCM_fwd1.mat');
    
           PEs{counter,23}=DCM.Ep.A(1,1);
           PEs{counter,24}=DCM.Ep.A(1,2);
           PEs{counter,25}=DCM.Ep.A(1,3);
           PEs{counter,26}=DCM.Ep.A(2,1);
           PEs{counter,27}=DCM.Ep.A(2,2);
           PEs{counter,28}=DCM.Ep.A(2,3);
           PEs{counter,29}=DCM.Ep.A(3,1);
           PEs{counter,30}=DCM.Ep.A(3,2);
           PEs{counter,31}=DCM.Ep.A(3,3);

%            PEs{counter,32}=DCM.Ep.B(1,1,2);
%            PEs{counter,33}=DCM.Ep.B(1,2,2);
%            PEs{counter,34}=DCM.Ep.B(1,3,2);
%            PEs{counter,35}=DCM.Ep.B(2,1,2);
%            PEs{counter,36}=DCM.Ep.B(2,2,2);
%            PEs{counter,37}=DCM.Ep.B(2,3,2);
%            PEs{counter,38}=DCM.Ep.B(3,1,2);
%            PEs{counter,39}=DCM.Ep.B(3,2,2);
%            PEs{counter,40}=DCM.Ep.B(3,3,2);
           
           
           PEs{counter,32}=DCM.Ep.B(1,1);
           PEs{counter,33}=DCM.Ep.B(1,2);
           PEs{counter,34}=DCM.Ep.B(1,3);
           PEs{counter,35}=DCM.Ep.B(2,1);
           PEs{counter,36}=DCM.Ep.B(2,2);
           PEs{counter,37}=DCM.Ep.B(2,3);
           PEs{counter,38}=DCM.Ep.B(3,1);
           PEs{counter,39}=DCM.Ep.B(3,2);
           PEs{counter,40}=DCM.Ep.B(3,3);
           
           

           PEs{counter,41}=DCM.Ep.C(1,1);
           PEs{counter,42}=DCM.Ep.C(2,1);
           PEs{counter,43}=DCM.Ep.C(3,1);

       
        clear DCM;
        clear EP;
        clear CP;
        clear F;
       
       
       

        
    %Reverse model 
       load('DCM_bwd1.mat');
    
           PEs{counter,44}=DCM.Ep.A(1,1);
           PEs{counter,45}=DCM.Ep.A(1,2);
           PEs{counter,46}=DCM.Ep.A(1,3);
           PEs{counter,47}=DCM.Ep.A(2,1);
           PEs{counter,48}=DCM.Ep.A(2,2);
           PEs{counter,49}=DCM.Ep.A(2,3);
           PEs{counter,50}=DCM.Ep.A(3,1);
           PEs{counter,51}=DCM.Ep.A(3,2);
           PEs{counter,52}=DCM.Ep.A(3,3);

%            PEs{counter,53}=DCM.Ep.B(1,1,2);
%            PEs{counter,54}=DCM.Ep.B(1,2,2);
%            PEs{counter,55}=DCM.Ep.B(1,3,2);
%            PEs{counter,56}=DCM.Ep.B(2,1,2);
%            PEs{counter,57}=DCM.Ep.B(2,2,2);
%            PEs{counter,58}=DCM.Ep.B(2,3,2);
%            PEs{counter,59}=DCM.Ep.B(3,1,2);
%            PEs{counter,60}=DCM.Ep.B(3,2,2);
%            PEs{counter,61}=DCM.Ep.B(3,3,2);

           PEs{counter,53}=DCM.Ep.B(1,1);
           PEs{counter,54}=DCM.Ep.B(1,2);
           PEs{counter,55}=DCM.Ep.B(1,3);
           PEs{counter,56}=DCM.Ep.B(2,1);
           PEs{counter,57}=DCM.Ep.B(2,2);
           PEs{counter,58}=DCM.Ep.B(2,3);
           PEs{counter,59}=DCM.Ep.B(3,1);
           PEs{counter,60}=DCM.Ep.B(3,2);
           PEs{counter,61}=DCM.Ep.B(3,3);


           
           
           PEs{counter,62}=DCM.Ep.C(1,1);
           PEs{counter,63}=DCM.Ep.C(2,1);
           PEs{counter,64}=DCM.Ep.C(3,1);

       
        clear DCM;
        clear EP;
        clear CP;
        clear F;

        
            %Bidirectional
       load('DCM_fb1.mat');
    
           PEs{counter,65}=DCM.Ep.A(1,1);
           PEs{counter,66}=DCM.Ep.A(1,2);
           PEs{counter,67}=DCM.Ep.A(1,3);
           PEs{counter,68}=DCM.Ep.A(2,1);
           PEs{counter,69}=DCM.Ep.A(2,2);
           PEs{counter,70}=DCM.Ep.A(2,3);
           PEs{counter,71}=DCM.Ep.A(3,1);
           PEs{counter,72}=DCM.Ep.A(3,2);
           PEs{counter,73}=DCM.Ep.A(3,3);

%            PEs{counter,74}=DCM.Ep.B(1,1,2);
%            PEs{counter,75}=DCM.Ep.B(1,2,2);
%            PEs{counter,76}=DCM.Ep.B(1,3,2);
%            PEs{counter,77}=DCM.Ep.B(2,1,2);
%            PEs{counter,78}=DCM.Ep.B(2,2,2);
%            PEs{counter,79}=DCM.Ep.B(2,3,2);
%            PEs{counter,80}=DCM.Ep.B(3,1,2);
%            PEs{counter,81}=DCM.Ep.B(3,2,2);
%            PEs{counter,82}=DCM.Ep.B(3,3,2);

           
           PEs{counter,74}=DCM.Ep.B(1,1);
           PEs{counter,75}=DCM.Ep.B(1,2);
           PEs{counter,76}=DCM.Ep.B(1,3);
           PEs{counter,77}=DCM.Ep.B(2,1);
           PEs{counter,78}=DCM.Ep.B(2,2);
           PEs{counter,79}=DCM.Ep.B(2,3);
           PEs{counter,80}=DCM.Ep.B(3,1);
           PEs{counter,81}=DCM.Ep.B(3,2);
           PEs{counter,82}=DCM.Ep.B(3,3);

 
           
           
           
           PEs{counter,83}=DCM.Ep.C(1,1);
           PEs{counter,84}=DCM.Ep.C(2,1);
           PEs{counter,85}=DCM.Ep.C(3,1);

       
        clear DCM;
        clear EP;
        clear CP;
        clear F;


counter=counter+1; 

end