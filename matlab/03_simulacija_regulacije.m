plot(vrijeme1,ulaz,'Color', [0.5 0 0.5], 'Linewidth', 1 );
hold on;
plot(vrijeme1,izlazsum,'Color', [1 0.4 0.7], 'Linewidth', 1);
grid on;
xlabel('Vrijeme [s]');
ylim([-1 65]);
xlim([0 15]);
ylabel('Brzina vrtnje (rpm)');
legend('ulaz', 'simulacija');