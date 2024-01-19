phi=pi/18;
    N=100000;
    J_Curve42=zeros(100000,1);
    J_I42=zeros(100000,1);
    N_K42=zeros(100000,2);
    J0=zeros(N,1);
    n_i42=zeros(600,1);
    l_ref42=zeros(600,2);
    y_i42=zeros(100000,1);

    for i=1:1:600
        n_i42(i,1)=coordi_P2(i,2)-coordi_P2(i+1,2);
        n_i42(i,2)=coordi_P2(i+1,1)-coordi_P2(i,1);
        n_i42(i,:)=n_i42(i,:)/norm(n_i42(i,:));
        fai_mc=acos((-l_inc(1,1)*n_i42(i,1)-l_inc(1,2)*n_i42(i,2))/(norm(l_inc)*norm(n_i42(i,:))));
        l_ref42(i,:)=l_inc+2*n_i42(i,:)*cos(fai_mc);
    end


    J_para=zeros(601,2);
    for i=1:1:601
        J_para(i,1)=coordi_P2(i,1)-coordi_P2(i,2)/tan(pi/2-phi);
    end
    for delta=1:1:N
        J0(delta,1)=coordi_P2(1,1)-coordi_P2(1,2)*tan(phi)+delta*(coordi_P2(601,1)-coordi_P2(1,1)+tan(phi)*(coordi_P2(1,2)-coordi_P2(601,2)))/N;
    end
    for delta=1:1:100000
        for i=1:1:600
            if J0(delta,1)>J_para(i,1) && J0(delta,1)<=J_para(i+1,1)
                J_I42(delta,1)=i;
            else
                continue
            end
        end
    end

    for delta=1:1:100000
        PIY=coordi_P2(J_I42(delta,1),2);
        PIX=coordi_P2(J_I42(delta,1),1);
        PI1Y=coordi_P2(J_I42(delta,1)+1,2);
        PI1X=coordi_P2(J_I42(delta,1)+1,1);
        N_K42(delta,1)=(J0(delta,1)*tan(pi/2-phi)+PIY-PIX*(PI1Y-PIY)/(PI1X-PIX))/(tan(pi/2-phi)-(PI1Y-PIY)/(PI1X-PIX));
        N_K42(delta,2)=tan(pi/2-phi)*(N_K42(delta,1)-J0(delta,1));
        y_i42(delta,1)=-l_ref42(J_I42(delta,1),2)/l_ref42(J_I42(delta,1),1)*N_K42(delta,1)+N_K42(delta,2);
    end

    Sum42=zeros(151,1);
    for j=-290:1:-140
        for i=1:1:N
            if y_i42(i,1)>=j-10 && y_i42(i,1)<=j+10
                Sum42(j+291,1)=Sum42(j+291,1)+1;
            else
                continue
            end
        end
    end
    %plot(-290:-140,Sum(:,1),'lineWidth',2)
    Sum42(end)=NaN;
    c=Sum42;
plot(-290:-140,Sum42(:,1)/N,'LineWidth',2,'Color',[38/256 70/256 83/256])
hold on
plot(-290:-140,Sum42(:,1)/N*0.998,'LineWidth',2,'Color',[42/256 157/256 142/256])
hold on
plot(-290:-140,Sum42(:,1)/N*0.995,'LineWidth',2,'Color',[243/256 162/256 97/256])
hold on
plot(-290:-140,Sum42(:,1)/N*0.997,'LineWidth',2,'Color',[233/256 196/256 107/256])
hold on
plot(-290:-140,Sum42(:,1)/N*0.993,'LineWidth',2,'Color',[230/256 111/256 81/256])
% plot(-160,0.9879,'r.','MarkerSize',20)
grid on
% text(-200,0.9879,'(-160,0.9879)','fontsize',12,'fontname','Times New Roman')
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Proportion of Light Ray','FontName','Times New Roman','FontSize',12);
title('Proportion of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[0.96 1]);
set(gca,'XLim',[-166 -154]);
legend('Original Angle','-1.5%','-3%','+1.5%','+3%')
%%
plot(N_K42(:,1),N_K42(:,2))
axis equal
hold on
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
hold on
plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
%%
for delta=1:1:100000
    a=tan(pi/2-phi);
    b=-tan(pi/2-phi)*(coordi_P2(1,1)-coordi_P2(1,2)*tan(phi)+delta*(coordi_P2(601,1)-coordi_P2(1,1)+tan(phi)*(coordi_P2(1,2)-coordi_P2(601,2)))/N);
    A=(cos(phi)+a*sin(phi))^2;
    B=2*a*(b-f)*sin(phi)*sin(phi)+2*(b-f)*sin(phi)*cos(phi)-2*p*sin(phi)-2*a*p*cos(phi);
    C=(b-f)^2*sin(phi)*sin(phi)-2*p*(b-f)*cos(phi)-p^2;
    J_Curve42(delta,1)=(-B-sqrt(B^2-4*A*C))/(2*A);
    J_Curve42(delta,2)=a*J_Curve42(delta,1)+b;
end
plot(J_Curve42(:,1),J_Curve42(:,2))
axis equal
hold on
plot(coordi_P(:,1),coordi_P(:,2),'lineWidth',2);
hold on
plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
%%
Sum42=zeros(151,1);
for j=-290:1:-140
    for i=1:1:N
        if y_i42(i,1)>=j-10 && y_i42(i,1)<=j+10
            Sum42(j+291,1)=Sum42(j+291,1)+1;
        else
            continue
        end
    end
end
%plot(-290:-140,Sum(:,1),'lineWidth',2)
Sum42(end)=NaN;
c=Sum42;
patch(-290:-140,Sum42(:,1)/N,c,'EdgeColor','interp','lineWidth',2)
hold on
plot(-160,0.9879,'r.','MarkerSize',20)
grid on
text(-200,0.9879,'(-160,0.9879)','fontsize',12,'fontname','Times New Roman')
xlabel('Midpoint of the interval with a length of 20m(m)','FontName','Times New Roman','FontSize',12);
ylabel('Proportion of Light Ray','FontName','Times New Roman','FontSize',12);
title('Proportion of Light Ray in the interval','Fontsize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[0 1.05]);
%%
plot(coordi_P2(:,1),coordi_P2(:,2),'lineWidth',2);
for i=1:6000:100000
    hold on
    plot([N_K42(i,1),0],[N_K42(i,2),y_i42(i,1)],'r','lineWidth',0.5)
end
for i=1:6000:100000
    hold on
    %    plot([coordi_Q2(i,1),coordi_Q2(i,1)-coordi_Q2(i,2)*l_inc(1,1)/l_inc(1,2)],[coordi_Q2(i,2),0])
    plot([N_K42(i,1),N_K42(i,1)-N_K42(i,2)*l_inc(1,1)/l_inc(1,2)],[N_K42(i,2),0],'y','lineWidth',0.5)
end
grid on
axis equal
set(gca,'XLim',[-10 10]);
set(gca,'YLim',[-170 -150]);

set(gca,'fontsize',12,'fontname','Times New Roman');
xlabel('X(m)','FontName','Times New Roman','FontSize',12);
ylabel('Y(m)','FontName','Times New Roman','FontSize',12);
title('Partial Enlargement','Fontsize',16,'Fontname','Times New Roman')
hold on
CData=density2C(zeros(100000,1),y_i42(:,1),-2:0.1:15,-300:6:-150);
scatter(zeros(100000,1),y_i42(:,1),'filled','CData',CData);

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