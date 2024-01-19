L_Ideal41=zeros(201,1);
p_Ideal41=zeros(201,1);
syms Lvar
for f=-170:0.1:-150
    eqn=coordi_P(601,1)*coordi_P(601,1)/(4*(coordi_P(601,2)+300+Lvar))-Lvar==f+300;
    L_Ideal41(10*f+1701,1)=vpa(max(solve(eqn,Lvar)),5);
end
for i=1:1:201
    p_Ideal41(i,1)=coordi_P(601,1)*coordi_P(601,1)/(2*(coordi_P(601,2)+300+L_Ideal41(i,1)));
end
%%
Delta41=zeros(201,1);
L_ave4=zeros(201,1);
Phi=-pi/18;

for f=-170:0.1:-150
    p=p_Ideal41(10*f+1701,1);
    coordi_P2=zeros(601,2);
    L=L_Ideal41(10*f+1701,1);
    for i=1:1:601
        if coordi_P(i,1)~=0
            A=(cos(Phi)+sin(Phi)*coordi_P(i,2)/coordi_P(i,1))^2;
            B=-2*f*sin(Phi)*(cos(Phi)+sin(Phi)*coordi_P(i,2)/coordi_P(i,1))+2*p*(sin(Phi)-cos(Phi)*coordi_P(i,2)/coordi_P(i,1));
            C=(f*sin(Phi))^2-2*p*(p/2-f*cos(Phi));
        else
            A=(cos(Phi))^2;
            B=2*p*sin(Phi);
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
    coordi_Pdelta41=zeros(601,1);
    for i=1:1:601
        coordi_Pdelta41(i,1)=sqrt(coordi_P2(i,1)^2+coordi_P2(i,2)^2)-sqrt(coordi_P(i,1)^2+coordi_P(i,2)^2);
    end
    L_ave4(int32(10*f+1701),1)=sum(abs(coordi_Pdelta41))/601;
end
%%
plot(-170:0.1:-150,L_ave4,'lineWidth',2)
grid on
hold on
plot(-160,17.4499,'b.','MarkerSize',20)
text(-160,17,'(-160,17.4499)','fontsize',12,'fontname','Times New Roman')
set(gca,'XLim',[-170 -150]);
set(gca,'YLim',[15 21]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('f(m)','FontName','Times New Roman','FontSize',12);
ylabel('Average Movement Amount','FontName','Times New Roman','FontSize',12);
title('The Trend of Evaluation Indicators for the Total Movement','Fontsize',16,'Fontname','Times New Roman')
legend('\delta_{ave}','FontName','Times New Roman','FontSize',12)
%%
f=-160;
p=p_Ideal41(10*f+1701,1);
coordi_P2=zeros(601,2);
L=L_Ideal41(10*f+1701,1);
for i=1:1:601
    if coordi_P(i,1)~=0
        A=(cos(Phi)+sin(Phi)*coordi_P(i,2)/coordi_P(i,1))^2;
        B=-2*f*sin(Phi)*(cos(Phi)+sin(Phi)*coordi_P(i,2)/coordi_P(i,1))+2*p*(sin(Phi)-cos(Phi)*coordi_P(i,2)/coordi_P(i,1));
        C=(f*sin(Phi))^2-2*p*(p/2-f*cos(Phi));
    else
        A=(cos(Phi))^2;
        B=2*p*sin(Phi);
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

plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
hold on
plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
hold on
plot(0,f,'r.','MarkerSize',20)
text(10,f,'Focus Point','fontsize',12,'fontname','Times New Roman')
grid on
axis equal
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Base Circle and Ideal Parabola','Fontsize',16,'Fontname','Times New Roman')
legend('Base Circle','Ideal Parabola')