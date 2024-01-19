Sum1=zeros(151,1);
for j=-290:1:-140
    for i=1:1:600
        if y2(i,1)>=j-0.5 && y2(i,1)<=j+0.5
            Sum1(j+291,1)=Sum1(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum1(end)=NaN;
c=Sum1;
patch(-290:-140,Sum1(:,1),c,'EdgeColor','interp','lineWidth',3)
grid on
set(gca,'YLim',[-10 640]);
xlabel('Midpoint of the interval with a length of 1m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Number of Light Ray','FontName','Times New Roman','FontSize',12);
title('Number of Light Ray in the interval with a length of 1m','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
hold on
plot(-197,600,'y.','MarkerSize',20)
text(-194,600,'(-197,600)','fontsize',12,'fontname','Times New Roman')