pl1=550000;
pl2=606000;
pl3=674000;
pl4=447000;
pl1=round(0.15*pl1/180);
pl2=round(0.15*pl2/180);
pl3=round(0.15*pl3/180);
pl4=round(0.15*pl4/180);

pool=[pl1 pl2 pl3 pl4]; % you can change this number to number what you want.
                        % each one is peak rate of one pool. 
                        % for example: 1st pool peak rate is 475 stbpd

FlowRates=zeros(4,270);

for i=1:size(pool,2)
    a=linspace(0,1,30).*(0.85+0.3*rand(1,30))*pool(i);
    b=(pool(i)-20+(40)*rand(1,90));
    c=flip(linspace(0,1,150)).*(0.95+0.15*rand(1,150))*pool(i);
    FlowRates(i,:)=[a b c];
end
A=FlowRates;


%% When Production Period Start
% 7 Cycle for each pool

%First Production cycle
ProductionProfile=zeros(1,2700);
ProductionProfile(1:90)=FlowRates(1,1:90); %2 inj
ProductionProfile(91:180)=FlowRates(1,91:180)+FlowRates(2,1:90); %3 inj
ProductionProfile(181:270)=FlowRates(1,181:270)+FlowRates(2,91:180)+FlowRates(3,1:90); %4 inj
for i=1:6
    for j=1
        ProductionProfile(360*i-89:360*i)=FlowRates(j+1,1:90)+FlowRates(j+2,91:180)+FlowRates(j+3,181:270);
    end
    for j=2
       ProductionProfile(360*i+1:360*i+90)=FlowRates(j-1,1:90)+FlowRates(j+2,91:180)+FlowRates(j+1,181:270);
    end
    for j=3
        ProductionProfile(360*i+91:360*i+180)=FlowRates(j-1,1:90)+FlowRates(j-2,91:180)+FlowRates(j+1,181:270);
    end
    for j=4
        ProductionProfile(360*i+181:360*i+270)=FlowRates(j-3,1:90)+FlowRates(j-2,91:180)+FlowRates(j-1,181:270);
    end
end
ProductionProfile(2431:2520)=FlowRates(4,1:90)+FlowRates(3,91:180)+FlowRates(2,181:270);
ProductionProfile(2521:2610)=FlowRates(4,91:180)+FlowRates(3,181:270);
ProductionProfile(2611:2700)=FlowRates(4,181:270);

figure;
plot(ProductionProfile)
ylabel('Flow Rate in Bbl/d');
xlabel('Time in Day');
title('Total Production Profile Through 7 Cycle')


%% 2nd part
FlowRates=[zeros(4,90) FlowRates];

prodprof=zeros(4,2790);
for i=1:4
    for j=1:7
        prodprof(i,((360*(j-1))+1):360*j)=FlowRates(i,:);
    end
end

nw=zeros(4,2790);
nw(1,:)=prodprof(1,:);
nw(2,:)=[zeros(1,90) prodprof(2,1:end-90)];
nw(3,:)=[zeros(1,180) prodprof(2,1:end-180)];
nw(4,:)=[zeros(1,270) prodprof(2,1:end-270)];

s=size(nw,2);

figure;
subplot(4,1,1)
plot(nw(1,:), 'LineWidth', 1)
hold on
plot(s-270:s,nw(1,(end-270:end)), 'r', 'LineWidth', 1);
hold off
title(sprintf(' First Pool, Peak Rate is %s ' , num2str(pool(1))));

subplot(4,1,2)
plot(nw(2,:), 'LineWidth', 1)
hold on
plot(s-180:s,nw(2,(end-180:end)), 'r', 'LineWidth', 1);
plot(1:90,nw(2,(1:90)), 'k', 'LineWidth', 1);
hold off
title(sprintf(' Second Pool, Peak Rate is %s ' , num2str(pool(2))));


subplot(4,1,3)
plot(nw(3,:), 'LineWidth', 1)
hold on
plot(s-90:s,nw(3,(end-90:end)), 'r', 'LineWidth', 1);
plot(1:180,nw(3,(1:180)), 'k', 'LineWidth', 1);
hold off
title(sprintf(' Third Pool, Peak Rate is %s ' , num2str(pool(3))));

subplot(4,1,4)
plot(nw(4,:), 'LineWidth', 1)
hold on
plot(1:270,nw(4,(1:270)), 'k', 'LineWidth', 1);
hold off
title(sprintf(' Fourth Pool, Peak Rate is %s ' , num2str(pool(4))));

%% 3rd part
figure
subplot(1,1,1)
plot(nw(1,:))
title(sprintf(' First Pool, Peak Rate is %s ' , num2str(pool(1))));

%% 4th part
figure
subplot(2,2,1)
plot(A(1,:))
title(sprintf(' First Pool, Peak Rate is %s ' , num2str(pool(1))));

subplot(2,2,2)
plot(A(2,:))
title(sprintf(' Second Pool, Peak Rate is %s ' , num2str(pool(2))));


subplot(2,2,3)
plot(A(3,:))
title(sprintf(' Third Pool, Peak Rate is %s ' , num2str(pool(3))));

subplot(2,2,4)
plot(A(4,:))
title(sprintf(' Fourth Pool, Peak Rate is %s ' , num2str(pool(4))));


%% 5th part

figure;
plot(A(1,:))
ylabel('Flow Rate in Bbl/d');
xlabel('Time in Day');
title(sprintf('First Pool, Peak Rate is %s ' , num2str(pool(1))));
% for i=1:size(pool,2)
% plot(FlowRates(i,:)); hold on
% end 
% ylabel('Flow Rate in Bbl/d');
% xlabel('Time in Day');
% title('Flow Rates of the 4 Pools vs Time')
% legend('Flow Profile of Pool 1','Flow Profile of Pool 2','Flow Profile of Pool 3','Flow Profile of Pool 4')
% hold off;

