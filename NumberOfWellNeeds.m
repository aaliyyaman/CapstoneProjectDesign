function [pool] = NumberOfWellNeeds(PlantCapacity,WellInjRate)
%ninj=PlantCapacity/WellInjRate;
pc=PlantCapacity;
wir=WellInjRate;
f=@(x) exp(-0.4692*x+1.4076);
Cycle=7;

pool=zeros(4,1);
pool(1,1)=round(pc/wir);
pool(2,1)=round((pc+pool(1,1)*wir*integral(f,3,6)/3)/wir);
pool(3,1)=round((pc+(pool(1,1)*wir*integral(f,6,9)+...
    pool(2,1)*wir*integral(f,3,6))/3)/wir);
pool(4,1)=round((pc+(pool(1,1)*wir*integral(f,9,12)+...
    pool(2,1)*wir*integral(f,6,9)+pool(3,1)*wir*integral(f,3,6))/3)/wir);

for j=2:Cycle

    for i=1:4
        pool(i,j)=round((pc+(pool(4*(j-1)+i-3)*wir*integral(f,9,12)+...
    pool(4*(j-1)+i-2)*wir*integral(f,6,9)+pool(4*(j-1)+i-1)*wir*integral(f,3,6))/3)/wir);
    end
end
pool=array2table(pool,'VariableNames',{'Clcle 1','Clcle 2','Clcle 3','Clcle 4','Clcle 5','Clcle 6',...
'Clcle 7'},'RowNames',{'Pool 1','Pool 2','Pool 3','Pool 4'});

end

