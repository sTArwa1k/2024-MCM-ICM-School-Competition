phi=-pi/18;
QT=[cos(phi) sin(phi);-sin(phi) cos(phi)]*coordi_P(601,:)';
P1T=[cos(phi) sin(phi);-sin(phi) cos(phi)]*coordi_P(1,:)';
syms pQ2 LQ2
eqns=[QT(1)^2==2*pQ2*(QT(2)+300+LQ2),P1T(1)^2==2*pQ2*(P1T(2)+300+LQ2)];
vars=[pQ2 LQ2];
sol=solve(eqns,vars);
solp=vpa(sol.pQ2,7)
solL=vpa(sol.LQ2,6)
%%
solp=221.5664;solL=5.9;
x=coordi_P(1,1):1:coordi_P(601,1)+8;
x=x';
y=(-cos(phi)*(sin(phi)*x-solp)-sqrt(cos(phi)*cos(phi)*(sin(phi)*x-solp).^2-sin(phi)*sin(phi)*(cos(phi)*cos(phi)*x.^2+2*solp*(sin(phi)*x-300-solL))))/(sin(phi))^2;
plot(x,y)
hold on
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
axis equal
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
%%
coordi_P2=zeros(601,2);
L=-2.4;

f=-300-L+p/2;

for i=1:1:601
    if coordi_P(i,1)~=0
        A=(cos(phi)+sin(phi)*coordi_P(i,2)/coordi_P(i,1))^2;
        B=-2*f*sin(phi)*(cos(phi)+sin(phi)*coordi_P(i,2)/coordi_P(i,1))+2*p*(sin(phi)-cos(phi)*coordi_P(i,2)/coordi_P(i,1));
        C=(f*sin(phi))^2-2*p*(p/2-f*cos(phi));
    else
        A=(cos(phi))^2;
        B=2*p*sin(phi);
        C=-2*p*(300+L);
    end
    if coordi_P(i,1)>0
        coordi_P2(i,1)=(-B+sqrt(B^2-4*A*C))/(2*A);
        coordi_P2(i,2)=coordi_P(i,2)/coordi_P(i,1)*coordi_P2(i,1);
    elseif coordi_P(i,1)==0
        coordi_P2(i,1)=0;
        coordi_P2()
    else
        coordi_P2(i,1)=(-B-sqrt(B^2-4*A*C))/(2*A);
        coordi_P2(i,2)=coordi_P(i,2)/coordi_P(i,1)*coordi_P2(i,1);
    end
end
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
hold on
plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
axis equal
grid on
set(gca,'XLim',[-300 500]);
set(gca,'YLim',[-500 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Base Circle And Rotated Parabola','Fontsize',16,'Fontname','Times New Roman')