clc,clear
R=300;
l=1;
theta_l=2*sin(l/(2*R));
theta=1200*sin(l/(2*R));
coordi_P=zeros(601,2);
coordi_Q=zeros(600,2);

coordi_P(1,1)=R*cos((1-301)*theta_l-pi/2);
coordi_P(1,2)=R*sin((1-301)*theta_l-pi/2);
for i=2:601
    coordi_P(i,1)=R*cos((i-301)*theta_l-pi/2);
    coordi_P(i,2)=R*sin((i-301)*theta_l-pi/2);
    coordi_Q(i-1,1)=(coordi_P(i,1)+coordi_P(i-1,1))/2;
    coordi_Q(i-1,2)=(coordi_P(i,2)+coordi_P(i-1,2))/2;
end

plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
axis equal
grid on
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Schematic Diagram of the Circle','Fontsize',16,'Fontname','Times New Roman')