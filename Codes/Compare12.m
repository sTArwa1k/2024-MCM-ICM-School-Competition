L=4.2;
p=coordi_P(601,1)^2/(2*(coordi_P(601,2)+300+L));
coordi_P1=zeros(601,2);
coordi_P1(1:300,1)=p*(coordi_P(1:300,2)./coordi_P(1:300,1))-sqrt((p*coordi_P(1:300,2)./coordi_P(1:300,1)).^2+2*p*(300+L));
coordi_P1(1:300,2)=coordi_P(1:300,2)./coordi_P(1:300,1).*coordi_P1(1:300,1);
coordi_P1(301,1)=0;coordi_P1(301,2)=-300-L;
coordi_P1(302:601,1)=p*(coordi_P(302:601,2)./coordi_P(302:601,1))+sqrt((p*coordi_P(302:601,2)./coordi_P(302:601,1)).^2+2*p*(300+L));
coordi_P1(302:601,2)=coordi_P(302:601,2)./coordi_P(302:601,1).*coordi_P1(302:601,1);
coordi_Pdelta=zeros(601,1);
for i=1:1:601
    coordi_Pdelta(i,1)=sqrt(coordi_P1(i,1)^2+coordi_P1(i,2)^2)-sqrt(coordi_P(i,1)^2+coordi_P(i,2)^2);
end
plot(coordi_P1(:,1),coordi_Pdelta(:,1),'LineWidth',1)

L=5.9;
p=coordi_P(601,1)^2/(2*(coordi_P(601,2)+300+L));
coordi_P1=zeros(601,2);
coordi_P1(1:300,1)=p*(coordi_P(1:300,2)./coordi_P(1:300,1))-sqrt((p*coordi_P(1:300,2)./coordi_P(1:300,1)).^2+2*p*(300+L));
coordi_P1(1:300,2)=coordi_P(1:300,2)./coordi_P(1:300,1).*coordi_P1(1:300,1);
coordi_P1(301,1)=0;coordi_P1(301,2)=-300-L;
coordi_P1(302:601,1)=p*(coordi_P(302:601,2)./coordi_P(302:601,1))+sqrt((p*coordi_P(302:601,2)./coordi_P(302:601,1)).^2+2*p*(300+L));
coordi_P1(302:601,2)=coordi_P(302:601,2)./coordi_P(302:601,1).*coordi_P1(302:601,1);
coordi_Pdelta=zeros(601,1);
for i=1:1:601
    coordi_Pdelta(i,1)=sqrt(coordi_P1(i,1)^2+coordi_P1(i,2)^2)-sqrt(coordi_P(i,1)^2+coordi_P(i,2)^2);
end

hold on
plot(coordi_P1(:,1),coordi_Pdelta(:,1),'LineWidth',1)
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[-8 8]);
grid on
legend('Fisrt Kind','Second Kind','FontName','Times New Roman','FontSize',12)
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Movement Amount(m)','FontName','Times New Roman','FontSize',12);
title('Relationship Between Distance From Point to y-axis and the Radial Movement','Fontsize',16,'Fontname','Times New Roman')