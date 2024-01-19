l_inc=[-sin(pi/18),-cos(pi/18)];
n_i1=zeros(600,2);
l_ref1=zeros(600,2);
y1=zeros(600,1);

for i=1:1:600
    n_i1(i,1)=coordi_P(i,2)-coordi_P(i+1,2);
    n_i1(i,2)=coordi_P(i+1,1)-coordi_P(i,1);
    fai_mc=acos((l_inc(1,1)*n_i1(i,1)-l_inc(1,2)*n_i1(i,2))/(norm(l_inc)*norm(n_i1(i,:))));
    l_ref1(i,:)=l_inc+2*n_i1(i,:)*cos(fai_mc);
    y1(i,1)=coordi_Q(i,2)-l_ref1(i,2)/l_ref1(i,1)*coordi_Q(i,1);
end
%%
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
%%
for i=21:6:600
    if y1(i,1)>-300
        hold on
        plot([coordi_Q(i,1),0],[coordi_Q(i,2),y1(i,1)],'r','lineWidth',0.5)
    else
        hold on
        y1(i,1)=NaN;
        if coordi_Q(i,1)<0 && l_ref1(i,2)>=0
            plot([coordi_Q(i,1),-coordi_Q(i,2)*l_ref1(i,1)/l_ref1(i,2)+coordi_Q(i,1)],[coordi_Q(i,2),0],'m','lineWidth',0.5)
        else
            a=l_ref1(i,2)/l_ref1(i,1);b=coordi_Q(i,2)-(l_ref1(i,2)/l_ref1(i,1))*coordi_Q(i,1);
            plot([coordi_Q(i,1),(-a*b+sqrt(a^2*R^2-b^2+R^2))/(a^2+1)],[coordi_Q(i,2),a*(-a*b+sqrt(a^2*R^2-b^2+R^2))/(a^2+1)+b],'m','lineWidth',0.5)
        end
    end
    hold on
    plot([coordi_Q(i,1),coordi_Q(i,1)-coordi_Q(i,2)*l_inc(1,1)/l_inc(1,2)],[coordi_Q(i,2),0],'y','lineWidth',0.5')
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