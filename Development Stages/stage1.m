%% Creating a ping pong table design using figure()

% Create a black background figure with fixed size
figure('Color', 'black', 'Position', [250, 200, 800, 600],'Name','Ping Pong: Single Player',NumberTitle='off');  % [x, y, width, height]

% Create an axes to hold the game elements
ax = axes('Color', 'none', 'Position', [0, 0, 1, 1]);

% Create dashed line through the center using the plot function
x = [0.5, 0.5];
y = [0,1 ];
set(line(ax, x, y, 'LineStyle', '--', 'Color', [0.5, 0.5, 0.5]),'LineWidth',2);
set(line(ax, [0, 1], [0.9, 0.9], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);
set(line(ax, [0, 1], [0.1, 0.1], 'LineStyle', '-', 'Color', [1, 1, 1]),'LineWidth',2);

set(line(ax, [0.5, 0.5], [0.9, 1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);
set(line(ax, [0.5, 0.5], [0, 0.1], 'LineStyle', '-', 'Color', [0, 0, 0]),'LineWidth',2);

% instructions
annotation('textbox', [0.25, 0, 0.5, 0.1], 'String','Use ↑ and ↓ to control your paddle', 'Color', 'white', 'LineStyle', 'none', 'FontSize', 14, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontName','Consolas');
