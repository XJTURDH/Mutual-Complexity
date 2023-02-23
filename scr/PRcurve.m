function PRcurve(com,pr,pe,size)
[recall,precision]=AP_sort(com,pe);
figure();
plot(recall(:),precision(:),'^-','color','[0,0,0]','markersize',5,'linewidth',2);
hold on;
plot(pr(:,1),pr(:,2),'.-','color','[1,0,0]','markersize',26,'linewidth',2);
hold on;
set(gca,'FontName','Times New Roman','FontSize',22);
set(gcf,'Position',[100 100 750 650]);
legend('COM_{PVO}','COM_{M}');
grid on;
set(gca,'xlim',[0 1],'xtick',0:0.1:1);
xlabel('Recall');
ylabel('Precision');

if size==2
    title('2\times2');
    set(gca,'ylim',[0.24 0.42],'ytick',0.24:0.02:0.42);
    saveas(gca,'results/accuracy2.eps','epsc');
    saveas(gcf,'results/accuracy2.jpg');
    set(gcf,'paperpositionmode','auto');
elseif size==3
    title('3\times3');
    set(gca,'ylim',[0.28 0.46],'ytick',0.28:0.02:0.46);
    saveas(gca,'results/accuracy3.eps','epsc');
    saveas(gcf,'results/accuracy3.jpg');
    set(gcf,'paperpositionmode','auto');
elseif size==4
    title('4\times4');
    set(gca,'ylim',[0.29 0.44],'ytick',0.29:0.02:0.44);
    saveas(gca,'results/accuracy4.eps','epsc');
    saveas(gcf,'results/accuracy4.jpg');
    set(gcf,'paperpositionmode','auto');
elseif size==5
    title('5\times5');
    set(gca,'ylim',[0.3 0.46],'ytick',0.3:0.02:0.46);
    saveas(gca,'results/accuracy5.eps','epsc');
    saveas(gcf,'results/accuracy5.jpg');
    set(gcf,'paperpositionmode','auto');
end


