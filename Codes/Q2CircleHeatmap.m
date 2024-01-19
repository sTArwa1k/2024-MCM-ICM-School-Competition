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
for i=1:1:600
    if y1(i,1)>-300
        continue
    else
        y1(i,1)=NaN;
    end
end

for i=21:20:600
    if y1(i,1)>-300
        hold on
        plot([coordi_Q(i,1),0],[coordi_Q(i,2),y1(i,1)],'r','lineWidth',0.5)
    else
        continue
    end
end

axis equal
grid on
set(gca,'XLim',[-300 300]);
set(gca,'YLim',[-350 0]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Scatter Density Plot of Reflection Light Ray','Fontsize',16,'Fontname','Times New Roman')
%%
hold on
CData=density2C(zeros(600,1),y1(:,1),-2:0.1:15,-300:50:-150);
scatter(zeros(600,1),y1(:,1),'filled','CData',CData);

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