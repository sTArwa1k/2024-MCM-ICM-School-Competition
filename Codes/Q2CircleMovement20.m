Sum=zeros(191,1);
for j=-290:1:-100
    for i=1:1:600
        if y1(i,1)>=j-10 && y1(i,1)<=j+10
            Sum(j+291,1)=Sum(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum(end)=NaN;
c=Sum;
patch(-290:-100,Sum(:,1),c,'EdgeColor','interp','lineWidth',3)
grid on
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Number of Light Ray','FontName','Times New Roman','FontSize',12);
title('Number of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
text(-225,125,'(-190,125)','fontsize',12,'fontname','Times New Roman')
hold on
plot(-190,125,'g.','MarkerSize',20)
hold on
plot(-183,224,'y.','MarkerSize',20)
text(-178,224,'(-183,224)','fontsize',12,'fontname','Times New Roman')