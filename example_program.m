%This program produces 40 frames of an animation showing the effect that varying the beta parameter has on the shape and behaviour of
% the AV node solution


close all

t = -20:0.01:25; % time series starts very low to allow the solution to find an equilibrium
param.freq = 1.3333333333333; % 80bpm
param.a=154;
param.b=3.0;
param.y=3.80;
param.pulseStrength=130;
param.SAthresh=0.7;
param.AVthresh=1;
out = AV(t,param);
z = sin(param.freq*2*pi*t);

%out.pulseWidth
for k =0:40
    param.b = 0.125*k;
    out = AV(t,param);
    figure
    ax1 = subplot(3,1,1);
    plot(ax1,t,out.v-90);
    xlim([0 15])
    for i=0:25
        line([1/param.freq*(i+0.25),1/param.freq*(i+0.25)],ylim,'Color','black','LineStyle','--')
    end
    title(ax1,['AV Node Potential, \beta = ' num2str(param.b)])
    ylabel(ax1,'Potential (mV)')


    ax2 = subplot(3,1,2);
    plot(ax2,t,out.w,'r')
    xlim([0 15])
    ylim([0 200])
    for i=0:25
        line([1/param.freq*(i+0.25),1/param.freq*(i+0.25)],ylim,'Color','black','LineStyle','--')
    end
    title(ax2,'Fatigue')


    ax3 = subplot(3,1,3);
    plot(ax3,t,sin(param.freq*2*pi*t),'m')
    xlim([0 15])
    ylim([-1.2 1.2])
    for i=0:25
        line([1/param.freq*(i+0.25),1/param.freq*(i+0.25)],ylim,'Color','black','LineStyle','--')
    end
    title(ax3,'SA node')
    xlabel(ax3,'time (s)')

    %savefig('2to1')
    print(['beta_gif' num2str(k)], '-dpng')
end

%plot (t,out.y,t,out.F,t,z,t,SAthresh,t,AVthresh);


