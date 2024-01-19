L=-10.2256;
p=coordi_P(601,1)^2/(2*(coordi_P(601,2)+300+L));
x=coordi_P(1,1):1:coordi_P(601,1);
x=x';
y_p=x.^2/(2*p)-300-L;
coordi_P1=zeros(601,2);
coordi_P1(1:300,1)=p*(coordi_P(1:300,2)./coordi_P(1:300,1))-sqrt((p*coordi_P(1:300,2)./coordi_P(1:300,1)).^2+2*p*(300+L));
coordi_P1(1:300,2)=coordi_P(1:300,2)./coordi_P(1:300,1).*coordi_P1(1:300,1);
coordi_P1(301,1)=0;coordi_P1(301,2)=-300-L;
coordi_P1(302:601,1)=p*(coordi_P(302:601,2)./coordi_P(302:601,1))+sqrt((p*coordi_P(302:601,2)./coordi_P(302:601,1)).^2+2*p*(300+L));
coordi_P1(302:601,2)=coordi_P(302:601,2)./coordi_P(302:601,1).*coordi_P1(302:601,1);
coordi_Pdelta=zeros(600,1);
for i=1:1:600
    coordi_Pdelta(i,1)=(coordi_P1(i+1,2)-coordi_P1(i,2))^2+(coordi_P1(i+1,1)-coordi_P1(i,1))^2;
end
RMSE=sqrt(1/600*sum(sqrt(coordi_Pdelta)-1)^2)
plot(x,y_p,'lineWidth',2)
hold on
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
grid on
axis equal
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Base Circle and Ideal Parabola','Fontsize',16,'Fontname','Times New Roman')
legend('Ideal Parabola','Base Circle')