%% PRETPOSTAVLJENO: u workspace-u postoje varijable
%   vrijeme : vektor vremena (n×1 ili 1×n)
%   in      : izmjereni odziv motora (brzina), koji skaliraš s *60 za rpm

%% 0) Parametri pravougaonog ulaza (on/off trenuci)
t_on  = 12;       % [s] – trenutak uklju?enja
t_off = 38;       % [s] – trenutak isklju?enja

%% 1) Definiši prenosnu funkciju sustava
G = tf(60, [0.037 1]);     % static gain 60, ? = 0.037 s

%% 2) Kreiraj ulazni signal u(t): jedini?ni pravougaonik
u = zeros(size(vrijeme));
u(vrijeme >= t_on & vrijeme < t_off) = 1;   % 1 izme?u t_on i t_off

%% 3) Simuliraj odziv sustava na u(t)
y_model = lsim(G, u, vrijeme);              % ista vremenska mreža

%% 4) Crtanje pore?enja (BOJE OSTAJU ISTE)
figure;
plot(vrijeme, in*60 , 'Color',[1 0.4 0.7], 'LineWidth',1.6); hold on;
plot(vrijeme, y_model,'Color',[0.5 0   0.5], 'LineWidth',1.6);
grid on;
xlabel('Vrijeme [s]');
legend({'Izmjereni odziv - brzina vrtnje motora [rpm]', ...
        'Simulirana funkcija na step amplitude 10 [V] - napon [V]'}, 'Location','best');



