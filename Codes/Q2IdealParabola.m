L_ave2=zeros(401,1);
coordi_Pdelta=zeros(601,1);
phi=-pi/18;
for L=-20:0.1:20
    p=coordi_P(601,1)^2/(2*(coordi_P(601,2)+300+L));
    coordi_P2=zeros(601,2);
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
        if coordi_P(i,1)>0 || coordi_P(i,2)>=tan(17*pi/18)*coordi_P(i,1)
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
    for i=1:1:601
        coordi_Pdelta(i,1)=sqrt(coordi_P2(i,1)^2+coordi_P2(i,2)^2)-sqrt(coordi_P(i,1)^2+coordi_P(i,2)^2);
    end
    L_ave2(int32(10*L+201),1)=sum(abs(coordi_Pdelta))/601;
end

plot(-20:0.1:20,L_ave2,'lineWidth',2)
grid on
hold on
plot(-2.4,15.1067,'b.','MarkerSize',20)
text(-3,14.5,'(-2.4,15.1067)','fontsize',12,'fontname','Times New Roman')
set(gca,'XLim',[-20 20]);
set(gca,'YLim',[13 24]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('L(m)','FontName','Times New Roman','FontSize',12);
ylabel('Average Movement Amount','FontName','Times New Roman','FontSize',12);
title('The Trend of Evaluation Indicators for the Total Movement','Fontsize',16,'Fontname','Times New Roman')
legend('\delta_{ave}','FontName','Times New Roman','FontSize',12)