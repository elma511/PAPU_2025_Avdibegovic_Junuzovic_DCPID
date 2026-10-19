time = vrijeme;    % Vremenski vektor
data = in;      % Izlazni podaci (npr. brzina)
ulaz = out;       % Ulazni podaci (pobuda)


% Ako su podaci višedimenzionalni, smanji dimenzije
%data = squeeze(data);

% Skaliranje izlaza ako je potrebno (npr. u rpm)
data = 60 .* data;

% Izracunaj razliku ulaza da na?eš promjene (step signale)
du = diff(ulaz);
threshold = 0.1; % Prag za detekciju promjene ulaza (možeš podesiti)

% Prona?i indeks po?etka i kraja pobude
start_idx = find(abs(du) > threshold, 1, 'first') + 1;
end_idx = find(abs(du) > threshold, 1, 'last') + 1;

% Izvu?i segment vremena i izlaza u podru?ju pobude
t_segment = time(start_idx:end_idx);
d_segment = data(start_idx:end_idx);
u_segment = ulaz(start_idx:end_idx);

% Izra?un prosje?ne izlazne vrijednosti na segmentu
avg_output = 60;

% Poja?anje K kao omjer izlaza i ulaza na segmentu
K = avg_output / max(u_segment)

% Procjena vremenske konstante T, ovdje uzeto kao:
T = avg_output * 0.63 * 0.001 % prilagodi ako treba

% Definiraj prenosnu funkciju prvog reda
G = tf([K], [T, 1]);

% Definiraj ulazni signal za simulaciju (step od po?etka segmenta)
u_sim = max(u_segment) * heaviside(t_segment - t_segment(1));

% Simuliraj odziv modela na ulazni signal
simulation = lsim(G, u_sim, t_segment);

% Prikaz rezultata
figure;
plot(time, data, 'LineWidth', 0.9); hold on;
plot(t_segment, simulation, 'LineWidth', 0.9);
plot(time, ulaz, 'LineWidth', 0.9);
grid on;
legend('Snimljeni odziv', 'Identifikacija', 'Pobuda');
xlabel('Vrijeme [s]');
ylabel('Brzina [rad/s]');
title('Identifikacija prenosne funkcije prema segmentu pobude');