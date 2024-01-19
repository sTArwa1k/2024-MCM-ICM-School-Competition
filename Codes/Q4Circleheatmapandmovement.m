N=100000;
phi=pi/18;
l_inc4=[-sin(pi/18),-cos(pi/18)];
J_Curve=zeros(N,2);
J_I=zeros(N,1);
y_i41=zeros(N,1);
N_K41=zeros(N,2);
delta=1:1:N;
A41=1+tan(pi/2-pi/18)*tan(pi/2-pi/18);
B41=2*tan(pi/2-phi)*tan(pi/2-phi)*(coordi_P(1,2)*tan(phi)-coordi_P(1,1)-delta*(coordi_P(601,1)-coordi_P(1,1))/N);
C41=tan(pi/2-phi)*tan(pi/2-phi)*(coordi_P(1,2)*tan(phi)-coordi_P(1,1)-delta*(coordi_P(601,1)-coordi_P(1,1))/N).^2-R^2;
J_Curve(:,1)=(-B41-sqrt(B41.^2-4*A41*C41))/(2*A41);
for delta=1:1:N
    J_Curve(delta,2)=tan(pi/2-phi)*(J_Curve(delta,1)+coordi_P(1,2)*tan(phi)-coordi_P(1,1)-delta*(coordi_P(601,1)-coordi_P(1,1))/N);
end
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
    PIY=coordi_P(J_I(delta,1),2);
    PIX=coordi_P(J_I(delta,1),1);
    PI1Y=coordi_P(J_I(delta,1)+1,2);
    PI1X=coordi_P(J_I(delta,1)+1,1);
    N_K41(delta,1)=(PIY-PIX*(PI1Y-PIY)/(PI1X-PIX)+tan(pi/2-phi)*(coordi_P(1,1)-coordi_P(1,2)*tan(phi)+delta*(coordi_P(601,1)-coordi_P(1,1))/N))/(tan(pi/2-phi)-(PI1Y-PIY)/(PI1X-PIX));
    N_K41(delta,2)=PIY+(PI1Y-PIY)/(PI1X-PIX)*(N_K41(delta,1)-PIX);
    y_i41(delta,1)=-l_ref1(J_I(delta,1),2)/l_ref1(J_I(delta,1),1)*N_K41(delta,1)+N_K41(delta,2);
end

%%
Sum41=zeros(151,1);
for j=-290:1:-140
    for i=1:1:N
        if y_i41(i,1)>=j-10 && y_i41(i,1)<=j+10
            Sum41(j+291,1)=Sum41(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum41(end)=NaN;
c=Sum41;
patch(-290:-140,Sum41(:,1)/N,c,'EdgeColor','interp','lineWidth',2)
hold on
plot(-160,0.06474,'r.','MarkerSize',20)
grid on
text(-175,0.09,'(-160,0,06474)','fontsize',12,'fontname','Times New Roman')
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Proportion of Light Ray','FontName','Times New Roman','FontSize',12);
title('Proportion of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[0 0.4]);

%%
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);

for i=1:3300:N
    if y_i41(i,1)>-300
        hold on
        plot([N_K41(i,1),0],[N_K41(i,2),y_i41(i,1)],'r','lineWidth',0.5)
    else
        hold on
        y_i41(i,1)=NaN;
        if N_K41(i,1)<0 && l_ref1(J_I(i,1),2)>=0
             plot([N_K41(i,1),-N_K41(i,2)*l_ref1(J_I(i,1),1)/l_ref1(J_I(i,1),2)+N_K41(i,1)],[N_K41(i,2),0],'m','lineWidth',0.5)
        else
            a=l_ref1(J_I(i,1),2)/l_ref1(J_I(i,1),1);b=N_K41(i,2)-(l_ref1(J_I(i,1),2)/l_ref1(J_I(i,1),1))*N_K41(i,1);
            plot([N_K41(i,1),(-a*b-sqrt(a^2*R^2-b^2+R^2))/(a^2+1)],[N_K41(i,2),a*(-a*b-sqrt(a^2*R^2-b^2+R^2))/(a^2+1)+b],'m','lineWidth',0.5)
        end
    end
    hold on
    plot([N_K41(i,1),N_K41(i,1)-N_K41(i,2)*l_inc4(1,1)/l_inc4(1,2)],[N_K41(i,2),0],'y','lineWidth',0.5')  
end

for i=1:1:N
    if y_i41(i,1)>-300
        continue
    else
        y_i41(i,1)=NaN;
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

hold on
CData=density2C(zeros(100000,1),y_i41(:,1),-2:0.1:15,-300:50:-150);
scatter(zeros(100000,1),y_i41(:,1),'filled','CData',CData);

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
%%