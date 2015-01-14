% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence

function [models,Xtrain] = trainSvms(TYPE,SIZE,CS,GAMMAS)

    load('mnist_all.mat');

    clear('trainSets');
    trainSets = who('train*');
    models = {};
    Xtrain = [];
    yMult = []; %Multiclass y
    for i=1:numel(trainSets)
        setname = trainSets{i};
        Xfull = eval(setname);
        randidxs = randperm(length(Xfull));
        randidxs = randidxs(1:SIZE);
        Xtrain = [Xtrain, (double(Xfull(randidxs,:)/255)')];
        yMult = [yMult, ones(1,SIZE)*eval(setname(end))];
    end

    switch TYPE
      case 'linear'
        K = Xtrain'*Xtrain ;
      case 'rbf'
        K_dist = L2_distance_sq(Xtrain,Xtrain) ;
        %K = pdist2(Xtrain,Xtrain) ;
    end
    
    for i=1:numel(trainSets)
        setname = trainSets{i};
        ytrain = yMult == eval(setname(end));
        ytrain = (ytrain*2)-1; %to change 1s and 0s for 1s and -1s
        for c = 1:length(CS)
            if (strcmp(TYPE,'rbf'))
                for g = 1:length(GAMMAS)
                    K = exp((- GAMMAS(g)) * K_dist);
                    models{i,c,g} = svm(K,ytrain,CS(c));
                end
            else                
                models{i,c} = svm(K,ytrain,CS(c));
            end
        end
    end

end