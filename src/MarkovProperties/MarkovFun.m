function MarkovFun( y_obs)

N = max(y_obs);          %Number of states of the Markov chain.
L = length(y_obs);     %length of observational sequence.
T = L-1;                %Plot the first T states of the sequence. T should be smaller than L.

%Plot the sequence of the observations:

%Plot the sequence:

figure(1)
subplot(2,1,1)
plot(y_obs(1:T))          %plot the first T states of the sequence
xlim([-10 T+10])
ylim([0.5 N+0.5])
set(gca,'YTick',1:N)
xlabel('observations')
ylabel('state')
%%
%Estimation of transition probability matrix of Markov Chain.

P_MC = zeros(N,N);
for t=1:L-1
    P_MC(y_obs(t),y_obs(t+1))= P_MC(y_obs(t),y_obs(t+1))+1;
end
P_MC_cum = P_MC;
for j=2:N
    P_MC_cum(:,j) = P_MC_cum(:,j-1) + P_MC(:,j);     %cumulative version of P.
end
for j=1:N
    P_MC(:,j) = P_MC(:,j)./P_MC_cum(:,N);                 %Normalize transition matrix
end
P_MC_cum = P_MC;
for j=2:N
    P_MC_cum(:,j) = P_MC_cum(:,j-1) + P_MC(:,j);     %normalized cumulative version of P.
end
disp('Transition probability:')
disp(P_MC)

%%
%Produce sequence with the Markov chain.

y_MC = zeros(L,1);                %y_obs will be the input or OBServational sequence.
y_MC(1) = 1;                      %sequence starts with a 1;

for t=1:L-1                       %construct entire sequence
    r = rand;
    y_MC(t+1) = sum(r>P_MC_cum(y_MC(t),:))+1;
end

%Plot sequence:

subplot(2,1,2)
plot(y_MC(1:T))          %plot the first T states of the sequence (T defined above).
xlim([-10 T+10])
ylim([0.5 N+0.5])
set(gca,'YTick',1:N)
xlabel('Markov Chain')
ylabel('state')


%Plot data and results together:
figure(2)
plot(y_obs(1:T))
hold on
plot(y_MC(1:T),'r--')
legend('Real state','Simulation')
xlim([-10 T+10])
ylim([0.5 N+0.5])
set(gca,'YTick',1:N)
xlabel('Markov Chain')
ylabel('state')

% Calculate stationary state pi
Pe = eye(N)-P_MC; 
Pe(:,N)=1;
if (N==2)
    b=[0 1];
elseif N==3
    b=[0 0 1];
else
    b=[0 0 0 1];
end
Pi = b/Pe;
disp('Stationary probability:')
disp(Pi)

% Calculating the mean passage time
P01 = [zeros(N,1), P_MC(:,2:N)];
mu1 = (eye(N)-P01)\ones(N,1)  % The mean passage time to state 1 from any state

P02 = [P_MC(:,1), zeros(N,1), P_MC(:,N)];
mu2 = (eye(N)-P02)\ones(N,1)  % The mean passage time to state 2 from any state

P03 = [P_MC(:,1:2), zeros(N,1)];
mu3 = (eye(N)-P03)\ones(N,1)  % The mean passage time to state 3 from any state