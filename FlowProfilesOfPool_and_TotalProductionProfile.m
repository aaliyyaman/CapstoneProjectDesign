pool=[400 200 650 150]; % you can change this number to number what you want.
                        % each one is peak rate of one pool. 
                        % for example: 1st pool peak rate is 475 stbpd

FlowRates=zeros(4,270);
for i=1:size(pool,2)
    a=linspace(0,1,30).*(0.85+0.3*rand(1,30))*pool(i);
    b=(pool(i)-20+(40)*rand(1,90));
    c=flip(linspace(0,1,150)).*(0.95+0.15*rand(1,150))*pool(i);
    FlowRates(i,:)=[a b c];
end

subplot(2,2,1)
plot(FlowRates(1,:))
title(sprintf(' First Pool, Peak Rate is %s ' , num2str(pool(1))));

subplot(2,2,2)
plot(FlowRates(2,:))
title(sprintf(' Second Pool, Peak Rate is %s ' , num2str(pool(2))));


subplot(2,2,3)
plot(FlowRates(3,:))
title(sprintf(' Third Pool, Peak Rate is %s ' , num2str(pool(3))));

subplot(2,2,4)
plot(FlowRates(4,:))
title(sprintf(' Fourth Pool, Peak Rate is %s ' , num2str(pool(4))));

% for i=1:size(pool,2)
% plot(FlowRates(i,:)); hold on
% end 
% ylabel('Flow Rate in Bbl/d');
% xlabel('Time in Day');
% title('Flow Rates of the 4 Pools vs Time')
% legend('Flow Profile of Pool 1','Flow Profile of Pool 2','Flow Profile of Pool 3','Flow Profile of Pool 4')
% hold off;

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