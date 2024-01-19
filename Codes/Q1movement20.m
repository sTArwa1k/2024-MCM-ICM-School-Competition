Sum=zeros(151,1);
for j=-290:1:-140
    for i=1:1:600
        if y(i,1)>=j-10 && y(i,1)<=j+10
            Sum(j+291,1)=Sum(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum(end)=NaN;
c=Sum;
patch(-290:-140,Sum(:,1),c,'EdgeColor','interp','lineWidth',3)
grid on
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Number of Light Ray','FontName','Times New Roman','FontSize',12);
title('Number of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');