clf;
% automatically create postscript whenever
% figure is drawn
% Joshua Weitz - 2020 - CC-BY-4.0
% Share, adapt, attribute
% 
% Code written quickly one evening, figshare version here:
% https://figshare.com/articles/COVID-19_Event_Risk_Assessment_Planner/11965533
%
% 

tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);
set(gcf,'Position', [391 192 987 763]);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');

% Approximation given low incidence

% First, draw risk lines
pcrit = @(x) 0.01./x;
USpop=330*10^6;
n=logspace(1,5,100);
pcrit_val=pcrit(n);
numcrit=pcrit_val*USpop;
tmph=loglog(n,numcrit);
set(tmph,'linewidth',3,'color','k');
hold on
risk_vals = [0.02  0.1 0.5 0.9];
for i=1:length(risk_vals),
  pcrit_risk = 1 - (1-risk_vals(i)).^(1./n);
  tmph=loglog(n,pcrit_risk*USpop,'k-');
  set(tmph,'linewidth',3);
end

% Next, draw labels near risk lines
ytarget = 100000;
pcrit_label=ytarget/USpop;
for i=1:length(risk_vals),
  nlabel = log(1-risk_vals(i))/log(1-pcrit_label);
  tmpt=text(nlabel,100000*1.4,sprintf('%d%% Chance',100*risk_vals(i)));
  set(tmpt,'fontsize',18,'rotation',-32);
end

% Now, block off bottom-left corner for <1% risk
xblock = [10 10^5 10^5 10 10];
yblock = [10 10 pcrit(10^5)*USpop pcrit(10^1)*USpop 10];
tmph=patch(xblock,yblock,[0.75 0.75 0.75]);
tmph=loglog(n,numcrit);
set(tmph,'linewidth',4,'color','k');
set(gca,'layer','top');

% And add a label
ylim([10 10^6]);
tmpt=text(50,100,{'Less than';'1\% chance of';'COVID-19';'positive attendee';'at the event'});
set(tmpt,'interpreter','latex','fontsize',18);

% Next, draw the horizontal scenarios, starting with "low"
nvec = 2000;
tmpt=text(3.75,nvec*0.85,'2,000 cases');
set(tmpt,'fontsize',14,'interpreter','latex');
tmpt=text(4.5,nvec*1.3,'Scenario:');
set(tmpt,'fontsize',14,'interpreter','latex');
sizevec=[10 100 1000 10000 100000];
tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
set(tmph,'linewidth',2,'linestyle','--');
set(tmph,'markersize',12,'markerfacecolor','b');

% For these scenarios, use the exact risk assuming homogeneity
for i=1:length(sizevec),
   p_equiv = nvec/USpop;
   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
   tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*0.6,sprintf('%3.2g%% chance',eps_equiv(i)*100));
   set(tmpt,'fontsize',14,'interpreter','latex','color','blue');
end

% Label the "high" scenario
nvec = 20000;
tmpt=text(3.5,nvec*0.85,'20,000 cases');
set(tmpt,'fontsize',14,'interpreter','latex');
tmpt=text(4.5,nvec*1.3,'Scenario:');
set(tmpt,'fontsize',14,'interpreter','latex');
sizevec=[10 100 1000 10000 100000];
tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
set(tmph,'linewidth',2,'linestyle','--');
set(tmph,'markersize',12,'markerfacecolor','b');

% Draw andd label the high scenario case
for i=1:length(sizevec),
   p_equiv = nvec/USpop;
   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
   if (i<length(sizevec))
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*0.6,sprintf('%3.2g%% chance',eps_equiv(i)*100));
   else
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*0.6,'$> 99$\% chance');
   end
   set(tmpt,'fontsize',14,'interpreter','latex','color','blue');
end

% Add some bottom labels
tmpt=text(1.5,1,{'Calculation note - J.S.Weitz - jsweitz@gatech.edu - 3/10/20 - Risk is $\epsilon \approx 1-(1-p_I)^n$ where $p_I=I/ \left(330\times 10^6\right)$ and $n$ is event size';'March 10, 2020, License: Creative Commons BY-SA 4.0, i.e., Share, Adapt, Attribute - https://creativecommons.org/licenses/by/4.0/'; 'https://figshare.com/articles/COVID-19\_Event\_Risk\_Assessment\_Planner/11965533'});
set(tmpt,'interpreter','latex','fontsize',14);

% General figure wrap-up
set(gca,'fontsize',20);
set(gca,'xtick',10.^[1:1:5]);
tmps={'10','100','1,000','10,000','100,000'};
set(gca,'xticklabel',tmps);
set(gca,'ytick',10.^[0:1:6]);
tmps={'1','10','100','1,000','10,000','100,000','1,000,000'};
set(gca,'yticklabel',tmps);
tmpsize_ideas={'Dinner party';'Wedding reception';'Small concert';'Hockey match';'March Madness'}
tmpt=text(10.^[0.65:1:4.65],ones(5,1)*3.25,tmpsize_ideas);
set(tmpt,'fontsize',18,'interpreter','latex');
tmpt=text(10^[4.65],2,'Final in Atlanta');
set(tmpt,'fontsize',18,'interpreter','latex');
%tmpt=text(500,1.5,'Size of event');
%set(tmpt,'fontsize',24,'interpreter','latex','fontweight','bold');

ylabel('Active circulating infections in the USA, $I$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
title({'COVID-19 Event Risk Assessment Planner';'Assumes Incidence Homogeneity'},'fontsize',20,'interpreter','latex')

% Get rid of temporary variables
clear tmp*
