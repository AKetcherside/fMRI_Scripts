clear all; 
clc;
%Screen 1
% subj={'subj1','subj2','subj3'};




% For each subject

%%
for s = 1:length(subj);

    
    cd(['S:\Collaboration\OwlData\faces_working\', subj{s},'\timingfiles']);
    
    
        %open file and convert to a cell called indata that I can work with 
        %fid = fopen([subj{s}, '.txt'],'rt');

        myfile=[subj{s},'TimingFile.csv']
        fid=csvread(myfile)
       

        %Run1
            TruncTimeFile(1,:) = fid(1,:) 
            TruncTimeFile(2,:) = fid(3,:) 
            TruncTimeFile(3,:) = fid(5,:) 
            TruncTimeFile(4,:) = fid(7,:) 
            TruncTimeFile(5,:) = fid(9,:)
        %Run2
            TruncTimeFile(6,:) = fid(11,:) 
            TruncTimeFile(7,:) = fid(13,:) 
            TruncTimeFile(8,:) = fid(15,:) 
            TruncTimeFile(9,:) = fid(17,:) 
            TruncTimeFile(10,:) = fid(19,:)
%         %Run3
%             TruncTimeFile(11,:) = fid(21,:) 
%             TruncTimeFile(12,:) = fid(23,:) 
%             TruncTimeFile(13,:) = fid(25,:) 
%             TruncTimeFile(14,:) = fid(27,:) 
%             TruncTimeFile(15,:) = fid(29,:)



csvwrite('TruncTimeFile.csv',TruncTimeFile)

cd ..

 
end
        
