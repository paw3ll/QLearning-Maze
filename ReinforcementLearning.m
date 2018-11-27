function q=ReinforcementLearning(R, gamma)
%function q=ReinforcementLearning; %(R, gamma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Q learning of single agent move in N rooms 
% Matlab Code companion of 
% Q Learning by Example, by Kardi Teknomo 
% (http://people.revoledu.com/kardi/)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
clc;
format short
format compact

% Two input: R and gamma
if nargin<1,
% immediate reward matrix; row and column = states; -10 = no door between room
%     R=[-10,-10,-10,-10,   0, -10;
%        -10,-10,-10,   0,-10,  100;
%        -10,-10,-10,   0,-10, -10;
%        -10,   0,   0,-10,   0, -10;
%           0,-10,-10,   0,-10,  100;
%         -10,  0,-10,-10,   0,  100];

R=[-10,-10,   0,   -10,  100;
   -10,-10,   0,   -10, -10;
    0,   0,   -10,   0, -10;
   -10, -10,   0,-10,  100;
    0,-10,-10,   0,  100]
end
if nargin<2,
    gamma=0.80;              % learning parameter
end


q=zeros(size(R));        % initialize Q as zero
q
q1=ones(size(R))*inf;    % initialize previous Q as big number
q1
count=0;                 % counter

for episode=0:50000
    % random initial state
    y=randperm(size(R,1));
    y
    state=y(1);
    state
    
    % select any action from this state
    x=find(R(state,:)>=0);         % find possible action of this state
    x
    size(x,1)
    if size(x,1)>0,
        x1=RandomPermutation(x);   % randomize the possible action
        x1=x1(1);                  % select an action (only the first element of random sequence)
        x1
    end

    qMax=max(q,[],2);
    qMax
    q(state,x1)= R(state,x1)+gamma*qMax(x1);     % get max of all actions from the next state for Q of current state
    state=x1;
    
    % break if convergence: small deviation on q for 1000 consecutive
%     sum(sum(abs(q1-q)))
%         sum(sum(q >0))
count
    if sum(sum(abs(q1-q)))<0.0001 & sum(sum(q >0))
        if count>1000,
            episode  % report last episode
            break % for
        else
            count=count+1; % set counter if deviation of q is small
        end
    else
        q1=q;
        count=0;  % reset counter when deviation of q from previous q is large
    end
end    

%normalize q
q
g=max(max(q));
g
if g>0, 
    q=100*q/g;
end
q