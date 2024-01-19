L_max=zeros(401,1);
L_sum=zeros(401,1);

for L=-20:0.1:20
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
    coordi_Pdelta=zeros(601,1);
    for i=1:1:601
        coordi_Pdelta(i,1)=sqrt(coordi_P1(i,1)^2+coordi_P1(i,2)^2)-sqrt(coordi_P(i,1)^2+coordi_P(i,2)^2);
    end
    L_max(int32(10*L+201),1)=max(abs(coordi_Pdelta));
    L_sum(int32(10*L+201),1)=sum(abs(coordi_Pdelta))/601;
end

plot(-20:0.1:20,L_sum,'lineWidth',2)
hold on
plot(-20:0.1:20,L_max,'lineWidth',2)
hold on
plot(4.2,3.7415,'b.','MarkerSize',20)
hold on
plot(5.9,5.95464,'r.','MarkerSize',20)
grid on
text(6.3,6.1,'(5.9,5.9546)','fontsize',12,'fontname','Times New Roman')
text(4.2,3,'(4.2,3.7415)','fontsize',12,'fontname','Times New Roman')
set(gca,'XLim',[-20 20]);
set(gca,'YLim',[0 24]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('L(m)','FontName','Times New Roman','FontSize',12);
ylabel('Movement Amount','FontName','Times New Roman','FontSize',12);
title('The Trend of Evaluation Indicators for the Total Movement','Fontsize',16,'Fontname','Times New Roman')
legend('\delta_{ave}','\delta_{max}','Fontsize',16,'Fontname','Times New Roman')