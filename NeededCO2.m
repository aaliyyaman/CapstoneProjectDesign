function NeededCO2(P,T,G,O,Bo,W,Bw)
T=T+460;
z=Z_calc(T,P);

gas=G*0.0282*z*T/P;
oil=O*Bo*5.615;
water=W*Bw*5.615;
sand=(oil+water)*0.02*5.615;
V=gas+oil+water+sand;

R=10.73;

n=P*V/(z*R*T);
kg=n*0.044;
ton=n*44/453.6/2000;

fprintf('\n\n\n')
fprintf('%6.2f mol CO2 needed\n\n',n);
fprintf('%6.2f ton (us ton), or %6.2fkg, CO2 is needed to presurze the reservoir to \n its initial pressure which was %6.2fpsi \n',ton,kg,P)


end

function z=Z_calc(T,P)
% DRANCHUK AND ABU-KASSEM'S METHOD
% Equations of State and PVT Analysis, Ahmet Tarek, page 220.

% T=122; P=550;

Ppc=870;
Tpc=500;

Tpr=T/Tpc;
Ppr=P/Ppc;

A1=0.3265;
A2=-1.0700;
A3=-0.5339;
A4=0.01569;
A5=-0.05165;
A6=0.5475;
A7=-0.7361;
A8=0.1844;
A9=0.1056;
A10=0.6134;
A11=0.7210;

R1=A1+(A2/Tpr)+(A3/Tpr^3)+(A4/Tpr^4)+(A5/Tpr^5);
R2=0.27*(Ppr/Tpr);
R3=A6+(A7/Tpr)+(A8/Tpr^2);
R4=A9*((A7/Tpr)+(A8/Tpr^2));
R5=(A10/Tpr^3);

syms y
fonksiyon=0==(R5*y^2*(1+A11*y^2)*exp(-A11*y^2))+(R1*y)-(R2/y)+(R3*y^2)-(R4*y^2)+1;
c=round(double(vpasolve(fonksiyon,y)),4);

z=round(0.27*(Ppr/(c*Tpr)),3);

end