l_inc=[-sin(pi/18),-cos(pi/18)];
n_i2=zeros(600,2);
l_ref2=zeros(600,2);
y2=zeros(600,1);
coordi_Q2=zeros(600,2);
for i=2:601
    coordi_Q2(i-1,1)=(coordi_P2(i,1)+coordi_P2(i-1,1))/2;
    coordi_Q2(i-1,2)=(coordi_P2(i,2)+coordi_P2(i-1,2))/2;
end

for i=1:1:600
    n_i2(i,1)=coordi_P2(i,2)-coordi_P2(i+1,2);
    n_i2(i,2)=coordi_P2(i+1,1)-coordi_P2(i,1);
    n_i2(i,:)=n_i2(i,:)/norm(n_i2(i,:));
    fai_mc=acos((-l_inc(1,1)*n_i2(i,1)-l_inc(1,2)*n_i2(i,2))/(norm(l_inc)*norm(n_i2(i,:))));
    l_ref2(i,:)=l_inc+2*n_i2(i,:)*cos(fai_mc);
    y2(i,1)=coordi_Q2(i,2)-l_ref2(i,2)/l_ref2(i,1)*coordi_Q2(i,1);
end

% plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
% hold on
plot(coordi_Q2(:,1),coordi_Q2(:,2),'lineWidth',2);

for i=1:39:600
    hold on
    plot([coordi_Q2(i,1),0],[coordi_Q2(i,2),y2(i,1)],'r','lineWidth',0.5)
end

axis equal
grid on
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Incident And Reflection Light Ray','Fontsize',16,'Fontname','Times New Roman')
%%
coordi_PDelta=zeros(600,1);
for i=1:1:600
    coordi_PDelta(i,1)=sqrt((coordi_P2(i+1,1)-coordi_P2(i,1))^2+(coordi_P2(i+1,2)-coordi_P2(i,2))^2);
end
