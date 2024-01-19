L_Ideal=zeros(201,1);
p_Ideal=zeros(201,1);
syms Lvar
for f=-170:0.1:-150
    eqn=coordi_P(601,1)*coordi_P(601,1)/(4*(coordi_P(601,2)+300+Lvar))-Lvar==f+300;
    L_Ideal(10*f+1701,1)=vpa(max(solve(eqn,Lvar)),5);
end
%%
plot(-170:0.1:-150,L_Ideal,'linewidth',1.5)
grid on
xlabel('The Value of f','FontName','Times New Roman','FontSize',12);
ylabel('The Value of L','FontName','Times New Roman','FontSize',12);
title('Changing Trend of L with f','FontSize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
set(gca,'YLim',[-18 -7]);
%%
for i=1:1:201
    p_Ideal(i,1)=coordi_P(601,1)*coordi_P(601,1)/(2*(coordi_P(601,2)+300+L_Ideal(i,1)));
end
plot(-170:0.1:-150,p_Ideal,'linewidth',1.5)
grid on
xlabel('The Value of f','FontName','Times New Roman','FontSize',12);
ylabel('The Value of p','FontName','Times New Roman','FontSize',12);
title('Changing Trend of p with f','FontSize',16,'Fontname','Times New Roman')
set(gca,'fontsize',12,'fontname','Times New Roman');
%set(gca,'YLim',[-18 -7]);