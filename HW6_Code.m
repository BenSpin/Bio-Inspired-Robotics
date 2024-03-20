clc
clear all
close all

pivoting = true; % same torque for claw tendons
pulling = true; % same torque for finger tendons
scanning = true;


%% Pivoting
if pivoting
    % one degree of motion --> theta
    m = [0:1:10]; %kg
    m_sub = [0:.1:5];
    theta_dd = 0.015 ; %rad/s^2
    li = 0.04; % m --> 4cm
    u = .42;
    g= 9.8;
    F_fric = u*m_sub*g;
    p = pi;
    
    figure
    Torque_sub = (theta_dd * (m_sub*li^2)) + F_fric*li;
    plot(m_sub, Torque_sub);
    xlabel("Mass (kg)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Robot Mass for Pivoting")
    
    F_fric = u*m*g;
    Torque = (theta_dd * (m*li^2) + F_fric*li);
    current = [0:.1:10];
    figure
    labels = [];
    for i = Torque
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(i)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Pivoting Torque Constant vs Current")
    legend(labels)
end

%% Pulling
if pulling
    % one degree of motion --> q
    m_rod = .5; % kg
    m = [0:1:5]; % kg
    m_sub = [0:.1:5];
    l = .5; % m
    q_dd = 0.01 ; %m/s^2
    li = 0.04; % m
    q = [0:.1:0.5]; % m
    u = .42;
    g= 9.8;
    F_fric = u*m_sub*g;
    r = .01; % m --> 0.5cm
    
    figure
    Torque_sub = r .* ((m_sub.*q_dd) + F_fric);
    plot(m_sub, Torque_sub);
    xlabel("Mass (kg)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Robot Mass for Pulling")
    

    F_fric = u*m*g;
    Torque = r .* ((m.*q_dd) + F_fric);
    current = [0:.1:10];
    figure
    labels = [];
    for i = Torque
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(i)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Pulling Torque Constant vs Current")
    legend(labels)

end

%% Sweeping Rotation
if scanning
    m_rod = .5; % kg
    m_finger = .05; % kg
    l_rod = [.04:.1:.5]; % m
    theta_dd = .015;

    Torque = ((1/3 .* m_rod .* l_rod.^2) + (m_finger .* l_rod.^2)) .* theta_dd;
    figure
    plot(l_rod, Torque)
    xlabel("Arm Length (m)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Arm Length for Scanning")

    current = [0:.1:10];
    figure
    labels = [];
    for i = l_rod
        Torque = ((1/3 .* m_rod .* l_rod.^2) + (m_finger .* l_rod.^2)) .* theta_dd;
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(Torque)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Scanning Torque Constant vs Current")
    legend(labels)

end










