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

for i=1:21:600
    hold on
    plot([coordi_Q2(i,1),coordi_Q2(i,1)-coordi_Q2(i,2)*l_inc(1,1)/l_inc(1,2)],[coordi_Q2(i,2),0],'y','lineWidth',0.5')
    hold on
    plot([coordi_Q2(i,1),0],[coordi_Q2(i,2),y2(i,1)],'r','lineWidth',0.5)
end

axis equal
grid on
set(gca,'XLim',[-0.05 0.05]);
set(gca,'YLim',[-196.907 -196.707]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Partial enlargement','Fontsize',16,'Fontname','Times New Roman')

hold on
CData=density2C(zeros(600,1),y2(:,1),-2:0.1:15,-300:50:-150);
scatter(zeros(600,1),y2(:,1),'filled','CData',CData);

function [CData,h,XMesh,YMesh,ZMesh,colorList]=density2C(X,Y,XList,YList,colorList)
[XMesh,YMesh]=meshgrid(XList,YList);
XYi=[XMesh(:) YMesh(:)];
F=ksdensity([X,Y],XYi);
ZMesh=zeros(size(XMesh));
ZMesh(1:length(F))=F;

h=interp2(XMesh,YMesh,ZMesh,X,Y);
if nargin<5
colorList=1/256*[
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