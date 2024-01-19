N=100000;
l_inc3=[0,-1];
J_Curve2=zeros(N,1);
J_I2=zeros(N,1);
y_i32=zeros(N,1);
N_K2=zeros(N,2);
delta=1:1:N;
l_ref32=zeros(600,2);
n_i32=zeros(600,2);

for i=1:1:600
    n_i32(i,1)=coordi_P1(i,2)-coordi_P1(i+1,2);
    n_i32(i,2)=coordi_P1(i+1,1)-coordi_P1(i,1);
    n_i32(i,:)=n_i32(i,:)/norm(n_i32(i,:));
    fai_mc=acos((l_inc(1,1)*n_i32(i,1)-l_inc(1,2)*n_i32(i,2))/(norm(l_inc)*norm(n_i32(i,:))));
    l_ref32(i,:)=l_inc+2*n_i32(i,:)*cos(fai_mc);
end
J_Curve2(delta,1)=coordi_P1(1,1)+delta*(coordi_P1(601,1)-coordi_P1(1,1))/N;
for i=1:1:600
    for delta=1:1:N
        if J_Curve2(delta,1)>=coordi_P1(i,1) && J_Curve2(delta,1)<=coordi_P1(i+1,1)
            J_I2(delta,1)=i;
        else
            continue
        end
    end
end
J_I2(N,1)=600;
for delta=1:1:N
    N_K2(delta,1)=coordi_P1(1,1)+delta*(coordi_P1(601,1)-coordi_P1(1,1))/N;
    if delta<=N-1
        N_K2(delta,2)=(coordi_P1(J_I2(delta,1)+1,2)-coordi_P1(J_I2(delta,1),2))/(coordi_P1(J_I2(delta,1)+1,1)-coordi_P1(J_I2(delta,1),1))*(N_K2(delta,1)-coordi_P1(J_I2(delta,1),1))+coordi_P1(J_I2(delta,1),2);
    else
        N_K2(delta,2)=coordi_P1(601,2);
    end
    y_i32(delta,1)=-l_ref32(J_I2(delta,1),2)/l_ref32(J_I2(delta,1),1)*N_K2(delta,1)+N_K2(delta,2);
end
%%
Sum32=zeros(151,1);
for j=-290:1:-140
    for i=1:1:N
        if y_i32(i,1)>=j-10 && y_i32(i,1)<=j+10
            Sum32(j+291,1)=Sum32(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum32(end)=NaN;
c=Sum32;
patch(-290:-140,Sum32(:,1)/N,c,'EdgeColor','interp','lineWidth',2)
hold on
plot(-165,0.988,'r.','MarkerSize',20)
grid on
text(-205,0.988,'(-165,0.988)','fontsize',12,'fontname','Times New Roman')
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Proportion of Light Ray','FontName','Times New Roman','FontSize',12);
title('Proportion of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[0 1.05]);

%%
plot(coordi_P1(:,1),coordi_P1(:,2),'lineWidth',2);
for i=1:6000:100000
    hold on
    plot([N_K2(i,1),0],[N_K2(i,2),y_i32(i,1)],'r','lineWidth',0.5)
end
for i=1:6000:100000
    hold on
    plot([N_K2(i,1),N_K2(i,1)],[0,N_K2(i,2)],'y','lineWidth',0.5)
end
%axis equal
grid on
set(gca,'XLim',[-10 10]);
set(gca,'YLim',[-170 -150]);
set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Partial Enlargement','Fontsize',16,'Fontname','Times New Roman')
hold on
CData=density2C(zeros(100000,1),y_i32(:,1),-2:0.1:15,-300:3:-150);
scatter(zeros(100000,1),y_i32(:,1),'filled','CData',CData);

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