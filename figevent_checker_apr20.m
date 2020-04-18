clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figevent_checker_apr20';
tmpfilebwname = sprintf('%s_noname_bw',tmpfilename);
tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);
set(gcf,'Position', [391 192 987 763]);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');

% main data goes here
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
ytarget = 100000;
pcrit_label=ytarget/USpop;
for i=1:length(risk_vals),
  nlabel = log(1-risk_vals(i))/log(1-pcrit_label);
  tmpt=text(nlabel,100000*1.4,sprintf('%d%% Chance',100*risk_vals(i)));
  set(tmpt,'fontsize',18,'rotation',-42);
end
%tmpt=text(500,(1-(1-risk_vals(1))^(1/500))*USpop*1.5,'2% Chance');
%set(tmpt,'fontsize',18,'rotation',-30);
%tmpt=text(500,(1-(1-risk_vals(2))^(1/500))*USpop*1.5,'10% Chance');
%set(tmpt,'fontsize',18,'rotation',-30);
%tmpt=text(500,(1-(1-risk_vals(3))^(1/500))*USpop*1.5,'50% Chance');
%set(tmpt,'fontsize',18,'rotation',-30);
%tmpt=text(10000,(1-(1-0.95)^(1/10000))*USpop*1.5,'95% Chance');
%set(tmpt,'fontsize',18,'rotation',-30);

% Small patch
xblock = [10 10^5 10^5 10 10];
% yblock = [10 10 pcrit(10^5)*USpop pcrit(10^1)*USpop 10];
yblock = [10 10 pcrit(10^5)*USpop pcrit(10^1)*USpop 10];
tmph=patch(xblock,yblock,[0.75 0.75 0.75]);
tmph=loglog(n,numcrit);
set(tmph,'linewidth',4,'color','k');
set(gca,'layer','top');

% Bad patch
pcrit_bad = @(x) 0.9./x;
xblock = [10^5 2*10^5 2*10^5 10 10^5];
%% yblock = [10 10 pcrit(10^5)*USpop pcrit(10^1)*USpop 10];
yblock = [10 10 pcrit(10^5)*USpop pcrit(10^1)*USpop 10];
%tmph=patch(xblock,yblock,[0.75 0.75 0.75]);
%tmph=loglog(n,numcrit);
%set(tmph,'linewidth',4,'color','k');
%set(gca,'layer','top');
%pvec=logspace(-8,-1,100);
%[nmesh pmesh]=meshgrid(n,pvec);
%p_covid_pos = 1-(exp(-pmesh.*nmesh));
%contour(n,pvec*USpop,p_covid_pos,);
ylim([10^4 3*10^7]);
tmpt=text(12,30000,{'Less than';'1\% chance of';'COVID-19';'positive attendee';'at the event'});
set(tmpt,'interpreter','latex','fontsize',18);
%tmpt=text(3000,20000,{'Greater than';'1\% chance';'of COVID-19 positive';'attendee'});
%set(tmpt,'interpreter','latex','fontsize',18);

% Connectors
%nvec = 2000;
%tmpt=text(3.75,nvec*0.85,'2,000 cases');
%set(tmpt,'fontsize',14,'interpreter','latex');
%rtmpt=text(4.5,nvec*1.3,'Scenario:');
%set(tmpt,'fontsize',14,'interpreter','latex');
%sizevec=[10 100 1000 10000 100000];
%tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
%set(tmph,'linewidth',2,'linestyle','--');
%set(tmph,'markersize',12,'markerfacecolor','b');
%for i=1:length(sizevec),
%   p_equiv = nvec/USpop;
%   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
%   tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*0.6,sprintf('%3.2g%% chance',eps_equiv(i)*100));
%   set(tmpt,'fontsize',14,'interpreter','latex','color','blue','backgroundcolor',[0.8 0.8 0.8],'edgecolor','k');
%end

% Connectors
nvec = 8000000;
tmpt=text(4,nvec*0.75,'8 million');
set(tmpt,'fontsize',14,'interpreter','latex');
tmpt=text(4.5,nvec*0.95,'Scenario:');
set(tmpt,'fontsize',14,'interpreter','latex');
sizevec=[10 100 1000 10000 100000];
tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
set(tmph,'linewidth',2,'linestyle','--');
set(tmph,'markersize',12,'markerfacecolor','b');

for i=1:length(sizevec),
   p_equiv = nvec/USpop;
   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
   if (i<length(sizevec)-2)
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,sprintf('%3.2g%% chance',eps_equiv(i)*100));
   else
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,'$> 99$\% chance');
   end
   set(tmpt,'fontsize',14,'interpreter','latex','color','blue','backgroundcolor',[0.8 0.8 0.8],'edgecolor','k');
end

% Connectors
nvec = 2000000;
tmpt=text(4,nvec*0.95,'2 million');
set(tmpt,'fontsize',14,'interpreter','latex');
tmpt=text(4.5,nvec*1.3,'Scenario:');
set(tmpt,'fontsize',14,'interpreter','latex');
sizevec=[10 100 1000 10000 100000];
tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
set(tmph,'linewidth',2,'linestyle','--');
set(tmph,'markersize',12,'markerfacecolor','b');

for i=1:length(sizevec),
   p_equiv = nvec/USpop;
   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
   if (i<length(sizevec)-2)
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,sprintf('%3.2g%% chance',eps_equiv(i)*100));
   else
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,'$> 99$\% chance');
   end
   set(tmpt,'fontsize',14,'interpreter','latex','color','blue','backgroundcolor',[0.8 0.8 0.8],'edgecolor','k');
end

