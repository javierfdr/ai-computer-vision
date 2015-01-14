% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence

function [accMatrix] = testSvms(TYPE,SIZE,MODELS,XTRAIN,CS,GAMMAS)
    
    load('mnist_all.mat');

    clear('testSets');
    testSets = who('test*');

    Xtest = [];
    ytestMult = []; %Multiclass y
    for i=1:numel(testSets)
        setname = testSets{i};
        Xtestfull = eval(setname);
        randidxs = randperm(length(Xtestfull));
        randidxs = randidxs(1:SIZE);
        Xtest = [Xtest, (double(Xtestfull(randidxs,:))/255)'];
        ytestMult = [ytestMult, ones(1,SIZE)*eval(setname(end))];
    end
        
    switch TYPE
      case 'linear'
        accMatrix = zeros(length(testSets),length(CS));
      case 'rbf'
        accMatrix = zeros(length(testSets),length(CS),length(GAMMAS));
    end
    
    for i=1:numel(testSets)
        setname = testSets{i};
        ytest = ytestMult == eval(setname(end));
        ytest = (ytest*2)-1; %to change 1s and 0s for 1s and -1s
        for c = 1:length(CS)
            if (strcmp(TYPE,'rbf'))
                for g = 1:length(GAMMAS)
                    alphay = MODELS{i,c,g}.alphay;
                    svind = MODELS{i,c,g}.svind;
                    b = MODELS{i,c,g}.b;
                    k_dist = L2_distance_sq(XTRAIN(:,svind),Xtest);
                    k = exp((- GAMMAS(g)) * k_dist);
                    accMatrix(i,c,g) = sum(sign(alphay(svind)' * k + b) == ytest) / length(ytest);
                end
            else
                
                alphay = MODELS{i,c}.alphay;
                svind = MODELS{i,c}.svind;
                b = MODELS{i,c}.b;
                k = XTRAIN(:,svind)'*Xtest;
                % Testing all samples at once, vectorized
                accMatrix(i,c) = sum(sign(alphay(svind)' * k + b) == ytest) / length(ytest);
            end
            
    
        end
    end
        

end