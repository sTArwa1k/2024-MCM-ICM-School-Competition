l_inc=[0,-1];
n_i=zeros(600,2);
l_ref=zeros(600,2);
y=zeros(600,1);

for i=1:1:600
    n_i(i,1)=coordi_P(i,2)-coordi_P(i+1,2);
    n_i(i,2)=coordi_P(i+1,1)-coordi_P(i,1);
    fai_mc=acos((l_inc(1,1)*n_i(i,1)-l_inc(1,2)*n_i(i,2))/(norm(l_inc)*norm(n_i(i,:))));
    l_ref(i,:)=l_inc+2*n_i(i,:)*cos(fai_mc);
    y(i,1)=coordi_Q(i,2)-l_ref(i,2)/l_ref(i,1)*coordi_Q(i,1);
end

plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
for i=41:40:600
    hold on
    plot([coordi_Q(i,1),coordi_Q(i,1)],[0,coordi_Q(i,2)],'y','lineWidth',1)
end
for i=41:40:600
    hold on
    plot([coordi_Q(i,1),0],[coordi_Q(i,2),y(i,1)],'r','lineWidth',1)
end
axis equal
grid on
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Schematic Diagram of Reflection','Fontsize',16,'Fontname','Times New Roman')