% Connectors
nvec = 400000;
tmpt=text(4.5,nvec*.95,'400,000');
set(tmpt,'fontsize',14,'interpreter','latex');
tmpt=text(4.5,nvec*1.3,'Scenario:');
set(tmpt,'fontsize',14,'interpreter','latex');
sizevec=[10 100 1000 10000 100000];
tmph=loglog(sizevec,nvec*ones(size(sizevec)),'ko-');
set(tmph,'linewidth',2,'linestyle','--');
set(tmph,'markersize',12,'markerfacecolor','b');

for i=1:length(sizevec),
   p_equiv = nvec/USpop;
   eps_equiv(i) = 1-(1-p_equiv).^sizevec(i);
   if (i<length(sizevec)-1)
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,sprintf('%3.2g%% chance',eps_equiv(i)*100));
   else
     tmpt=text(sizevec(i)*(1-0.08*(i-1)),nvec*1.4,'$> 99$\% chance');
   end
   set(tmpt,'fontsize',14,'interpreter','latex','color','blue','backgroundcolor',[0.8 0.8 0.8],'edgecolor','k');
end
%  ncur = nvec(i);
%  ncorner = [10 ncur ncur];
%  Icorner = [USpop*0.01/ncur USpop*0.01/ncur 10];
%  tmph=loglog(ncorner,Icorner,'k--');
%  set(tmph,'linewidth',2);
%  tmph=loglog(ncur,USpop*0.01/ncur,'ko');
%  set(tmph,'markersize',12,'markerfacecolor','k');
%end

tmpt=text(4.5,2000,{'Calculation note - J.S.Weitz - jsweitz@gatech.edu - 4/18/20 - Risk is $\epsilon \approx 1-(1-p_I)^n$ where $p_I=I/ \left(330\times 10^6\right)$ and $n$ is event size';'Updated: April 18, 2020, License: Creative Commons BY-SA 4.0, i.e., Share, Adapt, Attribute';'Assumes incidence homogeneity, uses last 2 weeks cumulative as baseline with 5x and 20x undercounts for alternative scenarios';
'Code https://github.com/jsweitz/covid-19-event-risk-planner'});
set(tmpt,'interpreter','latex','fontsize',14);
%hold on;
%pcrit=0.01./n;
%numcrit=pcrit*325*10^6;
%tmph=loglog(n,numcrit);
%set(tmph,'linewidth',3,'color','g');
%pcrit=0.001./n;
%numcrit=pcrit*325*10^6;
%tmph=loglog(n,numcrit);
%set(tmph,'linewidth',3,'color','c');
% loglog(,, '');
%
%
% Some helpful plot commands
% tmph=plot(x,y,'ko');
% set(tmph,'markersize',10,'markerfacecolor,'k');
% tmph=plot(x,y,'k-');
% set(tmph,'linewidth',2);

set(gca,'fontsize',20);

% for use with layered plots
% set(gca,'box','off')

% adjust limits
% tmpv = axis;
% axis([]);
% ylim([]);
% xlim([]);

% change axis line width (default is 0.5)
% set(tmpa1,'linewidth',2)

% fix up tickmarks
set(gca,'xtick',10.^[1:1:5]);
tmps={'10','100','1,000','10,000','100,000'};
set(gca,'xticklabel',tmps);
set(gca,'ytick',10.^[0:1:7]);
tmps={'1','10','100','1,000','10,000','100,000','1,000,000','10,000,000'};
set(gca,'yticklabel',tmps);
tmpsize_ideas={'Dinner party';'Wedding reception';'Small concert';'Soccer match';'Indy 500'}
tmpt=text(10.^[0.65:1:4.65],ones(5,1)*5*1000,tmpsize_ideas);
set(tmpt,'fontsize',18,'interpreter','latex');
tmpt=text(10^[4.65],2,'Final in Atlanta');
set(tmpt,'fontsize',18,'interpreter','latex');
%tmpt=text(500,1.5,'Size of event');
%set(tmpt,'fontsize',24,'interpreter','latex','fontweight','bold');

% set(gca,'ytick',[1 100 10^4])

% creation of postscript for papers
% psprint(tmpxfigfilename);

% the following will usually not be printed 
% in good copy for papers
% (except for legend without labels)

% legend
% tmplh = legend('stuff',...);
% tmplh = legend('','','');
% remove box
% set(tmplh,'visible','off')
% legend('boxoff');

%xlabel('Size of event','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Active circulating infections in the USA, $I$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
title({'COVID-19 Event Risk Assessment Planner - Updated April 18, 2020';'Estimates chance that one or more individuals are COVID-19 positive at an event';'given event size (x-axis) and current case prevalence (y-axis)'},'fontsize',20,'interpreter','latex')
% 'horizontalalignment','left');

% for writing over the top
% coordinates are normalized again to (0,1.0)
tmpa2 = axes('Position', tmppos);
set(tmpa2,'visible','off');
% first two points are normalized x, y positions
% text(,,'','Fontsize',14);

% automatic creation of postscript
% without name/date
psprintc(tmpfilenoname);
psprint(tmpfilebwname);

tmpt = pwd;
tmpnamememo = sprintf('[source=%s/%s.ps]',tmpt,tmpprintname);
text(1.05,.05,tmpnamememo,'Fontsize',6,'rotation',90);
datenamer(1.1,.05,90);
% datename(.5,.05);
% datename2(.5,.05); % 2 rows

% automatic creation of postscript
psprintc(tmpfilename);

% set following on if zooming of 
% plots is required
% may need to get legend up as well
%axes(tmpa1)
%axes(tmplh)
clear tmp*
