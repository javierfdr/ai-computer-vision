% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence

function [accMatrix,confMatrix,confTable] = testSvms(TYPE,SIZE,MODELS,XTRAIN,CS,GAMMAS)
    
    load('mnist_all.mat');

    clear('testSets');
    testSets = who('test*');

    Xtest = [];
    ytestMult = []; %Multiclass y
    for i=1:numel(testSets)
        setname = testSets{i};
        setclass = eval(setname(end));
        Xtestfull = eval(setname);
        randidxs = randperm(length(Xtestfull));
        randidxs = randidxs(1:SIZE);
        Xtest = [Xtest, (double(Xtestfull(randidxs,:))/255)'];
        ytestMult = [ytestMult, ones(1,SIZE)*setclass];
    end
        
    switch TYPE
      case 'linear'
        accMatrix = zeros(length(testSets),length(CS));
        confMatrix = zeros(length(testSets),length(testSets),length(CS));
        confTable = zeros(2,2,length(CS));
      case 'rbf'
        accMatrix = zeros(length(testSets),length(CS),length(GAMMAS));
        confMatrix = zeros(length(testSets),length(testSets),length(CS),length(GAMMAS));
        confTable = zeros(2,2,length(CS),length(GAMMAS));
    end
    
    
    for i=1:numel(testSets)
        setname = testSets{i};
        setclass = eval(setname(end));
        ytest = ytestMult == setclass;
        ytest = (ytest*2)-1; %to change 1s and 0s for 1s and -1s
        for c = 1:length(CS)
            if (strcmp(TYPE,'rbf'))
                for g = 1:length(GAMMAS)
                    alphay = MODELS{i,c,g}.alphay;
                    svind = MODELS{i,c,g}.svind;
                    b = MODELS{i,c,g}.b;
                    k_dist = L2_distance_sq(XTRAIN(:,svind),Xtest);
                    k = exp((- GAMMAS(g)) * k_dist);
                    classification = sign(alphay(svind)' * k + b);
                    accMatrix(i,c,g) = sum(classification == ytest) / length(ytest);
                    
                    for j=1:numel(testSets)
                        setnamej = testSets{j};
                        setclassj = eval(setnamej(end));
                        confMatrix(i,j,c,g) = sum(classification(ytestMult == setclassj) == 1);
                    end
                    
                    confTable(1,1,c,g) = confTable(1,1,c,g) + sum(classification(ytest==1)==1); %tp
                    confTable(1,2,c,g) = confTable(1,2,c,g) + sum(classification(ytest==-1)==1); %fp
                    confTable(2,1,c,g) = confTable(2,1,c,g) + sum(classification(ytest==1)==-1); %fn
                    confTable(2,2,c,g) = confTable(2,2,c,g) + sum(classification(ytest==-1)==-1); %tn
                end
            else
                
                alphay = MODELS{i,c}.alphay;
                svind = MODELS{i,c}.svind;
                b = MODELS{i,c}.b;
                k = XTRAIN(:,svind)'*Xtest;
                % Testing all samples at once, vectorized
                classification = sign(alphay(svind)' * k + b);
                accMatrix(i,c) = sum(classification== ytest) / length(ytest);
                
                for j=1:numel(testSets)
                    setnamej = testSets{j};
                    setclassj = eval(setnamej(end));
                    confMatrix(i,j,c) = sum(classification(ytestMult == setclassj) == 1);
                end
                
                confTable(1,1,c) = confTable(1,1,c) + sum(classification(ytest==1)==1); %tp
                confTable(1,2,c) = confTable(1,2,c) + sum(classification(ytest==-1)==1); %fp
                confTable(2,1,c) = confTable(2,1,c) + sum(classification(ytest==1)==-1); %fn
                confTable(2,2,c) = confTable(2,2,c) + sum(classification(ytest==-1)==-1); %tn
                
            end
            
    
        end
    end
        

end