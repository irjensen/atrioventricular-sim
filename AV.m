function out = AV(tSpace, param)
    % takes as an input a vector 'tSpace' and object 'param':
    % 'tSpace' is the vector of time values to solve for. tSpace must be
    % uniform.
    % 'param' must define the constants a,b,y,freq,SAthresh,AVthresh, and
    % pulseStrength.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % AV outputs an object containing 3 properties:
    % 'v' is the vector containing the solution for the AV potential.
    % 'w' is the vector containing the solution for the fatigue.
    % 'pulses' is an integer which counts the total number of pulses
    % conducted by the AV node.
    
    SAthresh = param.SAthresh; % minimum SA node threshold to conduct a pulse.
    AVthresh = param.AVthresh; % maximum AV node threshold to conduct a pulse.
    pulseStrength = param.pulseStrength; % potential jump when a pulse is conducted.
    a = param.a;                         %alpha constant.
    b = param.b;                         %beta constant.
    y = param.y;                         %omega constant.
    freq = param.freq;                   %frequency of SA node.
    h = tSpace(2) - tSpace(1);           %time step size.

    out.v = zeros(length(tSpace),1); % instantiate the v and w vectors.
    out.w = zeros(length(tSpace),1); 
    out.v(1) = 0;                    % initial conditions for the 
    out.w(1) = 0;                    % the v and w vectors.
    out.pulses = 0;                  % initialize the pulse counter

    f = @(t,v,w) -a*(1-w/(w+1))*v;       % equation for v prime.
    g = @(t,v,w) b*(v)-y*w;              % equation for w prime.
    SA = sin(freq*2*pi*tSpace);     % equation the describes the SA node.

    
    for i=1:(length(tSpace)-1)           % Runge Kutta
        t =  tSpace(i);

        k0 = h*f(t, out.v(i), out.w(i));
        l0 = h*g(t, out.v(i), out.w(i));
        k1 = h*f(t+0.5*h, out.v(i)+0.5*k0, out.w(i)+0.5*l0);
        l1 = h*g(t+0.5*h, out.v(i)+0.5*k0, out.w(i)+0.5*l0);
        l2 = h*g(t+0.5*h, out.v(i)+0.5*k1, out.w(i)+0.5*l1);
        k2 = h*f(t+0.5*h, out.v(i)+0.5*k1, out.w(i)+0.5*l1);
        l3 = h*g(t+h, out.v(i)+k2, out.w(i)+l2);
        k3 = h*f(t+h, out.v(i)+k2, out.w(i)+l2);

        out.v(i+1) = out.v(i) + 1.0/6 * (k0 + 2*k1 + 2*k2 + k3);
        out.w(i+1) = out.w(i) + 1.0/6 * (l0 + 2*l1 + 2*l2 + l3);

        if out.v(i)<AVthresh && SA(i)>SAthresh % pulse conditional.
            out.v(i+1) = pulseStrength;        % depolarize the AV node potential.
            out.pulses =  out.pulses + 1;      % count the conducted pulses.
        end
    end
end
