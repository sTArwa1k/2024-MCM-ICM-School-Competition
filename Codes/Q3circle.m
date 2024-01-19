N=100000;
l_inc3=[0,-1];
J_Curve=zeros(N,1);
J_I=zeros(N,1);
y_i3=zeros(N,1);
N_K=zeros(N,2);
delta=1:1:N;
J_Curve(delta,1)=coordi_P(1,1)+delta*(coordi_P(601,1)-coordi_P(1,1))/N;
for i=1:1:600
    for delta=1:1:N
        if J_Curve(delta,1)>=coordi_P(i,1) && J_Curve(delta,1)<=coordi_P(i+1,1)
            J_I(delta,1)=i;
        else
            continue
        end
    end
end
J_I(N,1)=600;
for delta=1:1:N
    N_K(delta,1)=coordi_P(1,1)+delta*(coordi_P(601,1)-coordi_P(1,1))/N;
    if delta<=N-1
        N_K(delta,2)=(coordi_P(J_I(delta,1)+1,2)-coordi_P(J_I(delta,1),2))/(coordi_P(J_I(delta,1)+1,1)-coordi_P(J_I(delta,1),1))*(N_K(delta,1)-coordi_P(J_I(delta,1),1))+coordi_P(J_I(delta,1),2);
    else
        N_K(delta,2)=coordi_P(601,2);
    end
    y_i3(delta,1)=-l_ref(J_I(delta,1),2)/l_ref(J_I(delta,1),1)*N_K(delta,1)+N_K(delta,2);
end

Sum3=zeros(151,1);
for j=-290:1:-140
    for i=1:1:N
        if y_i3(i,1)>=j-10 && y_i3(i,1)<=j+10
            Sum3(j+291,1)=Sum3(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum3(end)=NaN;
c=Sum3;
patch(-290:-140,Sum3(:,1)/N,c,'EdgeColor','interp','lineWidth',2)
hold on
plot(-160,0.4891,'r.','MarkerSize',20)
grid on
text(-195,0.4891,'(-160,0.4891)','fontsize',12,'fontname','Times New Roman')
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Proportion of Light Ray','FontName','Times New Roman','FontSize',12);
title('Proportion of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[0 0.55]);
%%
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
for i=1:3000:100000
    hold on
    plot([N_K(i,1),0],[N_K(i,2),y_i3(i,1)],'r','lineWidth',0.5)
end
for i=1:3000:100000
    hold on
    plot([N_K(i,1),N_K(i,1)],[0,N_K(i,2)],'y','lineWidth',0.5)
end
axis equal
grid on
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Scatter Density Plot of Reflection Light Ray','Fontsize',16,'Fontname','Times New Roman')
hold on
CData=density2C(zeros(100000,1),y_i3(:,1),-2:0.1:15,-300:50:-150);
scatter(zeros(100000,1),y_i3(:,1),'filled','CData',CData);

function [CData,h,XMesh,YMesh,ZMesh,colorList]=density2C(X,Y,XList,YList,colorList)
[XMesh,YMesh]=meshgrid(XList,YList);
XYi=[XMesh(:) YMesh(:)];
F=ksdensity([X,Y],XYi);
ZMesh=zeros(size(XMesh));
ZMesh(1:length(F))=F;

h=interp2(XMesh,YMesh,ZMesh,X,Y);
if nargin<5
colorList=1/256*[245 251 177
    254 232 154
    253 185 106
    245 117 71
    214 54 78
    158 1 66
    ];
end
colorFunc=colorFuncFactory(colorList);
CData=colorFunc((h-min(h))./(max(h)-min(h)));
colorList=colorFunc(linspace(0,1,100)');

function colorFunc=colorFuncFactory(colorList)
x=(0:size(colorList,1)-1)./(size(colorList,1)-1);
y1=colorList(:,1);y2=colorList(:,2);y3=colorList(:,3);
colorFunc=@(X)[interp1(x,y1,X,'pchip'),interp1(x,y2,X,'pchip'),interp1(x,y3,X,'pchip')];
end
end
